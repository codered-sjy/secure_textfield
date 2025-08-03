import 'dart:ui' show PointerDeviceKind;

import 'package:flutter/gestures.dart' show kSecondaryMouseButton;
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:secure_textfield/secure_textfield.dart';

void main() {
  group('SecureTextField', () {
    testWidgets('should render without errors', (WidgetTester tester) async {
      await tester.pumpWidget(
        const MaterialApp(home: Scaffold(body: SecureTextField())),
      );

      expect(find.byType(SecureTextField), findsOne);
      expect(find.byType(TextField), findsOne);
    });

    testWidgets('should display placeholder text', (WidgetTester tester) async {
      const placeholderText = 'Enter text here';

      await tester.pumpWidget(
        const MaterialApp(
          home: Scaffold(
            body: SecureTextField(
              decoration: InputDecoration(hintText: placeholderText),
            ),
          ),
        ),
      );

      expect(find.text(placeholderText), findsOne);
    });

    testWidgets('should accept text input', (WidgetTester tester) async {
      const testText = 'Hello World';
      final controller = TextEditingController();
      addTearDown(controller.dispose);

      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(body: SecureTextField(controller: controller)),
        ),
      );

      await tester.enterText(find.byType(TextField), testText);
      expect(controller.text, equals(testText));
    });

    testWidgets('should call onChanged callback', (WidgetTester tester) async {
      String? changedText;
      const testText = 'Test input';

      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: SecureTextField(
              onChanged: (value) {
                changedText = value;
              },
            ),
          ),
        ),
      );

      await tester.enterText(find.byType(TextField), testText);
      expect(changedText, equals(testText));
    });

    testWidgets('should have interactive selection disabled', (
      WidgetTester tester,
    ) async {
      await tester.pumpWidget(
        const MaterialApp(home: Scaffold(body: SecureTextField())),
      );

      final textField = tester.widget<TextField>(find.byType(TextField));
      expect(textField.enableInteractiveSelection, isFalse);
    });

    testWidgets('should support obscureText', (WidgetTester tester) async {
      await tester.pumpWidget(
        const MaterialApp(
          home: Scaffold(body: SecureTextField(obscureText: true)),
        ),
      );

      final textField = tester.widget<TextField>(find.byType(TextField));
      expect(textField.obscureText, isTrue);
    });

    testWidgets('should support maxLength', (WidgetTester tester) async {
      const maxLength = 10;

      await tester.pumpWidget(
        const MaterialApp(
          home: Scaffold(body: SecureTextField(maxLength: maxLength)),
        ),
      );

      final textField = tester.widget<TextField>(find.byType(TextField));
      expect(textField.maxLength, equals(maxLength));
    });

    testWidgets('should handle keyboard type', (WidgetTester tester) async {
      const keyboardType = TextInputType.emailAddress;

      await tester.pumpWidget(
        const MaterialApp(
          home: Scaffold(body: SecureTextField(keyboardType: keyboardType)),
        ),
      );

      final textField = tester.widget<TextField>(find.byType(TextField));
      expect(textField.keyboardType, equals(keyboardType));
    });

    testWidgets('should handle text alignment', (WidgetTester tester) async {
      const textAlign = TextAlign.center;

      await tester.pumpWidget(
        const MaterialApp(
          home: Scaffold(body: SecureTextField(textAlign: textAlign)),
        ),
      );

      final textField = tester.widget<TextField>(find.byType(TextField));
      expect(textField.textAlign, equals(textAlign));
    });

    testWidgets('should handle enabled state', (WidgetTester tester) async {
      await tester.pumpWidget(
        const MaterialApp(
          home: Scaffold(body: SecureTextField(enabled: false)),
        ),
      );

      final textField = tester.widget<TextField>(find.byType(TextField));
      expect(textField.enabled, isFalse);
    });

    testWidgets('should handle readOnly state', (WidgetTester tester) async {
      await tester.pumpWidget(
        const MaterialApp(
          home: Scaffold(body: SecureTextField(readOnly: true)),
        ),
      );

      final textField = tester.widget<TextField>(find.byType(TextField));
      expect(textField.readOnly, isTrue);
    });

    testWidgets('should handle multiline text', (WidgetTester tester) async {
      const maxLines = 3;

      await tester.pumpWidget(
        const MaterialApp(
          home: Scaffold(body: SecureTextField(maxLines: maxLines)),
        ),
      );

      final textField = tester.widget<TextField>(find.byType(TextField));
      expect(textField.maxLines, equals(maxLines));
    });

    testWidgets('should have context menu builder', (
      WidgetTester tester,
    ) async {
      await tester.pumpWidget(
        const MaterialApp(home: Scaffold(body: SecureTextField())),
      );

      final textField = tester.widget<TextField>(find.byType(TextField));
      expect(textField.contextMenuBuilder, isNotNull);
    });

    testWidgets('should unfocus on right-click (secondary mouse button)', (
      WidgetTester tester,
    ) async {
      final focusNode = FocusNode();
      addTearDown(focusNode.dispose);

      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(body: SecureTextField(focusNode: focusNode)),
        ),
      );

      await tester.tap(find.byType(TextField));
      await tester.pumpAndSettle();
      expect(focusNode.hasFocus, isTrue);

      final gesture = await tester.createGesture(
        kind: PointerDeviceKind.mouse,
        buttons: kSecondaryMouseButton,
      );
      await gesture.down(tester.getCenter(find.byType(TextField)));
      await tester.pumpAndSettle();

      expect(
        focusNode.hasFocus,
        isFalse,
        reason: 'Focus should be lost after right-click',
      );

      await gesture.up();
    });

    testWidgets('should not unfocus on left-click and maintain focus', (
      WidgetTester tester,
    ) async {
      final focusNode = FocusNode();
      addTearDown(focusNode.dispose);

      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(body: SecureTextField(focusNode: focusNode)),
        ),
      );

      await tester.tap(find.byType(TextField));
      await tester.pumpAndSettle();
      expect(focusNode.hasFocus, isTrue);

      await tester.tap(find.byType(TextField));
      await tester.pumpAndSettle();

      expect(
        focusNode.hasFocus,
        isTrue,
        reason: 'Focus should remain after left-click',
      );
    });

    testWidgets('should not unfocus on touch events and preserve focus', (
      WidgetTester tester,
    ) async {
      final focusNode = FocusNode();
      addTearDown(focusNode.dispose);

      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(body: SecureTextField(focusNode: focusNode)),
        ),
      );

      await tester.tap(find.byType(TextField));
      await tester.pumpAndSettle();
      expect(focusNode.hasFocus, isTrue);

      final gesture = await tester.createGesture(kind: PointerDeviceKind.touch);
      await gesture.down(tester.getCenter(find.byType(TextField)));
      await tester.pumpAndSettle();

      expect(
        focusNode.hasFocus,
        isTrue,
        reason: 'Focus should remain after touch event',
      );

      await gesture.up();
    });

    testWidgets(
      'should unfocus currently focused widget when right-clicking SecureTextField',
      (WidgetTester tester) async {
        final secureTextFieldFocusNode = FocusNode();
        addTearDown(secureTextFieldFocusNode.dispose);

        await tester.pumpWidget(
          MaterialApp(
            home: Scaffold(
              body: Column(
                children: [
                  SecureTextField(focusNode: secureTextFieldFocusNode),
                  const SizedBox(height: 50),
                  const Text('Other widget'),
                ],
              ),
            ),
          ),
        );

        await tester.tap(find.byType(TextField));
        await tester.pumpAndSettle();
        expect(secureTextFieldFocusNode.hasFocus, isTrue);

        final gesture = await tester.createGesture(
          kind: PointerDeviceKind.mouse,
          buttons: kSecondaryMouseButton,
        );
        await gesture.down(tester.getCenter(find.byType(SecureTextField)));
        await tester.pumpAndSettle();

        expect(
          secureTextFieldFocusNode.hasFocus,
          isFalse,
          reason: 'Focus should be lost after right-click',
        );

        await gesture.up();
      },
    );
  });
}
