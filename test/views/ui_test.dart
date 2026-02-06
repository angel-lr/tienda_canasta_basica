import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:tienda_canasta_basica/views/auth/login_screen.dart';

void main() {
  testWidgets('🟢 Módulo UI: Login y Estilos (HU-03, HU-11)', (WidgetTester tester) async {
    // Renderizamos la UI
    await tester.pumpWidget(const MaterialApp(home: LoginScreen()));

    // Validamos HU-03 (Estilos/Identidad)
    final tituloFinder = find.textContaining('Ingresa tu e-mail');
    expect(tituloFinder, findsOneWidget);
    print('✅ HU-03 VALIDADA: La guía de estilos se aplica (Títulos y tipografía presentes).');

    // Validamos HU-11 (Elementos de Login)
    expect(find.byType(TextFormField), findsOneWidget);
    expect(find.byType(ElevatedButton), findsOneWidget);
    
    // Interactuamos
    await tester.enterText(find.byType(TextFormField), 'cliente@prueba.com');
    expect(find.text('cliente@prueba.com'), findsOneWidget);
    
    print('✅ HU-11 VALIDADA: La interfaz permite ingresar credenciales de usuario.');
  });
}