# Changelog

## 1.0.0 (2025-07-31)


### ⚠ BREAKING CHANGES

* Initial release

### Features

* add CI workflow for linting and code analysis ([#1](https://github.com/codered-sjy/secure_textfield/issues/1)) ([0dd5a19](https://github.com/codered-sjy/secure_textfield/commit/0dd5a1910b4029dac4fc214d8856df68ac30f856))
* add Conventional Commits guide and update README with commit conventions ([#5](https://github.com/codered-sjy/secure_textfield/issues/5)) ([ae880c9](https://github.com/codered-sjy/secure_textfield/commit/ae880c9f54f94b009fc52716cb24eff9f4b662b4))
* add test coverage workflow and update README with coverage instructions ([#3](https://github.com/codered-sjy/secure_textfield/issues/3)) ([657ef46](https://github.com/codered-sjy/secure_textfield/commit/657ef46605e74ffedbcf8fc0578d47e2a2c565a9))
* initial release of SecureTextField package ([9ad4491](https://github.com/codered-sjy/secure_textfield/commit/9ad4491297722696cdb6e0ce5a81e3e88ad0a914))


### Bug Fixes

* add permissions for issues in release workflow ([bf69741](https://github.com/codered-sjy/secure_textfield/commit/bf697415288513db3011654fa0fbf89d9a2813ad))
* ci check badge ([#4](https://github.com/codered-sjy/secure_textfield/issues/4)) ([aabbdfa](https://github.com/codered-sjy/secure_textfield/commit/aabbdfa29f0a0e539ae9ae0ca33ebccda5eb9e9d))
* correct action reference in release workflow ([#6](https://github.com/codered-sjy/secure_textfield/issues/6)) ([d3ad16a](https://github.com/codered-sjy/secure_textfield/commit/d3ad16aff323e31edb942ff52aac85245dbbef7f))

## 🔒 Secure TextField

[![CI Check](https://github.com/codered-sjy/secure_textfield/actions/workflows/ci.yml/badge.svg)](https://github.com/codered-sjy/secure_textfield/actions/workflows/ci.yml)
[![Test Coverage](https://github.com/codered-sjy/secure_textfield/actions/workflows/coverage.yml/badge.svg)](https://github.com/codered-sjy/secure_textfield/actions/workflows/coverage.yml)
[![codecov](https://codecov.io/gh/codered-sjy/secure_textfield/branch/main/graph/badge.svg)](https://codecov.io/gh/codered-sjy/secure_textfield)
[![pub package](https://img.shields.io/pub/v/secure_textfield.svg)](https://pub.dev/packages/secure_textfield)

A Flutter package that provides an enhanced secure text field widget designed to protect sensitive user input by preventing copy, paste, cut, and select operations across iOS, Android, and web platforms. Perfect for password fields, PINs, credit card numbers, and other confidential data entry scenarios. 🛡️

## ✨ Features

🌍 **Universal Platform Support**: Seamlessly works across iOS, Android, and web browsers with consistent behavior  
🚫 **Complete Input Protection**: Intelligently blocks copy, paste, cut, and select all operations to safeguard sensitive data  
⌨️ **Smart Keyboard Blocking**: Automatically prevents common keyboard shortcuts (Ctrl+C/V/X/A, Cmd+C/V/X/A) across all platforms  
📋 **Context Menu Defense**: Disables right-click menus on web and long-press context menus on mobile devices  
🎯 **Full TextField Compatibility**: Maintains 100% compatibility with standard TextField properties, callbacks, and styling options  
🔧 **Zero Configuration**: Works out of the box with no additional setup required - just replace TextField with SecureTextField!

## 🚀 Getting started

Add the package to your `pubspec.yaml`:

```yaml
dependencies:
  secure_textfield: ^0.1.0
```

Then run:

```bash
flutter pub get
```

## 💻 Usage

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

### 🔐 Password Field Example

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

### 📝 Multiline Example

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

### 🎮 With Controller

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

## 📱 Example App

Check out the [example app](example/) for a comprehensive demonstration of all features:

```bash
cd example
flutter run
```

## 🧪 Testing

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

## 🤝 Contributing

Contributions are welcome! Please feel free to submit a Pull Request. For major changes, please open an issue first to discuss what you would like to change.

### 📝 Commit Convention

This project uses [Conventional Commits](https://www.conventionalcommits.org/) for automated changelog generation and version bumping. Please format your commit messages as:

```
<type>[optional scope]: <description>
```

Examples:
- `feat: add new validation feature`
- `fix: resolve input focus issue`
- `docs: update README with new examples`

See [.github/CONVENTIONAL_COMMITS.md](.github/CONVENTIONAL_COMMITS.md) for detailed guidelines.

### 🚀 Release Process

Releases are automated using [Release Please](https://github.com/googleapis/release-please):

1. Commit changes using conventional commit format
2. Push to main branch
3. Release Please automatically creates a release PR with updated version and changelog
4. When the release PR is merged, a new GitHub release is created
5. The package can then be published to pub.dev (currently manual)

## 📄 License

This project is licensed under the MIT License - see the [LICENSE](LICENSE) file for details.

## 📚 Additional Information

- **🐛 Issue Tracker**: [GitHub Issues](https://github.com/codered-sjy/secure_textfield/issues)
- **📖 Documentation**: Check the API documentation for detailed information about all available properties and methods
- **📈 Changelog**: See [CHANGELOG.md](CHANGELOG.md) for version history

### 🔐 Security Considerations

This package provides UI-level protection against copy/paste operations. For sensitive data:

1. Use additional server-side validation
2. Implement proper data encryption
3. Consider using secure storage solutions
4. Be aware that determined users may still find ways to extract data

The package is designed to prevent casual copy/paste operations and improve user experience, but should not be relied upon as the sole security measure for highly sensitive data.
