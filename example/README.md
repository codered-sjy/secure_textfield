# No Copy Paste TextField Example

This example app demonstrates the `no_copy_paste_textfield` package functionality across different platforms.

## Features Demonstrated

- Basic text input with copy/paste blocking
- Password fields with obscured text
- Multiline text areas
- Different input types (email, phone, etc.)
- Custom styling and decoration
- Read-only fields
- Controlled and uncontrolled inputs

## Running the Example

### Web
```bash
flutter run -d chrome
```

### iOS (Simulator)
```bash
flutter run -d ios
```

### iOS (Physical Device)
```bash
flutter run -d "Your Device Name"
```

### Android (Emulator)
```bash
flutter run -d android
```

### macOS Desktop
```bash
flutter run -d macos
```

## Testing Copy/Paste Blocking

1. **Keyboard Shortcuts**: Try using Ctrl+C/V/X/A (or Cmd on Mac) - they should be blocked
2. **Context Menu**: Right-click or long-press on text fields - context menu should be disabled
3. **Text Selection**: Try to select text in the fields - selection should be disabled
4. **Different Platforms**: Test the same behaviors across web, mobile, and desktop

## Platform-Specific Behavior

- **Web**: Blocks both Ctrl and Cmd shortcuts, disables browser context menu
- **iOS**: Blocks Cmd shortcuts, disables long-press selection menu
- **Android**: Blocks Ctrl shortcuts, disables text selection handles
- **Desktop**: Blocks platform-appropriate shortcuts (Ctrl on Windows/Linux, Cmd on Mac)

## Notes

- The package provides UI-level protection but should not be the only security measure for highly sensitive data
- Some accessibility features may be affected due to disabled text selection
- The blocking works at the widget level and doesn't affect other text fields in the app
