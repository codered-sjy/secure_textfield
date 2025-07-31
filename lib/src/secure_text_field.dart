import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'platform_specific/platform_handler.dart';

/// A secure text field that blocks copy, paste, cut, and select all operations
/// across iOS, Android, and web platforms.
///
/// This widget extends the functionality of Flutter's standard [TextField]
/// by preventing users from copying, pasting, cutting, or selecting all text
/// content. It maintains full compatibility with [TextField] properties while
/// adding security features.
///
/// ## Platform Support
///
/// - **iOS**: Blocks Cmd+C, Cmd+V, Cmd+X, Cmd+A and context menus
/// - **Android**: Blocks Ctrl+C, Ctrl+V, Ctrl+X, Ctrl+A and long-press menus
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
///   obscureText: true,
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
    this.autocorrect = true,
    this.enableSuggestions = true,
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
  final bool enableInteractiveSelection;

  @override
  State<SecureTextField> createState() => _SecureTextFieldState();
}

class _SecureTextFieldState extends State<SecureTextField> {
  late final PlatformHandler _platformHandler;

  @override
  void initState() {
    super.initState();
    _platformHandler = PlatformHandler();
  }

  /// Handles keyboard shortcuts and blocks copy/paste operations
  bool _handleKeyEvent(KeyEvent event) {
    if (event is KeyDownEvent) {
      final isCtrlPressed = HardwareKeyboard.instance.isControlPressed;
      final isCmdPressed = HardwareKeyboard.instance.isMetaPressed;
      final key = event.logicalKey.keyLabel;

      if (_platformHandler.handleKeyboardShortcut(
        key: key,
        isCtrlPressed: isCtrlPressed,
        isCmdPressed: isCmdPressed,
      )) {
        // Block the event by returning true
        return true;
      }
    }
    return false;
  }

  /// Return an empty container to disable context menu
  Widget _buildContextMenu(
    BuildContext context,
    EditableTextState editableTextState,
  ) => const SizedBox.shrink();

  @override
  Widget build(BuildContext context) => Focus(
    onKeyEvent: (node, event) {
      if (_handleKeyEvent(event)) {
        return KeyEventResult.handled;
      }
      return KeyEventResult.ignored;
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
      onTap: widget.onTap,
      scrollPadding: widget.scrollPadding,
      enableInteractiveSelection: widget.enableInteractiveSelection,
      contextMenuBuilder: _buildContextMenu,
    ),
  );
}
