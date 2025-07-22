// import 'package:flutter/material.dart';
// import 'package:flutter_test/flutter_test.dart';
// import 'package:flutter_utils/widgets/app_text_field.dart';

// void main() {
//   group('AppTextField', () {
//     testWidgets('should render with basic properties',
//         (WidgetTester tester) async {
//       await tester.pumpWidget(
//         MaterialApp(
//           home: Scaffold(
//             body: AppTextField(
//               hint: 'Enter text',
//               labelText: 'Label',
//             ),
//           ),
//         ),
//       );

//       expect(find.byType(TextFormField), findsOneWidget);
//       expect(find.text('Enter text'), findsOneWidget);
//       expect(find.text('Label'), findsOneWidget);
//     });

//     testWidgets('should handle text input', (WidgetTester tester) async {
//       String? inputValue;

//       await tester.pumpWidget(
//         MaterialApp(
//           home: Scaffold(
//             body: AppTextField(
//               hint: 'Enter text',
//               onChanged: (value) => inputValue = value,
//             ),
//           ),
//         ),
//       );

//       await tester.enterText(find.byType(TextFormField), 'Hello World');
//       await tester.pump();

//       expect(inputValue, equals('Hello World'));
//     });

//     testWidgets('should show password toggle when isPassword is true',
//         (WidgetTester tester) async {
//       await tester.pumpWidget(
//         MaterialApp(
//           home: Scaffold(
//             body: AppTextField(
//               hint: 'Enter password',
//               isPassword: true,
//             ),
//           ),
//         ),
//       );

//       expect(find.byIcon(Icons.visibility_off), findsOneWidget);

//       await tester.tap(find.byIcon(Icons.visibility_off));
//       await tester.pump();

//       expect(find.byIcon(Icons.visibility), findsOneWidget);
//     });

//     testWidgets('should validate input correctly', (WidgetTester tester) async {
//       await tester.pumpWidget(
//         MaterialApp(
//           home: Scaffold(
//             body: AppTextField(
//               hint: 'Enter email',
//               validator: (value) {
//                 if (value?.isEmpty ?? true) {
//                   return 'Email is required';
//                 }
//                 if (!value!.contains('@')) {
//                   return 'Invalid email';
//                 }
//                 return null;
//               },
//             ),
//           ),
//         ),
//       );

//       // Test empty validation
//       final formField = find.byType(TextFormField);
//       await tester.tap(formField);
//       await tester.pump();

//       // Trigger validation by unfocusing
//       await tester.tap(find.byType(Scaffold));
//       await tester.pump();

//       expect(find.text('Email is required'), findsOneWidget);
//     });

//     testWidgets('should handle keyboard type', (WidgetTester tester) async {
//       await tester.pumpWidget(
//         MaterialApp(
//           home: Scaffold(
//             body: AppTextField(
//               hint: 'Enter email',
//               keyboardType: TextInputType.emailAddress,
//             ),
//           ),
//         ),
//       );

//       // Verify the widget renders without errors
//       expect(find.byType(TextFormField), findsOneWidget);
//     });

//     testWidgets('should handle max length', (WidgetTester tester) async {
//       await tester.pumpWidget(
//         MaterialApp(
//           home: Scaffold(
//             body: AppTextField(
//               hint: 'Enter text',
//               maxLength: 5,
//             ),
//           ),
//         ),
//       );

//       // Verify the widget renders without errors
//       expect(find.byType(TextFormField), findsOneWidget);
//     });

//     testWidgets('should handle disabled state', (WidgetTester tester) async {
//       await tester.pumpWidget(
//         MaterialApp(
//           home: Scaffold(
//             body: AppTextField(
//               hint: 'Enter text',
//               enabled: false,
//             ),
//           ),
//         ),
//       );

//       final textField =
//           tester.widget<TextFormField>(find.byType(TextFormField));
//       expect(textField.enabled, isFalse);
//     });
//   });
// }
