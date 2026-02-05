import 'package:flutter/material.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  final _formKey = GlobalKey<FormState>();

  // Estado de la lógica
  bool _isEmailStep = true;

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  void _handleNextStep() {
    if (_formKey.currentState!.validate()) {
      if (_isEmailStep) {
        setState(() => _isEmailStep = false);
      } else {
        ScaffoldMessenger.of(
          context,
        ).showSnackBar(const SnackBar(content: Text('Iniciando sesión...')));
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation:
            0, // Opcional: elimina la sombra por defecto para un look más flat
        centerTitle: true,
        leading: Padding(
          padding: const EdgeInsets.all(8.0), // Ajusta el espacio
          child: Image.asset(
            'assets/logo.jpg',
          ), // O Image.network('url')
        ),
        actions: [IconButton(icon: const Icon(Icons.search), onPressed: () {})],
        // --- AQUÍ ESTÁ EL TRUCO ---
        bottom: PreferredSize(
          preferredSize: const Size.fromHeight(1.0), // Altura de la línea
          child: Container(
            color: Colors.grey.withOpacity(0.3), // Color de la línea
            height: 2.0, // Grosor de la línea
          ),
        ),
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 50.0),
          child: Row(
            children: [
              // COLUMNA IZQUIERDA: Texto dinámico
              Expanded(
                flex: 1,
                child: Padding(
                  padding: const EdgeInsets.only(right: 40.0),
                  child: AnimatedSwitcher(
                    duration: const Duration(milliseconds: 400),
                    child: Text(
                      _isEmailStep
                          ? "Ingresa tu e-mail o teléfono para iniciar sesión"
                          : "Ahora, ingresa tu contraseña para continuar",
                      key: ValueKey(_isEmailStep),
                      style: const TextStyle(
                        fontSize: 26,
                        fontWeight: FontWeight.w500,
                        color: Color(0xFF3F4784),
                      ),
                    ),
                  ),
                ),
              ),

              // COLUMNA DERECHA: La Tarjeta con lógica de pasos
              Expanded(
                flex: 1,
                child: Container(
                  padding: const EdgeInsets.all(35.0),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(20),
                    border: Border.all(color: Colors.grey.shade300),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withOpacity(0.05),
                        blurRadius: 10,
                        offset: const Offset(0, 4),
                      ),
                    ],
                  ),
                  child: Form(
                    key: _formKey,
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        // Label superior dinámico
                        Align(
                          alignment: Alignment.centerLeft,
                          child: Text(
                            _isEmailStep ? "E-mail o teléfono" : "Contraseña",
                            style: TextStyle(
                              fontSize: 13,
                              color: Colors.grey[600],
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                        const SizedBox(height: 8),

                        // Input con animación de cambio
                        AnimatedSwitcher(
                          duration: const Duration(milliseconds: 300),
                          child: _isEmailStep
                              ? _buildEmailField()
                              : _buildPasswordField(),
                        ),

                        const SizedBox(height: 25),

                        // Botón principal
                        SizedBox(
                          width: double.infinity,
                          child: ElevatedButton(
                            onPressed: _handleNextStep,
                            style: ElevatedButton.styleFrom(
                              backgroundColor: const Color(0xFF23255D),
                              foregroundColor: Colors.white,
                              padding: const EdgeInsets.symmetric(vertical: 18),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(10),
                              ),
                              elevation: 0,
                            ),
                            child: Text(
                              _isEmailStep ? 'Continuar' : 'Iniciar Sesión',
                            ),
                          ),
                        ),

                        // Opciones secundarias
                        const SizedBox(height: 15),
                        if (_isEmailStep)
                          TextButton(
                            onPressed: () {},
                            child: const Text(
                              "Crear cuenta",
                              style: TextStyle(color: Color(0xFF23255D)),
                            ),
                          )
                        else
                          TextButton(
                            onPressed: () =>
                                setState(() => _isEmailStep = true),
                            child: const Text(
                              "Usar otro correo",
                              style: TextStyle(color: Colors.grey),
                            ),
                          ),

                        const SizedBox(height: 10),

                        // Botón de Google (solo visible en el primer paso para limpiar la interfaz)
                        if (_isEmailStep)
                          OutlinedButton.icon(
                            onPressed: () {},
                            icon: const Icon(
                              Icons.g_mobiledata,
                              color: Colors.red,
                              size: 30,
                            ),
                            label: const Text(
                              "Acceder con Google",
                              style: TextStyle(color: Colors.black54),
                            ),
                            style: OutlinedButton.styleFrom(
                              minimumSize: const Size(double.infinity, 50),
                              side: BorderSide(color: Colors.grey.shade300),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(8),
                              ),
                            ),
                          ),
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildEmailField() {
    return TextFormField(
      key: const ValueKey('emailField'),
      controller: _emailController,
      decoration: InputDecoration(
        hintText: 'ejemplo@correo.com',
        contentPadding: const EdgeInsets.symmetric(
          horizontal: 15,
          vertical: 15,
        ),
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(8)),
        prefixIcon: const Icon(Icons.email_outlined),
      ),
      keyboardType: TextInputType.emailAddress,
      validator: (value) {
        if (value == null || value.isEmpty) return 'Ingresa tu correo';
        if (!value.contains('@')) return 'Correo no válido';
        return null;
      },
    );
  }

  Widget _buildPasswordField() {
    return TextFormField(
      key: const ValueKey('passField'),
      controller: _passwordController,
      obscureText: true,
      decoration: InputDecoration(
        hintText: 'Tu contraseña',
        contentPadding: const EdgeInsets.symmetric(
          horizontal: 15,
          vertical: 15,
        ),
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(8)),
        prefixIcon: const Icon(Icons.lock_outline),
      ),
      validator: (value) {
        if (value == null || value.isEmpty) return 'Ingresa tu contraseña';
        if (value.length < 6) return 'Mínimo 6 caracteres';
        return null;
      },
    );
  }
}
