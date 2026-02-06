import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:tienda_canasta_basica/views/auth/login_screen.dart';

void main() {
  testWidgets('HU-11 y HU-03: Verificar interfaz de Login y Estilos', (WidgetTester tester) async {
    // 1. Renderizar la pantalla (envuelta en MaterialApp para estilos)
    await tester.pumpWidget(const MaterialApp(
      home: LoginScreen(),
    ));

    // 2. HU-03: Verificar que el título o logo existen (Parte de la identidad visual)
    // Buscamos el texto que definiste en tu UI dinámica
    expect(find.textContaining('Ingresa tu e-mail'), findsOneWidget);

    // 3. HU-11: Verificar campo de Email
    expect(find.byType(TextFormField), findsOneWidget, reason: "Debe haber un campo para el correo");
    expect(find.widgetWithText(ElevatedButton, 'Continuar'), findsOneWidget, reason: "Debe existir el botón de acción");

    // 4. Simulación de interacción (Flujo de Login)
    // Escribir correo
    await tester.enterText(find.byType(TextFormField), 'cliente@test.com');
    await tester.pump();

    // Validar que el texto se escribió
    expect(find.text('cliente@test.com'), findsOneWidget);
  });
}