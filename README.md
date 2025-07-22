# Flutter Utils

A comprehensive Flutter utilities package that provides reusable components, extensions, services, and widgets to accelerate your Flutter development.

[![pub package](https://img.shields.io/pub/v/flutter_utils.svg)](https://pub.dev/packages/flutter_utils)
[![License: MIT](https://img.shields.io/badge/License-MIT-yellow.svg)](https://opensource.org/licenses/MIT)

## 📋 Table of Contents

- [Features](#-features)
- [Installation](#-installation)
- [Quick Start](#-quick-start)
- [Core Components](#-core-components)
  - [Extensions](#extensions)
  - [Services](#services)
  - [Widgets](#widgets)
  - [State Management](#state-management)
  - [Utils](#utils)
- [Examples](#-examples)
- [API Reference](#-api-reference)
- [Contributing](#-contributing)
- [License](#-license)

## ✨ Features

- **🔄 Extensions**: String, Date, Number, List, and Context utilities
- **🌐 Network Services**: HTTP client with authentication and logging
- **📱 Media Services**: File picking, image handling, and media operations
- **🧭 Navigation**: Cross-platform navigation services
- **📊 State Management**: Async state handling and view models
- **🎨 UI Widgets**: Reusable custom widgets and components
- **💾 Local Storage**: Caching and data persistence utilities
- **🔧 Utils**: Validators, formatters, and helper functions

## 📦 Installation

Add `flutter_utils` to your `pubspec.yaml`:

```yaml
dependencies:
  flutter_utils: ^0.0.1
```

Then run:

```bash
flutter pub get
```

## 🚀 Quick Start

### 1. Initialize the Package

```dart
import 'package:flutter_utils/flutter_utils.dart';

void main() {
  // Initialize the utilities package
  FlutterUtils().initialize();
  runApp(MyApp());
}
```

### 2. Basic Usage Examples

```dart
import 'package:flutter_utils/flutter_utils.dart';

class MyWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        // Use string extensions
        Text('hello world'.capitalizeFirstLetter()), // "Hello world"
        
        // Use context extensions
        Text('Screen width: ${context.screenWidth}'),
        
        // Use custom widgets
        AppCircularProgressIndicator(),
        Gap(height: 16),
        
        // Use responsive builder
        ResponsiveBuilder(
          mobile: (context) => Text('Mobile Layout'),
          tablet: (context) => Text('Tablet Layout'),
          desktop: (context) => Text('Desktop Layout'),
        ),
      ],
    );
  }
}
```

## 🧩 Core Components

### Extensions

Extensions provide convenient utility methods for common operations.

#### String Extensions

```dart
// Email validation
bool isValid = 'user@example.com'.isEmail; // true

// Link validation
bool isLink = 'https://flutter.dev'.isLink; // true

// Capitalization
String title = 'hello world'.capitalizeFirstLetter(); // "Hello world"
String titleCase = 'hello world'.toTitleCase(); // "Hello World"

// File type checking
bool isImage = 'photo.jpg'.isImage; // true
bool isDocument = 'document.pdf'.isDocument; // true

// Phone number validation
bool isPhone = '+1234567890'.isPhoneNumber; // true

// Password strength
bool isStrong = 'MyPass123!'.isStrongPassword; // true

// Initials extraction
String initials = 'John Doe'.initials; // "JD"
```

#### Context Extensions

```dart
// Screen dimensions
double width = context.screenWidth;
double height = context.screenHeight;
double pixelRatio = context.pixelRatio;

// Theme access
ThemeData theme = context.theme;
ColorScheme colors = context.colors;

// Navigation
context.push('/home');
context.pop();
context.pushReplacement('/login');
```

#### Date Extensions

```dart
DateTime now = DateTime.now();

// Formatting
String formatted = now.toFormattedString(); // "2024-01-15 10:30:00"
String relative = now.toRelativeString(); // "2 hours ago"

// Date operations
bool isToday = now.isToday;
bool isYesterday = now.isYesterday;
bool isThisWeek = now.isThisWeek;
```

#### Number Extensions

```dart
// Formatting
String currency = 1234.56.toCurrency(); // "$1,234.56"
String percentage = 0.75.toPercentage(); // "75%"

// Validation
bool isPositive = 42.isPositive; // true
bool isNegative = (-5).isNegative; // true
bool isZero = 0.isZero; // true
```

### Services

#### Network Service

```dart
// Initialize network service
final networkService = NetworkServiceImpl();

// GET request
final response = await networkService.get('/api/users');

// POST request
final createResponse = await networkService.post(
  '/api/users',
  data: {'name': 'John', 'email': 'john@example.com'},
);

// Handle response
if (response.isSuccess) {
  final users = response.data;
  print('Users: $users');
} else {
  print('Error: ${response.error}');
}
```

#### Media Service

```dart
// Initialize media service
final mediaService = MediaServiceImpl();

// Pick image from gallery
final imageResult = await mediaService.pickImage(
  source: ImageSource.gallery,
);

if (imageResult.isSuccess) {
  final imageFile = imageResult.data;
  print('Selected image: ${imageFile.path}');
}

// Pick multiple files
final filesResult = await mediaService.pickFiles(
  allowMultiple: true,
  type: FileType.custom,
  allowedExtensions: ['pdf', 'doc', 'docx'],
);
```

#### Navigation Service

```dart
// Initialize navigation service
final navigationService = MobileNavigationService();

// Navigate to screen
await navigationService.push('/home');

// Navigate and replace current screen
await navigationService.pushReplacement('/login');

// Navigate to screen with data
await navigationService.push('/user-details', arguments: {'userId': 123});

// Go back
await navigationService.pop();
```

### Widgets

#### AppCircularProgressIndicator

```dart
AppCircularProgressIndicator(
  size: 40,
  strokeWidth: 3,
  color: Colors.blue,
)
```

#### AppTextField

```dart
AppTextField(
  hint: 'Enter your email',
  labelText: 'Email',
  keyboardType: TextInputType.emailAddress,
  validator: (value) {
    if (value?.isEmpty ?? true) {
      return 'Email is required';
    }
    if (!value!.isEmail) {
      return 'Please enter a valid email';
    }
    return null;
  },
  onChanged: (value) {
    print('Email: $value');
  },
)
```

#### ResponsiveBuilder

```dart
ResponsiveBuilder(
  mobile: (context) => MobileLayout(),
  tablet: (context) => TabletLayout(),
  desktop: (context) => DesktopLayout(),
)
```

#### Gap

```dart
Column(
  children: [
    Text('First item'),
    Gap(height: 16), // Vertical gap
    Text('Second item'),
    Gap(width: 20), // Horizontal gap
    Text('Third item'),
  ],
)
```

#### ProfileImage

```dart
ProfileImage(
  imageUrl: 'https://example.com/avatar.jpg',
  size: 60,
  placeholder: Icon(Icons.person),
  errorWidget: Icon(Icons.error),
)
```

### State Management

#### AsyncState

```dart
class UserViewModel extends BaseChangeNotifierViewModel {
  AsyncState<List<User>> _usersState = AsyncState.initial();
  AsyncState<List<User>> get usersState => _usersState;

  Future<void> loadUsers() async {
    _usersState = AsyncState.loading();
    notifyListeners();

    try {
      final users = await userService.getUsers();
      _usersState = AsyncState.success(users);
    } catch (error) {
      _usersState = AsyncState.error(error.toString());
    }
    
    notifyListeners();
  }
}
```

#### Using AsyncState in UI

```dart
Consumer<UserViewModel>(
  builder: (context, viewModel, child) {
    return viewModel.usersState.when(
      initial: () => Container(),
      loading: () => AppCircularProgressIndicator(),
      success: (users) => ListView.builder(
        itemCount: users.length,
        itemBuilder: (context, index) => UserTile(user: users[index]),
      ),
      error: (message) => ErrorWidget(message: message),
    );
  },
)
```

### Utils

#### Validators

```dart
// Email validation
bool isValidEmail = Validators.isEmail('user@example.com');

// Phone validation
bool isValidPhone = Validators.isPhoneNumber('+1234567890');

// Password validation
bool isValidPassword = Validators.isStrongPassword('MyPass123!');

// Required field validation
String? error = Validators.required('', 'This field is required');
```

#### AppLogger

```dart
final logger = AppLogger(MyClass);

logger.info('User logged in successfully');
logger.warning('API rate limit approaching');
logger.error('Failed to load data', error);
logger.debug('Debug information');
```

#### Debouncer

```dart
final debouncer = Debouncer(milliseconds: 500);

// Debounce search input
onSearchChanged(String query) {
  debouncer.run(() {
    performSearch(query);
  });
}
```

## 📱 Examples

### Complete Login Form

```dart
class LoginForm extends StatefulWidget {
  @override
  _LoginFormState createState() => _LoginFormState();
}

class _LoginFormState extends State<LoginForm> {
  final _formKey = GlobalKey<FormState>();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: Column(
        children: [
          AppTextField(
            controller: _emailController,
            hint: 'Enter your email',
            labelText: 'Email',
            keyboardType: TextInputType.emailAddress,
            validator: (value) {
              if (value?.isEmpty ?? true) {
                return 'Email is required';
              }
              if (!value!.isEmail) {
                return 'Please enter a valid email';
              }
              return null;
            },
          ),
          Gap(height: 16),
          AppTextField(
            controller: _passwordController,
            hint: 'Enter your password',
            labelText: 'Password',
            isPassword: true,
            validator: (value) {
              if (value?.isEmpty ?? true) {
                return 'Password is required';
              }
              if (!value!.isStrongPassword) {
                return 'Password must be at least 8 characters with uppercase, lowercase, number, and special character';
              }
              return null;
            },
          ),
          Gap(height: 24),
          ElevatedButton(
            onPressed: _handleLogin,
            child: Text('Login'),
          ),
        ],
      ),
    );
  }

  void _handleLogin() {
    if (_formKey.currentState!.validate()) {
      // Proceed with login
      print('Email: ${_emailController.text}');
      print('Password: ${_passwordController.text}');
    }
  }
}
```

### API Integration Example

```dart
class UserService {
  final NetworkService _networkService = NetworkServiceImpl();

  Future<List<User>> getUsers() async {
    final response = await _networkService.get('/api/users');
    
    if (response.isSuccess) {
      return (response.data as List)
          .map((json) => User.fromJson(json))
          .toList();
    } else {
      throw Exception(response.error);
    }
  }

  Future<User> createUser(User user) async {
    final response = await _networkService.post(
      '/api/users',
      data: user.toJson(),
    );
    
    if (response.isSuccess) {
      return User.fromJson(response.data);
    } else {
      throw Exception(response.error);
    }
  }
}
```

## 📚 API Reference

For detailed API documentation, see the [API Reference](https://pub.dev/documentation/flutter_utils).

### Key Classes

- `FlutterUtils` - Main package initialization
- `NetworkServiceImpl` - HTTP client implementation
- `MediaServiceImpl` - Media handling service
- `MobileNavigationService` - Mobile navigation service
- `AsyncState<T>` - Generic async state wrapper
- `BaseChangeNotifierViewModel` - Base view model class

### Key Extensions

- `StringExtension` - String utility methods
- `ContextExtension` - BuildContext utility methods
- `DateExtension` - DateTime utility methods
- `NumberExtension` - Number formatting and validation
- `ListExtension` - List utility methods

### Key Widgets

- `AppCircularProgressIndicator` - Custom progress indicator
- `AppTextField` - Enhanced text field
- `ResponsiveBuilder` - Responsive layout builder
- `Gap` - Spacing widget
- `ProfileImage` - Profile image widget

## 🤝 Contributing

We welcome contributions! Please see our [Contributing Guide](CONTRIBUTING.md) for details.

### Development Setup

1. Fork the repository
2. Create a feature branch: `git checkout -b feature/amazing-feature`
3. Make your changes
4. Add tests for new functionality
5. Run tests: `flutter test`
6. Commit your changes: `git commit -m 'Add amazing feature'`
7. Push to the branch: `git push origin feature/amazing-feature`
8. Open a Pull Request

### Code Style

- Follow the [Dart Style Guide](https://dart.dev/guides/language/effective-dart/style)
- Use meaningful variable and function names
- Add documentation comments for public APIs
- Write tests for new functionality

## 📄 License

This project is licensed under the MIT License - see the [LICENSE](LICENSE) file for details.

## 🙏 Acknowledgments

- Flutter team for the amazing framework
- All contributors who help improve this package
- The open-source community for inspiration and feedback

---

**Made with ❤️ for the Flutter community** 