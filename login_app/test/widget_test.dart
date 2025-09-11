import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:login_app/main.dart';
import 'package:login_app/login_page.dart';
import 'package:login_app/home_page.dart';

void main() {
  testWidgets('App carga la pantalla de login', (WidgetTester tester) async {
    // Construye nuestra app y la renderiza
    await tester.pumpWidget(MyApp());

    // Verifica que la pantalla de login aparece
    expect(find.byType(LoginPage), findsOneWidget);
    expect(find.text('Inicio de Sesión'), findsOneWidget);
    expect(find.text('Iniciar Sesión'), findsOneWidget);
  });

  testWidgets('Formulario de login muestra errores si está vacío', (
    WidgetTester tester,
  ) async {
    await tester.pumpWidget(MyApp());

    // Presiona el botón de login sin llenar nada
    await tester.tap(find.text('Iniciar Sesión'));
    await tester.pump();

    // Valida que aparezcan los mensajes de error
    expect(find.text('Ingresa tu correo'), findsOneWidget);
    expect(find.text('Ingresa tu contraseña'), findsOneWidget);
  });

  testWidgets('Formulario de login navega a HomePage con datos correctos', (
    WidgetTester tester,
  ) async {
    await tester.pumpWidget(MyApp());

    // Ingresa correo y contraseña válidos
    await tester.enterText(
      find.byType(TextFormField).at(0),
      'test@example.com',
    );
    await tester.enterText(find.byType(TextFormField).at(1), '123456');

    // Presiona login
    await tester.tap(find.text('Iniciar Sesión'));
    await tester.pumpAndSettle();

    // Verifica que navega a HomePage
    expect(find.byType(HomePage), findsOneWidget);
    expect(find.text('¡Hola, test@example.com!'), findsOneWidget);
  });
}
