# Secure TextField

A Flutter package that provides a secure text field widget which blocks copy, paste, cut, and select all operations across iOS, Android, and web platforms.

## Features

✅ **Cross-platform support**: Works on iOS, Android, and web browsers  
✅ **Comprehensive blocking**: Prevents copy, paste, cut, and select all operations  
✅ **Keyboard shortcuts prevention**: Blocks Ctrl+C/V/X/A and Cmd+C/V/X/A  
✅ **Context menu blocking**: Disables right-click and long-press context menus  
✅ **All TextField features**: Supports all standard TextField properties and callbacks  
✅ **Platform-specific handling**: Optimized behavior for each platform  
✅ **Comprehensive testing**: High test coverage with unit and widget tests  

## Getting started

Add the package to your `pubspec.yaml`:

```yaml
dependencies:
  secure_textfield: ^0.1.0
```

Then run:

```bash
flutter pub get
```

## Usage

Import the package and use `SecureTextField` instead of the standard `TextField`:

```dart
import 'package:flutter/material.dart';
import 'package:secure_textfield/secure_textfield.dart';

class MyWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return SecureTextField(
      decoration: InputDecoration(
        labelText: 'Secure Input',
        hintText: 'Copy/paste is blocked here',
        border: OutlineInputBorder(),
      ),
      onChanged: (value) {
        print('Text changed: $value');
      },
    );
  }
}
```

### Password Field Example

```dart
SecureTextField(
  obscureText: true,
  decoration: InputDecoration(
    labelText: 'Password',
    prefixIcon: Icon(Icons.lock),
    border: OutlineInputBorder(),
  ),
)
```

### Multiline Example

```dart
SecureTextField(
  maxLines: 4,
  decoration: InputDecoration(
    labelText: 'Comments',
    hintText: 'Enter your comments here...',
    border: OutlineInputBorder(),
    alignLabelWithHint: true,
  ),
)
```

### With Controller

```dart
final TextEditingController controller = TextEditingController();

SecureTextField(
  controller: controller,
  decoration: InputDecoration(
    labelText: 'Controlled Input',
    border: OutlineInputBorder(),
  ),
  onSubmitted: (value) {
    print('Submitted: $value');
  },
)
```

## Supported Properties

`SecureTextField` supports all the same properties as Flutter's standard `TextField`:

- `controller`: TextEditingController for managing text
- `decoration`: InputDecoration for styling
- `obscureText`: Hide text input (for passwords)
- `maxLines`: Number of lines (1 for single line, null for unlimited)
- `maxLength`: Maximum character count
- `onChanged`: Callback when text changes
- `onSubmitted`: Callback when user submits
- `keyboardType`: Type of keyboard to show
- `textInputAction`: Action button on keyboard
- `style`: Text styling
- `textAlign`: Text alignment
- `enabled`: Enable/disable the field
- `autofocus`: Auto-focus on widget creation
- `readOnly`: Make field read-only
- `focusNode`: Custom focus management
- And many more...

## Platform-Specific Behavior

### iOS
- Blocks Cmd+C, Cmd+V, Cmd+X, Cmd+A keyboard shortcuts
- Disables long-press context menu
- Prevents text selection gestures

### Android
- Blocks Ctrl+C, Ctrl+V, Ctrl+X, Ctrl+A keyboard shortcuts
- Disables long-press context menu
- Prevents text selection handles

### Web
- Blocks both Ctrl and Cmd keyboard shortcuts
- Disables right-click context menu
- Prevents browser's built-in copy/paste functionality

## Example App

Check out the [example app](example/) for a comprehensive demonstration of all features:

```bash
cd example
flutter run
```

## Testing

The package includes comprehensive tests covering:

- Widget behavior and rendering
- Platform-specific functionality
- Keyboard shortcut blocking
- All TextField property support
- Edge cases and error scenarios

Run tests with:

```bash
flutter test
```

## Contributing

Contributions are welcome! Please feel free to submit a Pull Request. For major changes, please open an issue first to discuss what you would like to change.

## License

This project is licensed under the MIT License - see the [LICENSE](LICENSE) file for details.

## Additional Information

- **Issue Tracker**: [GitHub Issues](https://github.com/codered-sjy/secure_textfield/issues)
- **Documentation**: Check the API documentation for detailed information about all available properties and methods
- **Changelog**: See [CHANGELOG.md](CHANGELOG.md) for version history

### Security Considerations

This package provides UI-level protection against copy/paste operations. For sensitive data:

1. Use additional server-side validation
2. Implement proper data encryption
3. Consider using secure storage solutions
4. Be aware that determined users may still find ways to extract data

The package is designed to prevent casual copy/paste operations and improve user experience, but should not be relied upon as the sole security measure for highly sensitive data.
