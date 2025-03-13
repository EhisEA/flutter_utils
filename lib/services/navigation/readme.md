# Navigation Service for Flutter (Web & Mobile)

This project provides an abstracted navigation service for Flutter applications that works seamlessly on both **mobile** (using Flutter’s built-in `Navigator`) and **web** (using [GoRouter](https://pub.dev/packages/go_router)). The design enforces consistent data passing via an `extra` parameter as a `Map<String, dynamic>` and supports query parameters for web routes.

## Table of Contents

- [Overview](#overview)
- [Features](#features)
- [Architecture](#architecture)
  - [Abstract Base Class](#abstract-base-class)
  - [Mobile Implementation](#mobile-implementation)
  - [Web Implementation](#web-implementation)
  - [Factory Initialization](#factory-initialization)
- [Installation](#installation)
- [Usage](#usage)
  - [Initialization](#initialization)
  - [Navigation Methods](#navigation-methods)
- [Examples](#examples)
- [Extensibility](#extensibility)

## Overview

This Navigation Service abstracts common navigation operations, allowing you to use the same API whether your app runs on mobile or web. Key benefits include:

- **Consistent API:** The same methods for pushing, replacing, and popping routes.
- **Query Parameter Support:** Easily append query parameters to web routes.
- **Structured Data Passing:** The `extra` parameter is always a `Map<String, dynamic>`, ensuring type safety and uniformity.

## Features

- **Abstract Base Class:** Defines common navigation operations.
- **Mobile Navigation:** Uses Flutter’s `Navigator` for route management.
- **Web Navigation:** Uses [GoRouter](https://pub.dev/packages/go_router) for URL-based navigation.
- **Consistent Data Passing:** Enforces `extra` as `Map<String, dynamic>` for all additional data.
- **Flexible Query Parameters:** Append query parameters easily to web routes.
- **Singleton Pattern:** Both implementations use singleton instances for efficient resource management.

## Architecture

### Abstract Base Class

The abstract class `NavigationService` defines the following methods:

- `navigateTo` - Navigates to a new route and adds it to the navigation stack.
- `push` - Pushes a new route onto the navigation stack.
- `replace` - Replaces the current route with a new one.
- `navigateAndClearStack` - Removes all previous routes and navigates to a new route.
- `popUntil` - Pops routes until a specified route is reached.
- `logoutAndRedirect` - Logs out the user and redirects to a specified route.
- `goBack` - Pops the current route.

Each method accepts:

- **`routeName`**: For mobile, it represents the named route; for web, it represents the URL path.
- **`queryParams`**: Optional query parameters for web navigation.
- **`extra`**: Additional data as a `Map<String, dynamic>`.

### Mobile Implementation

- **Class:** `MobileNavigationService`
- **Usage:** Uses `Navigator.pushNamed`, `pushReplacementNamed`, and `pushNamedAndRemoveUntil` for navigation.
- **Global Key:** Uses a `GlobalKey<NavigatorState>` for accessing the navigation state.

### Web Implementation

- **Class:** `WebNavigationService`
- **Usage:** Uses `GoRouter` methods such as `go`, `push`, and `replace` for URL-based navigation.
- **Query Parameters:** Constructs full URLs with query parameters using Dart’s `Uri` class.

### Factory Initialization

A factory (or initialization method) is used to select the proper implementation based on the platform. On web, the instance of `GoRouter` must be provided during initialization.

## Installation

1. Add the following dependencies to your `pubspec.yaml`:

    ```yaml
    dependencies:
        flutter:
        sdk: flutter
        go_router: ^x.x.x
    ```

    Replace `x.x.x` with the latest version of `go_router`.

2. Add the navigation service files to your project:

    - `navigation_service.dart` (abstract base)
    - `mobile_navigation_service.dart`
    - `web_navigation_service.dart`
    - Optionally, a factory file like `navigation_service_factory.dart`

## Usage

### Initialization

#### Mobile

```dart
import 'package:flutter/material.dart';
import 'mobile_navigation_service.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      navigatorKey: MobileNavigationService.instance.navigatorKey,
      initialRoute: '/home',
      onGenerateRoute: (settings) {
        // Your route generation logic.
      },
    );
  }
}

```

#### Web

```dart
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'web_navigation_service.dart';

void main() {
  final goRouter = GoRouter(
    routes: [
      GoRoute(path: '/', builder: (context, state) => HomePage()),
      GoRoute(path: '/profile', builder: (context, state) => ProfilePage()),
      // Additional routes...
    ],
  );

  // Assign the GoRouter instance to the WebNavigationService
  WebNavigationService.instance.goRouter = goRouter;
  
  runApp(MyApp(router: goRouter));
}

class MyApp extends StatelessWidget {
  final GoRouter router;
  const MyApp({required this.router});

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      routerConfig: router,
    );
  }
}
```

## Navigation Methods

- **Push a New Route**:

    ```dart
    NavigationService.instance.navigateTo('/profile', extra: {'userId': 123});
    ```

- **Push and Keep Previous Routes**:

    ```dart
     NavigationService.instance.push('/settings', extra: {'theme': 'dark'});
     ```

- **Replace the Current Route**:

    ```dart
     NavigationService.instance.replace('/dashboard', extra: {'admin': true});
     ```

- **Clear Stack and Navigate**:

    ```dart
     NavigationService.instance.navigateAndClearStack('/home', extra: {'reset': true});
     ```

- **Pop Until a Specific Route**:

    ```dart
     NavigationService.instance.popUntil('/login');
     ```

- **Logout and Redirect**:

    ```dart
     NavigationService.instance.logoutAndRedirect('/login', extra: {'reason': 'session expired'});
     ```

- **Go Back**:

    ```dart
     NavigationService.instance.goBack();
     ```

## Examples

### Mobile Example

```dart
// Navigate to a profile screen, passing user data.
MobileNavigationService.instance.navigateTo('/profile', extra: {
  'userId': 123,
  'showEditButton': true,
});
```

### Web Example

```dart
// Navigate to dashboard with query parameters and extra data.
WebNavigationService.instance.navigateTo('/dashboard', queryParams: {
  'tab': 'settings',
}, extra: {
  'isAdmin': true,
});

```

### Extensibility

This architecture is designed to be:

- **`Extensible`**: Easily add support for other platforms (e.g., desktop) by creating additional implementations.
- **`Maintainable`**: The common API ensures any changes in navigation logic are updated in one place.
- **`Consistent`**: Enforcing `extra` as a `Map<String, dynamic>` and using a unified `routeName` parameter makes the API predictable.
