// import 'package:another_flushbar/flushbar.dart';
// import 'package:flutter/cupertino.dart';
// import 'package:flutter/material.dart';
// import 'package:telehealth/core/theme/colors.dart';
// import 'package:telehealth/models/exceptions/failure.dart';
// import '../core/services/navigation_service.dart';
// import '../theme/themes.dart';
//
// class TeleFlushBar {
//   static void showFailure({
//     required Failure failure,
//     String? title,
//     bool showTitle = true,
//     Color? color,
//     Duration? duration,
//   }) {
//     Flushbar<dynamic>(
//       flushbarPosition: FlushbarPosition.TOP,
//       // leftBarIndicatorColor: AppColors.red,
//       duration: duration ?? const Duration(seconds: 5),
//       backgroundColor: color ?? AppColors.flushBarBackground,
//       margin: const EdgeInsets.all(16),
//       // borderRadius: BorderRadius.circular(8),
//       message: failure.message,
//       padding: EdgeInsets.zero,
//     ).show(NavigationService.instance.navigatorKey.currentContext!);
//   }
//
//   /// show success indication
//   static void showSuccess({
//     required String message,
//     String? title,
//     Color? color,
//     Duration? duration,
//   }) {
//     Flushbar<dynamic>(
//       flushbarPosition: FlushbarPosition.TOP,
//       duration: duration ?? const Duration(seconds: 5),
//       backgroundColor: color ?? AppColors.flushBarBackground,
//       margin: const EdgeInsets.all(16),
//       padding: EdgeInsets.zero,
//       message: message,
//     ).show(NavigationService.instance.navigatorKey.currentContext!);
//   }
//
//   static void showGeneric({
//     required String message,
//     String? title,
//     Color? color,
//     Duration? duration,
//   }) {
//     Flushbar<dynamic>(
//       flushbarPosition: FlushbarPosition.TOP,
//       duration: duration ?? const Duration(seconds: 5),
//       backgroundColor: color ?? AppColors.flushBarBackground,
//       margin: const EdgeInsets.all(16),
//       padding: EdgeInsets.zero,
//       message: message,
//     ).show(NavigationService.instance.navigatorKey.currentContext!);
//   }
//
//   static void showNotification({
//     required String message,
//     String? title,
//     Color? color,
//     Duration? duration,
//   }) {
//     Flushbar<dynamic>(
//       flushbarPosition: FlushbarPosition.TOP,
//       duration: duration ?? const Duration(minutes: 10),
//       backgroundColor: color ?? AppColors.flushBarBackground,
//       margin: const EdgeInsets.all(16),
//       padding: EdgeInsets.zero,
//       message: message,
//     ).show(NavigationService.instance.navigatorKey.currentContext!);
//   }
// }
