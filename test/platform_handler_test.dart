import 'package:flutter_test/flutter_test.dart';
import 'package:secure_textfield/src/platform_specific/platform_handler.dart';

void main() {
  group('Platform Handler Tests', () {
    group('WebPlatformHandler', () {
      late WebPlatformHandler handler;

      setUp(() {
        handler = WebPlatformHandler();
      });

      test('should block copy/paste operations', () {
        expect(handler.shouldBlockCopyPaste(), isTrue);
      });

      test('should block Ctrl+C shortcut', () {
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
            key: 'C',
            isCtrlPressed: true,
            isCmdPressed: false,
          ),
          isTrue,
        );
      });

      test('should block Ctrl+V shortcut', () {
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
            key: 'V',
            isCtrlPressed: true,
            isCmdPressed: false,
          ),
          isTrue,
        );
      });

      test('should block Ctrl+X shortcut', () {
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
            key: 'X',
            isCtrlPressed: true,
            isCmdPressed: false,
          ),
          isTrue,
        );
      });

      test('should block Ctrl+A shortcut', () {
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
            key: 'A',
            isCtrlPressed: true,
            isCmdPressed: false,
          ),
          isTrue,
        );
      });

      test('should allow other Ctrl shortcuts', () {
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
            key: 'y',
            isCtrlPressed: true,
            isCmdPressed: false,
          ),
          isFalse,
        );
        expect(
          handler.handleKeyboardShortcut(
            key: 's',
            isCtrlPressed: true,
            isCmdPressed: false,
          ),
          isFalse,
        );
      });

      test('should allow shortcuts without modifier keys', () {
        expect(
          handler.handleKeyboardShortcut(
            key: 'c',
            isCtrlPressed: false,
            isCmdPressed: false,
          ),
          isFalse,
        );
        expect(
          handler.handleKeyboardShortcut(
            key: 'v',
            isCtrlPressed: false,
            isCmdPressed: false,
          ),
          isFalse,
        );
        expect(
          handler.handleKeyboardShortcut(
            key: 'x',
            isCtrlPressed: false,
            isCmdPressed: false,
          ),
          isFalse,
        );
        expect(
          handler.handleKeyboardShortcut(
            key: 'a',
            isCtrlPressed: false,
            isCmdPressed: false,
          ),
          isFalse,
        );
      });

      test('should handle Cmd shortcuts on web', () {
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
      });
    });

    group('IOSPlatformHandler', () {
      late IOSPlatformHandler handler;

      setUp(() {
        handler = IOSPlatformHandler();
      });

      test('should block copy/paste operations', () {
        expect(handler.shouldBlockCopyPaste(), isTrue);
      });

      test('should block Cmd+C shortcut', () {
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
            key: 'C',
            isCtrlPressed: false,
            isCmdPressed: true,
          ),
          isTrue,
        );
      });

      test('should block Cmd+V shortcut', () {
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
            key: 'V',
            isCtrlPressed: false,
            isCmdPressed: true,
          ),
          isTrue,
        );
      });

      test('should block Cmd+X shortcut', () {
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
            key: 'X',
            isCtrlPressed: false,
            isCmdPressed: true,
          ),
          isTrue,
        );
      });

      test('should block Cmd+A shortcut', () {
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
            key: 'A',
            isCtrlPressed: false,
            isCmdPressed: true,
          ),
          isTrue,
        );
      });

      test('should allow other Cmd shortcuts', () {
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
            key: 'y',
            isCtrlPressed: false,
            isCmdPressed: true,
          ),
          isFalse,
        );
        expect(
          handler.handleKeyboardShortcut(
            key: 's',
            isCtrlPressed: false,
            isCmdPressed: true,
          ),
          isFalse,
        );
      });

      test('should allow Ctrl shortcuts on iOS', () {
        expect(
          handler.handleKeyboardShortcut(
            key: 'c',
            isCtrlPressed: true,
            isCmdPressed: false,
          ),
          isFalse,
        );
        expect(
          handler.handleKeyboardShortcut(
            key: 'v',
            isCtrlPressed: true,
            isCmdPressed: false,
          ),
          isFalse,
        );
        expect(
          handler.handleKeyboardShortcut(
            key: 'x',
            isCtrlPressed: true,
            isCmdPressed: false,
          ),
          isFalse,
        );
        expect(
          handler.handleKeyboardShortcut(
            key: 'a',
            isCtrlPressed: true,
            isCmdPressed: false,
          ),
          isFalse,
        );
      });

      test('should allow shortcuts without modifier keys', () {
        expect(
          handler.handleKeyboardShortcut(
            key: 'c',
            isCtrlPressed: false,
            isCmdPressed: false,
          ),
          isFalse,
        );
        expect(
          handler.handleKeyboardShortcut(
            key: 'v',
            isCtrlPressed: false,
            isCmdPressed: false,
          ),
          isFalse,
        );
        expect(
          handler.handleKeyboardShortcut(
            key: 'x',
            isCtrlPressed: false,
            isCmdPressed: false,
          ),
          isFalse,
        );
        expect(
          handler.handleKeyboardShortcut(
            key: 'a',
            isCtrlPressed: false,
            isCmdPressed: false,
          ),
          isFalse,
        );
      });
    });

    group('AndroidPlatformHandler', () {
      late AndroidPlatformHandler handler;

      setUp(() {
        handler = AndroidPlatformHandler();
      });

      test('should block copy/paste operations', () {
        expect(handler.shouldBlockCopyPaste(), isTrue);
      });

      test('should block Ctrl+C shortcut', () {
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
            key: 'C',
            isCtrlPressed: true,
            isCmdPressed: false,
          ),
          isTrue,
        );
      });

      test('should block Ctrl+V shortcut', () {
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
            key: 'V',
            isCtrlPressed: true,
            isCmdPressed: false,
          ),
          isTrue,
        );
      });

      test('should block Ctrl+X shortcut', () {
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
            key: 'X',
            isCtrlPressed: true,
            isCmdPressed: false,
          ),
          isTrue,
        );
      });

      test('should block Ctrl+A shortcut', () {
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
            key: 'A',
            isCtrlPressed: true,
            isCmdPressed: false,
          ),
          isTrue,
        );
      });

      test('should allow other Ctrl shortcuts', () {
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
            key: 'y',
            isCtrlPressed: true,
            isCmdPressed: false,
          ),
          isFalse,
        );
        expect(
          handler.handleKeyboardShortcut(
            key: 's',
            isCtrlPressed: true,
            isCmdPressed: false,
          ),
          isFalse,
        );
      });

      test('should allow shortcuts without modifier keys', () {
        expect(
          handler.handleKeyboardShortcut(
            key: 'c',
            isCtrlPressed: false,
            isCmdPressed: false,
          ),
          isFalse,
        );
        expect(
          handler.handleKeyboardShortcut(
            key: 'v',
            isCtrlPressed: false,
            isCmdPressed: false,
          ),
          isFalse,
        );
        expect(
          handler.handleKeyboardShortcut(
            key: 'x',
            isCtrlPressed: false,
            isCmdPressed: false,
          ),
          isFalse,
        );
        expect(
          handler.handleKeyboardShortcut(
            key: 'a',
            isCtrlPressed: false,
            isCmdPressed: false,
          ),
          isFalse,
        );
      });

      test('should allow Cmd shortcuts on Android', () {
        expect(
          handler.handleKeyboardShortcut(
            key: 'c',
            isCtrlPressed: false,
            isCmdPressed: true,
          ),
          isFalse,
        );
        expect(
          handler.handleKeyboardShortcut(
            key: 'v',
            isCtrlPressed: false,
            isCmdPressed: true,
          ),
          isFalse,
        );
        expect(
          handler.handleKeyboardShortcut(
            key: 'x',
            isCtrlPressed: false,
            isCmdPressed: true,
          ),
          isFalse,
        );
        expect(
          handler.handleKeyboardShortcut(
            key: 'a',
            isCtrlPressed: false,
            isCmdPressed: true,
          ),
          isFalse,
        );
      });
    });

    group('DefaultPlatformHandler', () {
      late DefaultPlatformHandler handler;

      setUp(() {
        handler = DefaultPlatformHandler();
      });

      test('should block copy/paste operations', () {
        expect(handler.shouldBlockCopyPaste(), isTrue);
      });

      test('should block both Ctrl and Cmd shortcuts', () {
        // Test Ctrl shortcuts
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

        // Test Cmd shortcuts
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
      });

      test('should handle case insensitive keys', () {
        expect(
          handler.handleKeyboardShortcut(
            key: 'C',
            isCtrlPressed: true,
            isCmdPressed: false,
          ),
          isTrue,
        );
        expect(
          handler.handleKeyboardShortcut(
            key: 'V',
            isCtrlPressed: true,
            isCmdPressed: false,
          ),
          isTrue,
        );
        expect(
          handler.handleKeyboardShortcut(
            key: 'X',
            isCtrlPressed: true,
            isCmdPressed: false,
          ),
          isTrue,
        );
        expect(
          handler.handleKeyboardShortcut(
            key: 'A',
            isCtrlPressed: true,
            isCmdPressed: false,
          ),
          isTrue,
        );
      });

      test('should allow other modifier key combinations', () {
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
            key: 'y',
            isCtrlPressed: false,
            isCmdPressed: true,
          ),
          isFalse,
        );
        expect(
          handler.handleKeyboardShortcut(
            key: 's',
            isCtrlPressed: true,
            isCmdPressed: true,
          ),
          isFalse,
        );
      });

      test('should allow shortcuts without any modifier keys', () {
        expect(
          handler.handleKeyboardShortcut(
            key: 'c',
            isCtrlPressed: false,
            isCmdPressed: false,
          ),
          isFalse,
        );
        expect(
          handler.handleKeyboardShortcut(
            key: 'v',
            isCtrlPressed: false,
            isCmdPressed: false,
          ),
          isFalse,
        );
        expect(
          handler.handleKeyboardShortcut(
            key: 'x',
            isCtrlPressed: false,
            isCmdPressed: false,
          ),
          isFalse,
        );
        expect(
          handler.handleKeyboardShortcut(
            key: 'a',
            isCtrlPressed: false,
            isCmdPressed: false,
          ),
          isFalse,
        );
      });
    });

    group('PlatformHandler Factory', () {
      test('should create platform handler instance', () {
        final handler = PlatformHandler();
        expect(handler, isA<PlatformHandler>());
        expect(handler.shouldBlockCopyPaste(), isTrue);
      });

      test('factory should return concrete implementation', () {
        final handler = PlatformHandler();
        expect(handler, isNotNull);

        // Should be able to call interface methods
        final shouldBlock = handler.shouldBlockCopyPaste();
        expect(shouldBlock, isA<bool>());

        final shortcutResult = handler.handleKeyboardShortcut(
          key: 'c',
          isCtrlPressed: true,
          isCmdPressed: false,
        );
        expect(shortcutResult, isA<bool>());
      });
    });
  });
}
