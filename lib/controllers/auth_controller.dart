/**
 * NOMBRE DEL EQUIPO: SISTEMA DE TIENDA EN LINEA, EQUIPO 7 
 * AUTOR DEL ARCHIVO: LÓPEZ RUÍZ ANGEL
 * FECHA>: 06-02-2026
 */


import 'package:flutter/material.dart';
import '../models/usuario_model.dart';
import '../services/auth_service.dart';

class AuthController {
  final AuthService _authService = AuthService();
  final ValueNotifier<bool> isLoading = ValueNotifier<bool>(false);
  UsuarioModel? currentUser;

  Future<bool> login(String email, String password, BuildContext context) async {
    isLoading.value = true; 

    try { 
      final usuario = await _authService.login(email, password);

      if (usuario != null) {
        currentUser = usuario;
        return true;
      }
    } catch (e) {
      print('Error capturado en Controller: $e');
    } finally { 
      isLoading.value = false; 
    }
    
    return false;
  }
}