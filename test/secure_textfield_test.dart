import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:secure_textfield/secure_textfield.dart';

void main() {
  group('SecureTextField', () {
    testWidgets('should render without errors', (WidgetTester tester) async {
      await tester.pumpWidget(
        const MaterialApp(home: Scaffold(body: SecureTextField())),
      );

      expect(find.byType(SecureTextField), findsOneWidget);
      expect(find.byType(TextField), findsOneWidget);
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

      expect(find.text(placeholderText), findsOneWidget);
    });

    testWidgets('should accept text input', (WidgetTester tester) async {
      const testText = 'Hello World';
      final controller = TextEditingController();

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
  });

  group('PlatformHandler', () {
    test('should create appropriate platform handler', () {
      final handler = PlatformHandler();
      expect(handler, isA<PlatformHandler>());
      expect(handler.shouldBlockCopyPaste(), isTrue);
    });

    test('WebPlatformHandler should block copy/paste shortcuts', () {
      final handler = WebPlatformHandler();

      expect(handler.shouldBlockCopyPaste(), isTrue);
      expect(
        handler.handleKeyboardShortcut(
          key: 'c',
          isCtrlPressed: true,
          isCmdPressed: false,
        ),
        isTrue,
      );
      expect(
        handler.handleKeyboardShortcut(
          key: 'v',
          isCtrlPressed: true,
          isCmdPressed: false,
        ),
        isTrue,
      );
      expect(
        handler.handleKeyboardShortcut(
          key: 'x',
          isCtrlPressed: true,
          isCmdPressed: false,
        ),
        isTrue,
      );
      expect(
        handler.handleKeyboardShortcut(
          key: 'a',
          isCtrlPressed: true,
          isCmdPressed: false,
        ),
        isTrue,
      );
      expect(
        handler.handleKeyboardShortcut(
          key: 'z',
          isCtrlPressed: true,
          isCmdPressed: false,
        ),
        isFalse,
      );
      expect(
        handler.handleKeyboardShortcut(
          key: 'c',
          isCtrlPressed: false,
          isCmdPressed: false,
        ),
        isFalse,
      );
    });

    test('IOSPlatformHandler should block copy/paste shortcuts', () {
      final handler = IOSPlatformHandler();

      expect(handler.shouldBlockCopyPaste(), isTrue);
      expect(
        handler.handleKeyboardShortcut(
          key: 'c',
          isCtrlPressed: false,
          isCmdPressed: true,
        ),
        isTrue,
      );
      expect(
        handler.handleKeyboardShortcut(
          key: 'v',
          isCtrlPressed: false,
          isCmdPressed: true,
        ),
        isTrue,
      );
      expect(
        handler.handleKeyboardShortcut(
          key: 'x',
          isCtrlPressed: false,
          isCmdPressed: true,
        ),
        isTrue,
      );
      expect(
        handler.handleKeyboardShortcut(
          key: 'a',
          isCtrlPressed: false,
          isCmdPressed: true,
        ),
        isTrue,
      );
      expect(
        handler.handleKeyboardShortcut(
          key: 'z',
          isCtrlPressed: false,
          isCmdPressed: true,
        ),
        isFalse,
      );
      expect(
        handler.handleKeyboardShortcut(
          key: 'c',
          isCtrlPressed: false,
          isCmdPressed: false,
        ),
        isFalse,
      );
    });

    test('AndroidPlatformHandler should block copy/paste shortcuts', () {
      final handler = AndroidPlatformHandler();

      expect(handler.shouldBlockCopyPaste(), isTrue);
      expect(
        handler.handleKeyboardShortcut(
          key: 'c',
          isCtrlPressed: true,
          isCmdPressed: false,
        ),
        isTrue,
      );
      expect(
        handler.handleKeyboardShortcut(
          key: 'v',
          isCtrlPressed: true,
          isCmdPressed: false,
        ),
        isTrue,
      );
      expect(
        handler.handleKeyboardShortcut(
          key: 'x',
          isCtrlPressed: true,
          isCmdPressed: false,
        ),
        isTrue,
      );
      expect(
        handler.handleKeyboardShortcut(
          key: 'a',
          isCtrlPressed: true,
          isCmdPressed: false,
        ),
        isTrue,
      );
      expect(
        handler.handleKeyboardShortcut(
          key: 'z',
          isCtrlPressed: true,
          isCmdPressed: false,
        ),
        isFalse,
      );
      expect(
        handler.handleKeyboardShortcut(
          key: 'c',
          isCtrlPressed: false,
          isCmdPressed: false,
        ),
        isFalse,
      );
    });

    test('DefaultPlatformHandler should block copy/paste shortcuts', () {
      final handler = DefaultPlatformHandler();

      expect(handler.shouldBlockCopyPaste(), isTrue);
      expect(
        handler.handleKeyboardShortcut(
          key: 'c',
          isCtrlPressed: true,
          isCmdPressed: false,
        ),
        isTrue,
      );
      expect(
        handler.handleKeyboardShortcut(
          key: 'v',
          isCtrlPressed: true,
          isCmdPressed: false,
        ),
        isTrue,
      );
      expect(
        handler.handleKeyboardShortcut(
          key: 'x',
          isCtrlPressed: true,
          isCmdPressed: false,
        ),
        isTrue,
      );
      expect(
        handler.handleKeyboardShortcut(
          key: 'a',
          isCtrlPressed: true,
          isCmdPressed: false,
        ),
        isTrue,
      );
      expect(
        handler.handleKeyboardShortcut(
          key: 'z',
          isCtrlPressed: true,
          isCmdPressed: false,
        ),
        isFalse,
      );
      expect(
        handler.handleKeyboardShortcut(
          key: 'c',
          isCtrlPressed: false,
          isCmdPressed: false,
        ),
        isFalse,
      );
    });
  });
}
