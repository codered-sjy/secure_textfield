import 'package:flutter/foundation.dart' show kIsWeb;
import 'package:universal_io/io.dart' show Platform;

/// Abstract class defining platform-specific behavior for blocking copy/paste
abstract class PlatformHandler {
  /// Factory constructor to create appropriate platform handler
  factory PlatformHandler() {
    if (kIsWeb) {
      return WebPlatformHandler();
    } else if (Platform.isIOS) {
      return IOSPlatformHandler();
    } else if (Platform.isAndroid) {
      return AndroidPlatformHandler();
    } else {
      return DefaultPlatformHandler();
    }
  }

  /// Checks if copy/paste operations should be blocked
  bool shouldBlockCopyPaste();

  /// Platform-specific method to handle keyboard shortcuts
  bool handleKeyboardShortcut({
    required String key,
    required bool isCtrlPressed,
    required bool isCmdPressed,
  });
}

/// Web platform implementation
class WebPlatformHandler implements PlatformHandler {
  @override
  bool shouldBlockCopyPaste() => true;

  @override
  bool handleKeyboardShortcut({
    required String key,
    required bool isCtrlPressed,
    required bool isCmdPressed,
  }) {
    // Block Ctrl+C, Ctrl+V, Ctrl+X, Ctrl+A on web
    if (isCtrlPressed || isCmdPressed) {
      return const ['c', 'v', 'x', 'a'].contains(key.toLowerCase());
    }
    return false;
  }
}

/// iOS platform implementation
class IOSPlatformHandler implements PlatformHandler {
  @override
  bool shouldBlockCopyPaste() => true;

  @override
  bool handleKeyboardShortcut({
    required String key,
    required bool isCtrlPressed,
    required bool isCmdPressed,
  }) {
    // Block Cmd+C, Cmd+V, Cmd+X, Cmd+A on iOS
    if (isCmdPressed) {
      return const ['c', 'v', 'x', 'a'].contains(key.toLowerCase());
    }
    return false;
  }
}

/// Android platform implementation
class AndroidPlatformHandler implements PlatformHandler {
  @override
  bool shouldBlockCopyPaste() => true;

  @override
  bool handleKeyboardShortcut({
    required String key,
    required bool isCtrlPressed,
    required bool isCmdPressed,
  }) {
    // Block Ctrl+C, Ctrl+V, Ctrl+X, Ctrl+A on Android
    if (isCtrlPressed) {
      return const ['c', 'v', 'x', 'a'].contains(key.toLowerCase());
    }
    return false;
  }
}

/// Default platform implementation (fallback)
class DefaultPlatformHandler implements PlatformHandler {
  @override
  bool shouldBlockCopyPaste() => true;

  @override
  bool handleKeyboardShortcut({
    required String key,
    required bool isCtrlPressed,
    required bool isCmdPressed,
  }) {
    // Block common shortcuts on unknown platforms
    if (isCtrlPressed || isCmdPressed) {
      return const ['c', 'v', 'x', 'a'].contains(key.toLowerCase());
    }
    return false;
  }
}
