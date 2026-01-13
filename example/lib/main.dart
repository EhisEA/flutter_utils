import 'package:flutter/material.dart';
import 'package:flutter_utils/flutter_utils.dart';

void main() {
  FlutterUtils().initialize();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Utils Example',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        useMaterial3: true,
      ),
      home: const HomePage(),
    );
  }
}

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Flutter Utils Examples'),
      ),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          _buildSection(
            context,
            'Extensions',
            [
              _buildExample(
                context,
                'String Extensions',
                () => Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (_) => const StringExtensionsExample()),
                ),
              ),
              _buildExample(
                context,
                'Context Extensions',
                () => Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (_) => const ContextExtensionsExample()),
                ),
              ),
            ],
          ),
          _buildSection(
            context,
            'Widgets',
            [
              _buildExample(
                context,
                'Custom Widgets',
                () => Navigator.push(
                  context,
                  MaterialPageRoute(builder: (_) => const WidgetsExample()),
                ),
              ),
            ],
          ),
          _buildSection(
            context,
            'Utils',
            [
              _buildExample(
                context,
                'Validators',
                () => Navigator.push(
                  context,
                  MaterialPageRoute(builder: (_) => const ValidatorsExample()),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildSection(BuildContext context, String title, List<Widget> children) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.only(top: 24, bottom: 8),
          child: Text(
            title,
            style: Theme.of(context).textTheme.titleLarge,
          ),
        ),
        ...children,
      ],
    );
  }

  Widget _buildExample(BuildContext context, String title, VoidCallback onTap) {
    return Card(
      margin: const EdgeInsets.only(bottom: 8),
      child: ListTile(
        title: Text(title),
        trailing: const Icon(Icons.arrow_forward_ios),
        onTap: onTap,
      ),
    );
  }
}

class StringExtensionsExample extends StatelessWidget {
  const StringExtensionsExample({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('String Extensions')),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          _buildExample('Email Validation', 'user@example.com'.isEmail.toString()),
          _buildExample('Link Validation', 'https://flutter.dev'.isLink.toString()),
          _buildExample('Capitalize First', 'hello world'.capitalizeFirstLetter()),
          _buildExample('Title Case', 'hello world'.toTitleCase()),
          _buildExample('Initials', 'John Doe'.initials),
          _buildExample('Is Image', 'photo.jpg'.isImage.toString()),
          _buildExample('Is Document', 'file.pdf'.isDocument.toString()),
          _buildExample('Phone Number', '+1234567890'.isPhoneNumber.toString()),
        ],
      ),
    );
  }

  Widget _buildExample(String label, String value) {
    return Card(
      margin: const EdgeInsets.only(bottom: 8),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(label, style: const TextStyle(fontWeight: FontWeight.bold)),
            Text(value),
          ],
        ),
      ),
    );
  }
}

class ContextExtensionsExample extends StatelessWidget {
  const ContextExtensionsExample({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Context Extensions')),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          Card(
            child: Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('Screen Width: ${context.width}'),
                  Text('Screen Height: ${context.height}'),
                  Text('Is Mobile: ${context.isMobile}'),
                  Text('Is Tablet: ${context.isTablet}'),
                  Text('Is Desktop: ${context.isDesktop}'),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class WidgetsExample extends StatelessWidget {
  const WidgetsExample({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Custom Widgets')),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          const AppCircularProgressIndicator(),
          const Gap(height: 24),
          const Text('Sample Text'),
          const Gap(height: 24),
          ResponsiveBuilder(
            mobileBuilder: (context) => const Text('Mobile Layout'),
            tabletBuilder: (context) => const Text('Tablet Layout'),
            desktopBuilder: (context) => const Text('Desktop Layout'),
          ),
        ],
      ),
    );
  }
}

class ValidatorsExample extends StatefulWidget {
  const ValidatorsExample({super.key});

  @override
  State<ValidatorsExample> createState() => _ValidatorsExampleState();
}

class _ValidatorsExampleState extends State<ValidatorsExample> {
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  final _formKey = GlobalKey<FormState>();

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Validators')),
      body: Form(
        key: _formKey,
        child: ListView(
          padding: const EdgeInsets.all(16),
          children: [
            TextFormField(
              controller: _emailController,
              decoration: const InputDecoration(labelText: 'Email'),
              validator: Validator.email,
            ),
            const Gap(height: 16),
            TextFormField(
              controller: _passwordController,
              decoration: const InputDecoration(labelText: 'Password'),
              obscureText: true,
              validator: (value) => Validator.password(value),
            ),
            const Gap(height: 24),
            ElevatedButton(
              onPressed: () {
                if (_formKey.currentState!.validate()) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(content: Text('Form is valid!')),
                  );
                }
              },
              child: const Text('Validate'),
            ),
          ],
        ),
      ),
    );
  }
}

