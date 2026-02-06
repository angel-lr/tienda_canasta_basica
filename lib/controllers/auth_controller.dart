import 'package:flutter/material.dart';
import '../models/usuario_model.dart';
import '../services/auth_service.dart';

class AuthController {
  final AuthService _authService = AuthService();
  final ValueNotifier<bool> isLoading = ValueNotifier<bool>(false);
  UsuarioModel? currentUser;

  Future<bool> login(String email, String password, BuildContext context) async {
    isLoading.value = true; // 1. Empieza a cargar

    try {
      // 2. Intentamos el login
      final usuario = await _authService.login(email, password);

      if (usuario != null) {
        currentUser = usuario;
        return true;
      }
    } catch (e) {
      print('Error capturado en Controller: $e');
    } finally {
      // 3. ESTO SE EJECUTA SIEMPRE, incluso si hay error
      isLoading.value = false; 
    }
    
    return false; // Si llegamos aquí, falló
  }
}