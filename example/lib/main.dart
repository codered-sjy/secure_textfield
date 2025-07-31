import 'package:flutter/material.dart';
import 'package:secure_textfield/secure_textfield.dart';

void main() {
  runApp(const MyApp());
}

/// Example app demonstrating the SecureTextField widget
class MyApp extends StatelessWidget {
  /// Creates the main app widget
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) => MaterialApp(
    title: 'Secure TextField Demo',
    theme: ThemeData(primarySwatch: Colors.blue, useMaterial3: true),
    home: const ExamplePage(),
  );
}

/// Example page showing different use cases of SecureTextField
class ExamplePage extends StatefulWidget {
  /// Creates the example page
  const ExamplePage({super.key});

  @override
  State<ExamplePage> createState() => _ExamplePageState();
}

class _ExamplePageState extends State<ExamplePage> {
  final TextEditingController _basicController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _multilineController = TextEditingController();
  final TextEditingController _numbersController = TextEditingController();

  String _enteredText = '';

  @override
  void dispose() {
    _basicController.dispose();
    _passwordController.dispose();
    _multilineController.dispose();
    _numbersController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) => Scaffold(
    appBar: AppBar(
      backgroundColor: Theme.of(context).colorScheme.inversePrimary,
      title: const Text('No Copy Paste TextField Examples'),
    ),
    body: Padding(
      padding: const EdgeInsets.all(16.0),
      child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Basic Text Field',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 8),
            SecureTextField(
              controller: _basicController,
              decoration: const InputDecoration(
                labelText: 'Basic text input',
                hintText: 'Try to copy/paste here - it won\'t work!',
                border: OutlineInputBorder(),
              ),
              onChanged: (value) {
                setState(() {
                  _enteredText = value;
                });
              },
            ),
            const SizedBox(height: 8),
            Text('Entered: $_enteredText'),

            const SizedBox(height: 24),
            const Text(
              'Password Field',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 8),
            SecureTextField(
              controller: _passwordController,
              obscureText: true,
              decoration: const InputDecoration(
                labelText: 'Password',
                hintText: 'Secure password input',
                border: OutlineInputBorder(),
                prefixIcon: Icon(Icons.lock),
              ),
            ),

            const SizedBox(height: 24),
            const Text(
              'Multiline Text Field',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 8),
            SecureTextField(
              controller: _multilineController,
              maxLines: 4,
              decoration: const InputDecoration(
                labelText: 'Multiline input',
                hintText: 'Type multiple lines here...',
                border: OutlineInputBorder(),
                alignLabelWithHint: true,
              ),
            ),

            const SizedBox(height: 24),
            const Text(
              'Numbers Only Field',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 8),
            SecureTextField(
              controller: _numbersController,
              keyboardType: TextInputType.number,
              decoration: const InputDecoration(
                labelText: 'Numbers only',
                hintText: 'Enter numbers only',
                border: OutlineInputBorder(),
                prefixIcon: Icon(Icons.numbers),
              ),
            ),

            const SizedBox(height: 24),
            const Text(
              'Disabled Field',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 8),
            const SecureTextField(
              enabled: false,
              decoration: InputDecoration(
                labelText: 'Disabled field',
                hintText: 'This field is disabled',
                border: OutlineInputBorder(),
              ),
            ),

            const SizedBox(height: 24),
            const Text(
              'Read-Only Field',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 8),
            SecureTextField(
              readOnly: true,
              controller: TextEditingController(text: 'Read-only content'),
              decoration: const InputDecoration(
                labelText: 'Read-only field',
                border: OutlineInputBorder(),
              ),
            ),

            const SizedBox(height: 32),
            const Card(
              child: Padding(
                padding: EdgeInsets.all(16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Features Blocked:',
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    SizedBox(height: 8),
                    Text('• Copy (Ctrl+C / Cmd+C)'),
                    Text('• Paste (Ctrl+V / Cmd+V)'),
                    Text('• Cut (Ctrl+X / Cmd+X)'),
                    Text('• Select All (Ctrl+A / Cmd+A)'),
                    Text('• Long press context menu'),
                    Text('• Right-click context menu'),
                    SizedBox(height: 8),
                    Text(
                      'Works on:',
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                    Text('• iOS devices'),
                    Text('• Android devices'),
                    Text('• Web browsers'),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    ),
  );
}
