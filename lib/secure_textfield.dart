/// A Flutter package that provides a secure text field widget
/// blocking copy/paste functionality across iOS, Android, and web platforms.
/// 
/// This library exports the main [SecureTextField] widget and related classes
/// for creating text input fields that prevent users from copying, pasting,
/// cutting, or selecting all text content.
/// 
/// ## Features
/// 
/// - Cross-platform support (iOS, Android, Web)
/// - Blocks copy, paste, cut, and select all operations
/// - Platform-specific keyboard shortcut prevention
/// - Context menu blocking
/// - Full TextField API compatibility
/// 
/// ## Usage
/// 
/// ```dart
/// import 'package:secure_textfield/secure_textfield.dart';
/// 
/// SecureTextField(
///   decoration: InputDecoration(
///     labelText: 'Secure Input',
///     hintText: 'Copy/paste is blocked here',
///   ),
///   onChanged: (value) => print('Text: $value'),
/// )
/// ```
library;

import 'package:secure_textfield/secure_textfield.dart' show SecureTextField;
import 'package:secure_textfield/src/secure_text_field.dart' show SecureTextField;

export 'src/platform_specific/platform_handler.dart';
export 'src/secure_text_field.dart';
