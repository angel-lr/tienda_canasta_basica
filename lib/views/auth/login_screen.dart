/**
 * NOMBRE DEL EQUIPO: SISTEMA DE TIENDA EN LINEA, EQUIPO 7 
 * AUTOR DEL ARCHIVO: CRUZ LÓPEZ PEDRO
 * FECHA>: 06-02-2026
 */


import 'package:flutter/material.dart';
import '../../controllers/auth_controller.dart'; 

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> { 
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
   
  final _formKey = GlobalKey<FormState>(); 
  final AuthController _authController = AuthController(); 

  bool _isEmailStep = true;

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }
 
  void _handleNextStep() async { 
    if (!_formKey.currentState!.validate()) return;

    if (_isEmailStep) { 
      setState(() => _isEmailStep = false);
    } else { 
       
      FocusScope.of(context).unfocus();
      // llamado al backeend
      bool exito = await _authController.login(
        _emailController.text.trim(),
        _passwordController.text.trim(),
        context
      );
 
      if (!mounted) return;

      if (exito) { 
        ScaffoldMessenger.of(context).showSnackBar(
           SnackBar(
            content: Text('¡Bienvenido ${_authController.currentUser?.nombre}!'),
            backgroundColor: Colors.green,
            behavior: SnackBarBehavior.floating,  
          )
        ); 

      } else { 
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('Error: Usuario no encontrado o contraseña incorrecta.'),
            backgroundColor: Colors.red,
            behavior: SnackBarBehavior.floating,
          ),
        ); 
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[100], 
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        centerTitle: true,
        leading: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Image.asset('assets/icon/logo.png', errorBuilder: (context, error, stackTrace) => const Icon(Icons.store)), 
        ),
        bottom: PreferredSize(
          preferredSize: const Size.fromHeight(1.0),
          child: Container(
            color: Colors.grey.withOpacity(0.3),
            height: 1.0,
          ),
        ),
      ),
      body: Center(
        child: Container(
          // Restricción de ancho para que se vea bien en Linux
          constraints: const BoxConstraints(maxWidth: 900),
          padding: const EdgeInsets.symmetric(horizontal: 50.0),
          child: Row(
            children: [ 
              Expanded(
                flex: 1,
                child: Padding(
                  padding: const EdgeInsets.only(right: 40.0),
                  child: AnimatedSwitcher(
                    duration: const Duration(milliseconds: 400),
                    child: Text(
                      _isEmailStep
                          ? "Ingresa tu e-mail para iniciar sesión en la tienda"
                          : "Ahora, ingresa tu contraseña de seguridad",
                      key: ValueKey(_isEmailStep),
                      style: const TextStyle(
                        fontSize: 28,  
                        fontWeight: FontWeight.w600,
                        color: Color(0xFF3F4784),
                        fontFamily: 'Segoe UI',  
                      ),
                    ),
                  ),
                ),
              ),
 
              Expanded(
                flex: 1,
                child: Container(
                  padding: const EdgeInsets.all(40.0),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(20),
                    border: Border.all(color: Colors.grey.shade300),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withOpacity(0.08),
                        blurRadius: 20,
                        offset: const Offset(0, 10),
                      ),
                    ],
                  ),
                  child: Form(
                    key: _formKey,
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [ 
                        Align(
                          alignment: Alignment.centerLeft,
                          child: Text(
                            _isEmailStep ? "Correo Electrónico" : "Contraseña",
                            style: TextStyle(
                              fontSize: 14,
                              color: Colors.grey[700],
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                        const SizedBox(height: 10),

                        // Campo de texto con animación
                        AnimatedSwitcher(
                          duration: const Duration(milliseconds: 300),
                          transitionBuilder: (Widget child, Animation<double> animation) {
                            return FadeTransition(opacity: animation, child: child);
                          },
                          child: _isEmailStep
                              ? _buildEmailField()
                              : _buildPasswordField(),
                        ),

                        const SizedBox(height: 30),

                        // Botón de Acción con Estado de Carga 
                        ValueListenableBuilder<bool>(
                          valueListenable: _authController.isLoading,
                          builder: (context, isLoading, child) {
                            return SizedBox(
                              width: double.infinity,
                              height: 50, // Altura fija cómoda para el mouse
                              child: ElevatedButton(
                                onPressed: isLoading ? null : _handleNextStep,
                                style: ElevatedButton.styleFrom(
                                  backgroundColor: const Color(0xFF23255D),
                                  foregroundColor: Colors.white,
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(10),
                                  ),
                                  elevation: 2,
                                ),
                                child: isLoading
                                  ? const SizedBox(
                                      height: 24, 
                                      width: 24, 
                                      child: CircularProgressIndicator(
                                        color: Colors.white, 
                                        strokeWidth: 2.5
                                      )
                                    )
                                  : Text(
                                      _isEmailStep ? 'Continuar' : 'Iniciar Sesión',
                                      style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                                    ),
                              ),
                            );
                          },
                        ),

                        const SizedBox(height: 20),
 
                        if (_isEmailStep)
                          TextButton(
                            onPressed: () { 
                            },
                            child: const Text("Crear cuenta nueva", style: TextStyle(color: Color(0xFF23255D))),
                          )
                        else
                          TextButton(
                            onPressed: () => setState(() => _isEmailStep = true),
                            child: const Text("Usar otro correo", style: TextStyle(color: Colors.grey)),
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

  // Constructor del campo Email
  Widget _buildEmailField() {
    return TextFormField(
      key: const ValueKey('emailField'),
      controller: _emailController,
      autofocus: true,
      decoration: InputDecoration(
        hintText: 'ejemplo@correo.com',
        contentPadding: const EdgeInsets.symmetric(horizontal: 20, vertical: 18),
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
        prefixIcon: const Icon(Icons.email_outlined),
        filled: true,
        fillColor: Colors.grey[50],
      ),
      keyboardType: TextInputType.emailAddress,
      validator: (value) {
        if (value == null || value.isEmpty) return 'Por favor ingresa tu correo';
        if (!value.contains('@')) return 'Ingresa un correo válido';
        return null;
      },
      onFieldSubmitted: (_) => _handleNextStep(), 
    );
  }

  // Constructor del campo Password
  Widget _buildPasswordField() {
    return TextFormField(
      key: const ValueKey('passField'),
      controller: _passwordController,
      autofocus: true,
      obscureText: true,
      decoration: InputDecoration(
        hintText: '••••••••',
        contentPadding: const EdgeInsets.symmetric(horizontal: 20, vertical: 18),
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
        prefixIcon: const Icon(Icons.lock_outline),
        filled: true,
        fillColor: Colors.grey[50],
      ),
      validator: (value) {
        if (value == null || value.isEmpty) return 'Ingresa tu contraseña';
        return null;
      },
      onFieldSubmitted: (_) => _handleNextStep(), 
    );
  }
}