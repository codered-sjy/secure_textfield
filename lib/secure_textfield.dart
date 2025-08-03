/// Secure TextField Package
///
/// A Flutter package providing a TextField widget that blocks copy, paste, cut,
/// and select all operations across iOS, Android, and web platforms.
///
/// The main export is [SecureTextField], which extends Flutter's standard
/// TextField functionality while preventing common clipboard operations
/// through keyboard shortcuts and context menus.
library;

import 'package:secure_textfield/secure_textfield.dart' show SecureTextField;
import 'package:secure_textfield/src/secure_text_field.dart'
    show SecureTextField;

export 'src/secure_text_field.dart';
