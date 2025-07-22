# Contributing to Flutter Utils

Thank you for your interest in contributing to Flutter Utils! This document provides guidelines and information for contributors.

## 🤝 How to Contribute

### Reporting Bugs

Before creating bug reports, please check the existing issues to see if the problem has already been reported. When creating a bug report, please include:

- **Clear and descriptive title**
- **Detailed description** of the problem
- **Steps to reproduce** the issue
- **Expected behavior** vs **actual behavior**
- **Environment information** (Flutter version, OS, etc.)
- **Code examples** if applicable

### Suggesting Enhancements

We welcome feature requests! When suggesting enhancements:

- **Describe the feature** in detail
- **Explain the use case** and why it would be useful
- **Provide examples** of how it would be used
- **Consider the impact** on existing functionality

### Code Contributions

#### Development Setup

1. **Fork the repository**
   ```bash
   git clone https://github.com/your-username/flutter_utils.git
   cd flutter_utils
   ```

2. **Install dependencies**
   ```bash
   flutter pub get
   ```

3. **Create a feature branch**
   ```bash
   git checkout -b feature/amazing-feature
   ```

4. **Make your changes**
   - Follow the coding standards below
   - Add tests for new functionality
   - Update documentation as needed

5. **Run tests**
   ```bash
   flutter test
   ```

6. **Check code quality**
   ```bash
   flutter analyze
   ```

7. **Commit your changes**
   ```bash
   git commit -m 'Add amazing feature'
   ```

8. **Push to your fork**
   ```bash
   git push origin feature/amazing-feature
   ```

9. **Create a Pull Request**

#### Coding Standards

##### General Guidelines

- **Follow Dart Style Guide**: Use the [Dart Style Guide](https://dart.dev/guides/language/effective-dart/style)
- **Use meaningful names**: Variables, functions, and classes should have descriptive names
- **Keep functions small**: Aim for functions under 20 lines when possible
- **Add comments**: Document complex logic and public APIs
- **Be consistent**: Follow existing patterns in the codebase

##### Documentation

- **Public APIs**: All public methods, classes, and properties must have documentation comments
- **Examples**: Include usage examples in documentation when helpful
- **README**: Update the README.md if adding new features

```dart
/// A brief description of what this class/method does.
/// 
/// Provide additional details if needed.
/// 
/// Example:
/// ```dart
/// final result = MyClass().doSomething();
/// ```
class MyClass {
  /// Brief description of the property.
  final String myProperty;

  /// Brief description of the method.
  /// 
  /// [param1] - Description of the first parameter
  /// [param2] - Description of the second parameter
  /// 
  /// Returns a description of what is returned.
  String myMethod(String param1, int param2) {
    // Implementation
  }
}
```

##### Testing

- **Unit tests**: Write tests for all new functionality
- **Widget tests**: Test UI components when applicable
- **Test coverage**: Aim for high test coverage
- **Test naming**: Use descriptive test names that explain the scenario

```dart
group('MyClass', () {
  group('myMethod', () {
    test('should return expected result when given valid input', () {
      // Test implementation
    });

    test('should throw exception when given invalid input', () {
      // Test implementation
    });
  });
});
```

##### File Organization

- **Extensions**: Place in `lib/extensions/` directory
- **Services**: Place in `lib/services/` directory
- **Widgets**: Place in `lib/widgets/` directory
- **Models**: Place in `lib/models/` directory
- **Utils**: Place in `lib/utils/` directory
- **Tests**: Mirror the lib directory structure in `test/`

##### Naming Conventions

- **Files**: Use snake_case (e.g., `my_widget.dart`)
- **Classes**: Use PascalCase (e.g., `MyWidget`)
- **Variables/Functions**: Use camelCase (e.g., `myVariable`, `myFunction`)
- **Constants**: Use SCREAMING_SNAKE_CASE (e.g., `MY_CONSTANT`)

#### Pull Request Guidelines

##### Before Submitting

1. **Test your changes**: Ensure all tests pass
2. **Check code quality**: Run `flutter analyze` and fix any issues
3. **Update documentation**: Add/update documentation for new features
4. **Update CHANGELOG**: Add an entry to `CHANGELOG.md`
5. **Check formatting**: Ensure code is properly formatted

##### Pull Request Template

```markdown
## Description
Brief description of the changes made.

## Type of Change
- [ ] Bug fix (non-breaking change which fixes an issue)
- [ ] New feature (non-breaking change which adds functionality)
- [ ] Breaking change (fix or feature that would cause existing functionality to not work as expected)
- [ ] Documentation update

## Testing
- [ ] Unit tests added/updated
- [ ] Widget tests added/updated
- [ ] Manual testing completed

## Checklist
- [ ] My code follows the style guidelines of this project
- [ ] I have performed a self-review of my own code
- [ ] I have commented my code, particularly in hard-to-understand areas
- [ ] I have made corresponding changes to the documentation
- [ ] My changes generate no new warnings
- [ ] I have added tests that prove my fix is effective or that my feature works
- [ ] New and existing unit tests pass locally with my changes
```

## 🏗️ Project Structure

```
flutter_utils/
├── lib/
│   ├── extensions/          # String, context, date, etc. extensions
│   ├── services/            # Network, media, navigation services
│   ├── widgets/             # Reusable UI components
│   ├── models/              # Data models and state management
│   ├── utils/               # Helper functions and utilities
│   ├── local/               # Local storage and caching
│   ├── router/              # Routing utilities
│   └── flutter_utils.dart   # Main library file
├── test/                    # Test files
├── example/                 # Example app (if applicable)
├── README.md               # Package documentation
├── CHANGELOG.md            # Version history
├── CONTRIBUTING.md         # This file
├── LICENSE                 # License information
└── pubspec.yaml            # Package configuration
```

## 🐛 Issue Labels

We use the following labels to categorize issues:

- **bug**: Something isn't working
- **enhancement**: New feature or request
- **documentation**: Improvements or additions to documentation
- **good first issue**: Good for newcomers
- **help wanted**: Extra attention is needed
- **question**: Further information is requested

## 📞 Getting Help

If you need help with contributing:

1. **Check existing issues** for similar questions
2. **Search the documentation** for relevant information
3. **Create a new issue** with the "question" label
4. **Join our community** (if applicable)

## 📄 License

By contributing to Flutter Utils, you agree that your contributions will be licensed under the same license as the project (MIT License).

## 🙏 Acknowledgments

Thank you to all contributors who help make Flutter Utils better! Your contributions are greatly appreciated.

---

**Happy coding! 🚀** 