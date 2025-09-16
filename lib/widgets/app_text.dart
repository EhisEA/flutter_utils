// import 'package:flutter/material.dart';

// /// A customizable text widget with predefined styles and enhanced features.
// ///
// /// This widget provides various text styles (h1, h2, h3, body, caption, etc.)
// /// with consistent typography and easy customization options.
// class AppText extends StatelessWidget {
//   /// The text content to display.
//   final String text;

//   /// Custom text style to apply.
//   final TextStyle? style;

//   /// Whether the text can span multiple lines.
//   final bool multiText;

//   /// Text alignment.
//   final TextAlign? textAlign;

//   /// How to handle text overflow.
//   final TextOverflow overflow;

//   /// Text color.
//   final Color? color;

//   /// Color for text decoration (underline, etc.).
//   final Color? decorationColor;

//   /// Whether to center the text.
//   final bool centered;

//   /// Maximum number of lines.
//   final int? maxLines;

//   /// Font size.
//   final double? fontSize;

//   /// Letter spacing.
//   final double? letterSpacing;

//   /// Word spacing.
//   final double? wordSpacing;

//   /// Line height multiplier.
//   final double? height;

//   /// Text decoration (underline, strikethrough, etc.).
//   final TextDecoration? decoration;

//   /// Font style (normal, italic).
//   final FontStyle? fontStyle;

//   /// Font weight.
//   final FontWeight? fontWeight;

//   /// Creates an h1 heading text.
//   ///
//   /// Default: fontSize 36, fontWeight 800
//   AppText.h1(
//     this.text, {
//     super.key,
//     this.multiText = true,
//     this.overflow = TextOverflow.ellipsis,
//     this.centered = false,
//     this.color,
//     this.maxLines,
//     this.textAlign,
//     this.wordSpacing,
//     this.height,
//     this.letterSpacing,
//     this.decoration,
//     this.decorationColor,
//     this.fontSize,
//     this.fontWeight,
//     this.fontStyle,
//   }) : style = _getH1Style().copyWith(
//           color: color,
//           height: height,
//           letterSpacing: letterSpacing,
//           decorationColor: decorationColor,
//           wordSpacing: wordSpacing,
//           decoration: decoration,
//           fontWeight: fontWeight,
//           fontSize: fontSize,
//         );

//   /// Creates an h2 heading text.
//   ///
//   /// Default: fontSize 32, fontWeight 800
//   AppText.h2(
//     this.text, {
//     super.key,
//     this.multiText = true,
//     this.overflow = TextOverflow.ellipsis,
//     this.centered = false,
//     this.color,
//     this.maxLines,
//     this.textAlign,
//     this.wordSpacing,
//     this.height,
//     this.letterSpacing,
//     this.decoration,
//     this.decorationColor,
//     this.fontSize,
//     this.fontWeight,
//     this.fontStyle,
//   }) : style = _getH2Style().copyWith(
//           color: color,
//           height: height,
//           letterSpacing: letterSpacing,
//           decorationColor: decorationColor,
//           wordSpacing: wordSpacing,
//           decoration: decoration,
//           fontWeight: fontWeight,
//           fontSize: fontSize,
//         );

//   /// Creates an h3 heading text.
//   ///
//   /// Default: fontSize 30, fontWeight 700
//   AppText.h3(
//     this.text, {
//     super.key,
//     this.multiText = true,
//     this.overflow = TextOverflow.ellipsis,
//     this.centered = false,
//     this.color,
//     this.maxLines,
//     this.textAlign,
//     this.wordSpacing,
//     this.height,
//     this.letterSpacing,
//     this.decoration,
//     this.decorationColor,
//     this.fontSize,
//     this.fontWeight,
//     this.fontStyle,
//   }) : style = _getH3Style().copyWith(
//           color: color,
//           height: height,
//           letterSpacing: letterSpacing,
//           decorationColor: decorationColor,
//           wordSpacing: wordSpacing,
//           decoration: decoration,
//           fontWeight: fontWeight,
//           fontSize: fontSize,
//         );

//   /// Creates a body text.
//   ///
//   /// Default: fontSize 16, fontWeight 400
//   AppText.body(
//     this.text, {
//     super.key,
//     this.multiText = true,
//     this.overflow = TextOverflow.ellipsis,
//     this.centered = false,
//     this.color,
//     this.maxLines,
//     this.textAlign,
//     this.wordSpacing,
//     this.height,
//     this.letterSpacing,
//     this.decoration,
//     this.decorationColor,
//     this.fontSize,
//     this.fontWeight,
//     this.fontStyle,
//   }) : style = _getBodyStyle().copyWith(
//           color: color,
//           height: height,
//           letterSpacing: letterSpacing,
//           decorationColor: decorationColor,
//           wordSpacing: wordSpacing,
//           decoration: decoration,
//           fontWeight: fontWeight,
//           fontSize: fontSize,
//         );

//   /// Creates a caption text.
//   ///
//   /// Default: fontSize 14, fontWeight 400
//   AppText.caption(
//     this.text, {
//     super.key,
//     this.multiText = true,
//     this.overflow = TextOverflow.ellipsis,
//     this.centered = false,
//     this.color,
//     this.maxLines,
//     this.textAlign,
//     this.wordSpacing,
//     this.height,
//     this.letterSpacing,
//     this.decoration,
//     this.decorationColor,
//     this.fontSize,
//     this.fontWeight,
//     this.fontStyle,
//   }) : style = _getCaptionStyle().copyWith(
//           color: color,
//           height: height,
//           letterSpacing: letterSpacing,
//           decorationColor: decorationColor,
//           wordSpacing: wordSpacing,
//           decoration: decoration,
//           fontWeight: fontWeight,
//           fontSize: fontSize,
//         );

//   /// Creates a custom text with the given style.
//   AppText.custom(
//     this.text, {
//     super.key,
//     required this.style,
//     this.multiText = true,
//     this.overflow = TextOverflow.ellipsis,
//     this.centered = false,
//     this.maxLines,
//     this.textAlign,
//   })  : color = null,
//         decorationColor = null,
//         wordSpacing = null,
//         height = null,
//         letterSpacing = null,
//         decoration = null,
//         fontStyle = null,
//         fontWeight = null,
//         fontSize = null;

//   @override
//   Widget build(BuildContext context) {
//     return Text(
//       text,
//       style: style,
//       textAlign: centered ? TextAlign.center : textAlign,
//       overflow: overflow,
//       maxLines: multiText ? maxLines : 1,
//     );
//   }

//   // Predefined styles
//   static TextStyle _getH1Style() {
//     return const TextStyle(
//       fontSize: 36,
//       fontWeight: FontWeight.w800,
//       height: 1.2,
//     );
//   }

//   static TextStyle _getH2Style() {
//     return const TextStyle(
//       fontSize: 32,
//       fontWeight: FontWeight.w800,
//       height: 1.2,
//     );
//   }

//   static TextStyle _getH3Style() {
//     return const TextStyle(
//       fontSize: 30,
//       fontWeight: FontWeight.w700,
//       height: 1.3,
//     );
//   }

//   static TextStyle _getBodyStyle() {
//     return const TextStyle(
//       fontSize: 16,
//       fontWeight: FontWeight.w400,
//       height: 1.5,
//     );
//   }

//   static TextStyle _getCaptionStyle() {
//     return const TextStyle(
//       fontSize: 14,
//       fontWeight: FontWeight.w400,
//       height: 1.4,
//     );
//   }
// }
