## 0.0.2

### 🐛 Bug Fixes
* Fixed variable shadowing bug in MediaService saveFile method
* Fixed unsafe array access in ApiFailure factory method
* Improved type safety in LocalCache methods (getToken, getUserData, getMapData)
* Added input validation to string extension file type checks (isImage, isDocument, isAudio, isVideo)

### 🔒 Security
* Removed sensitive data logging in LocalCache (tokens, passwords, secrets are no longer logged)

### ✨ Features
* Added permission checks to MediaService image picking methods (getImage, getMultipleImages)
* Added `when` method to AsyncState for pattern matching

### 🔧 Improvements
* Replaced all debugPrint calls with AppLogger in MediaService
* Improved error handling in ApiFailure factory method with proper null safety
* Updated pubspec.yaml description to be more descriptive
* Enhanced type safety across the codebase

### 📚 Documentation
* Fixed Validator class naming inconsistency in README
* Updated documentation examples to match actual API

## 0.0.1

### ✨ Features
* **Extensions**: Added comprehensive string, context, date, number, and list extensions
* **Services**: Added network, media, and navigation services
* **Widgets**: Added reusable UI components (AppTextField, AppText, Gap, etc.)
* **State Management**: Added async state handling and base view models
* **Utils**: Added validators, formatters, and helper functions

### 🐛 Bug Fixes
* Fixed hardcoded dependencies in widgets
* Standardized naming conventions across the package
* Improved error handling in network services

### 📚 Documentation
* Added comprehensive README.md with usage examples
* Added proper API documentation for all public methods
* Added contributing guidelines

### 🧪 Testing
* Added unit tests for string extensions
* Added widget tests for AppTextField
* Improved test coverage across the package

### 🔧 Improvements
* Renamed main class from `MHIFlutterLibrary` to `FlutterUtils`
* Created new AppTextField widget without external dependencies
* Enhanced context extension with better documentation
* Standardized code style and formatting
