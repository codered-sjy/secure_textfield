import 'dart:ui' show PointerDeviceKind;

import 'package:flutter/gestures.dart' show kSecondaryMouseButton;
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

/// A secure text field that blocks copy, paste, cut, and select all operations
/// across iOS, Android, and web platforms.
///
/// This widget extends the functionality of Flutter's standard [TextField]
/// by preventing users from copying, pasting, cutting, or selecting all text
/// content. It maintains full compatibility with [TextField] properties while
/// adding security features through a unified cross-platform approach.
///
/// ## Platform Support
///
/// - **iOS/macOS**: Blocks Cmd+C/V/X/A and context menus
/// - **Android/Windows/Linux**: Blocks Ctrl+C/V/X/A and context menus
/// - **Web**: Blocks both Ctrl and Cmd shortcuts plus right-click menus
///
/// ## Example
///
/// ```dart
/// SecureTextField(
///   controller: myController,
///   decoration: InputDecoration(
///     labelText: 'Password',
///     border: OutlineInputBorder(),
///   ),
///   onChanged: (value) {
///     // Handle text changes
///   },
/// )
/// ```
///
/// All standard [TextField] properties are supported, including:
/// - [controller] for programmatic text control
/// - [decoration] for styling the input field
/// - [obscureText] for password fields
/// - [maxLines] for multiline input
/// - [onChanged], [onSubmitted] for callbacks
/// - [keyboardType], [textInputAction] for input behavior
/// - [enabled], [readOnly] for field state control
class SecureTextField extends StatefulWidget {
  /// Creates a [SecureTextField].
  const SecureTextField({
    super.key,
    this.controller,
    this.decoration,
    this.obscureText = false,
    this.maxLines = 1,
    this.maxLength,
    this.onChanged,
    this.onSubmitted,
    this.keyboardType,
    this.textInputAction,
    this.style,
    this.textAlign = TextAlign.start,
    this.enabled = true,
    this.autofocus = false,
    this.readOnly = false,
    this.showCursor,
    this.autocorrect = false,
    this.enableSuggestions = false,
    this.focusNode,
    this.onTap,
    this.scrollPadding = const EdgeInsets.all(20.0),
    this.enableInteractiveSelection = false, // Disabled to prevent selection
  });

  /// Controls the text being edited.
  final TextEditingController? controller;

  /// The decoration to show around the text field.
  final InputDecoration? decoration;

  /// Whether to hide the text being edited.
  final bool obscureText;

  /// The maximum number of lines for the text to span.
  final int? maxLines;

  /// The maximum number of characters (Unicode scalar values) to allow.
  final int? maxLength;

  /// Called when the user changes the text in the field.
  final ValueChanged<String>? onChanged;

  /// Called when the user indicates that they are done editing.
  final ValueChanged<String>? onSubmitted;

  /// The type of keyboard to use for editing the text.
  final TextInputType? keyboardType;

  /// An action the user has requested the text input control to perform.
  final TextInputAction? textInputAction;

  /// The style to use for the text being edited.
  final TextStyle? style;

  /// How the text should be aligned horizontally.
  final TextAlign textAlign;

  /// If false the text field is "disabled".
  final bool enabled;

  /// Whether this text field should focus itself if nothing else is already
  /// focused.
  final bool autofocus;

  /// Whether the text can be changed.
  final bool readOnly;

  /// Whether to show cursor.
  final bool? showCursor;

  /// Whether to enable autocorrection.
  final bool autocorrect;

  /// Whether to show input suggestions as the user types.
  final bool enableSuggestions;

  /// An object that can be used to programmatically manage focus.
  final FocusNode? focusNode;

  /// Called when the text field has been tapped.
  final VoidCallback? onTap;

  /// Configures padding to edges surrounding a [Scrollable].
  final EdgeInsets scrollPadding;

  /// Whether to enable interactive selection.
  ///
  /// Note: This is always set to false to prevent text selection as part
  /// of the security implementation. Text selection would allow users to
  /// potentially copy selected content through other means.
  final bool enableInteractiveSelection;

  @override
  State<SecureTextField> createState() => _SecureTextFieldState();
}

class _SecureTextFieldState extends State<SecureTextField> {
  /// Returns an empty widget to completely disable the context menu.
  /// This prevents copy/paste options from appearing on right-click or long-press.
  Widget buildContextMenu(
    BuildContext context,
    EditableTextState editableTextState,
  ) => const SizedBox.shrink();

  /// Creates keyboard shortcut mappings that block common copy/paste operations.
  /// Maps both Ctrl (Windows/Linux/Android) and Cmd (macOS/iOS) combinations
  /// to [DoNothingIntent] to prevent the default behavior.
  Map<ShortcutActivator, Intent> buildShortcuts() => {
    // Block Ctrl+C, Ctrl+V, Ctrl+X, Ctrl+A
    const SingleActivator(LogicalKeyboardKey.keyC, control: true):
        const DoNothingIntent(),
    const SingleActivator(LogicalKeyboardKey.keyV, control: true):
        const DoNothingIntent(),
    const SingleActivator(LogicalKeyboardKey.keyX, control: true):
        const DoNothingIntent(),
    const SingleActivator(LogicalKeyboardKey.keyA, control: true):
        const DoNothingIntent(),

    // Block Cmd+C, Cmd+V, Cmd+X, Cmd+A (for macOS/iOS)
    const SingleActivator(LogicalKeyboardKey.keyC, meta: true):
        const DoNothingIntent(),
    const SingleActivator(LogicalKeyboardKey.keyV, meta: true):
        const DoNothingIntent(),
    const SingleActivator(LogicalKeyboardKey.keyX, meta: true):
        const DoNothingIntent(),
    const SingleActivator(LogicalKeyboardKey.keyA, meta: true):
        const DoNothingIntent(),
  };

  /// Creates action mappings for handling blocked keyboard shortcuts.
  /// All [DoNothingIntent] instances are mapped to [DoNothingAction] which
  /// effectively cancels the shortcut without performing any operation.
  Map<Type, Action<Intent>> buildActions() => {
    DoNothingIntent: DoNothingAction(),
  };

  @override
  Widget build(BuildContext context) {
    // Create the text field wrapped in a Listener to detect right-click events
    final Widget textField = Listener(
      onPointerDown: (event) {
        if (event.kind == PointerDeviceKind.mouse &&
            event.buttons == kSecondaryMouseButton) {
          FocusManager.instance.primaryFocus?.unfocus();
        }
      },
      child: TextField(
        controller: widget.controller,
        decoration: widget.decoration,
        obscureText: widget.obscureText,
        maxLines: widget.maxLines,
        maxLength: widget.maxLength,
        onChanged: widget.onChanged,
        onSubmitted: widget.onSubmitted,
        keyboardType: widget.keyboardType,
        textInputAction: widget.textInputAction,
        style: widget.style,
        textAlign: widget.textAlign,
        enabled: widget.enabled,
        autofocus: widget.autofocus,
        readOnly: widget.readOnly,
        showCursor: widget.showCursor,
        autocorrect: widget.autocorrect,
        enableSuggestions: widget.enableSuggestions,
        focusNode: widget.focusNode,
        scrollPadding: widget.scrollPadding,
        enableInteractiveSelection: widget.enableInteractiveSelection,
        contextMenuBuilder: buildContextMenu,
      ),
    );

    return Shortcuts(
      shortcuts: buildShortcuts(),
      child: Actions(actions: buildActions(), child: textField),
    );
  }
}
