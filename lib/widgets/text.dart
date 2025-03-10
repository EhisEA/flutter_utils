// // ignore_for_file: prefer_equal_for_default_values, use_key_in_widget_constructors
//
// import 'package:flutter/material.dart';
// import 'package:mhi_flutter_library/widgets/text/textstyles.dart';
//
// class AppText extends StatelessWidget {
//   final String text;
//   final TextStyle style;
//   final bool multiText;
//   final TextAlign? textAlign;
//   final TextOverflow overflow;
//   final Color? color;
//   final Color? decorationColor;
//   final bool centered;
//   final int? maxLines;
//   final double? fontSize;
//   final double? letterSpacing;
//   final double? wordSpacing;
//   final double? height;
//   final TextDecoration? decoration;
//   final FontStyle? fontStyle;
//   final FontWeight? fontWeight;
//
//   /// h1 text
//   ///
//   /// fontSize `36`
//   /// fontWeight `800`
//   AppText.h1(
//     this.text, {
//     Key? key,
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
//   }) : style = AppTextStyle.h1.copyWith(
//           color: color,
//           height: height,
//           letterSpacing: letterSpacing,
//           decorationColor: decorationColor,
//           wordSpacing: wordSpacing,
//           decoration: decoration,
//           fontWeight: fontWeight,
//           fontSize: fontSize,
//         );
//
//   /// h2 text
//   ///
//   /// fontSize `32`
//   /// fontWeight `800`
//   AppText.h2(
//     this.text, {
//     Key? key,
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
//   }) : style = AppTextStyle.h2.copyWith(
//           color: color,
//           height: height,
//           letterSpacing: letterSpacing,
//           decorationColor: decorationColor,
//           wordSpacing: wordSpacing,
//           decoration: decoration,
//           fontWeight: fontWeight,
//           fontSize: fontSize,
//         );
//
//   /// h3 text
//   ///
//   /// fontSize `30`
//   /// fontWeight `800`
//   AppText.h3(
//     this.text, {
//     Key? key,
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
//   }) : style = AppTextStyle.h3.copyWith(
//           color: color,
//           height: height,
//           letterSpacing: letterSpacing,
//           decorationColor: decorationColor,
//           wordSpacing: wordSpacing,
//           decoration: decoration,
//           fontWeight: fontWeight,
//           fontSize: fontSize,
//         );
//
//   /// h4 text
//   ///
//   /// fontSize `26`
//   /// fontWeight `800`
//   AppText.h4(
//     this.text, {
//     Key? key,
//     this.multiText = true,
//     this.overflow = TextOverflow.ellipsis,
//     this.centered = false,
//     this.color,
//     this.maxLines,
//     this.textAlign,
//     this.wordSpacing,
//     this.height,
//     this.decorationColor,
//     this.letterSpacing,
//     this.fontSize,
//     this.fontWeight,
//     this.decoration,
//     this.fontStyle,
//   }) : style = AppTextStyle.h4.copyWith(
//           color: color,
//           height: height,
//           letterSpacing: letterSpacing,
//           wordSpacing: wordSpacing,
//           decorationColor: decorationColor,
//           decoration: decoration,
//           fontWeight: fontWeight,
//           fontSize: fontSize,
//         );
//
//   /// h5 text
//   ///
//   /// fontSize `22`
//   /// fontWeight `800`
//   AppText.h5(
//     this.text, {
//     Key? key,
//     this.multiText = true,
//     this.overflow = TextOverflow.ellipsis,
//     this.centered = false,
//     this.color,
//     this.maxLines,
//     this.decorationColor,
//     this.textAlign,
//     this.wordSpacing,
//     this.height,
//     this.letterSpacing,
//     this.fontSize,
//     this.decoration,
//     this.fontWeight,
//     this.fontStyle,
//   }) : style = AppTextStyle.h5.copyWith(
//           color: color,
//           height: height,
//           letterSpacing: letterSpacing,
//           wordSpacing: wordSpacing,
//           fontWeight: fontWeight,
//           decorationColor: decorationColor,
//           decoration: decoration,
//           fontSize: fontSize,
//         );
//
//   /// h6 text
//   ///
//   /// fontSize `20`
//   /// fontWeight `700`
//   AppText.h6(
//     this.text, {
//     Key? key,
//     this.multiText = true,
//     this.overflow = TextOverflow.ellipsis,
//     this.centered = false,
//     this.color,
//     this.maxLines,
//     this.textAlign,
//     this.wordSpacing,
//     this.height,
//     this.letterSpacing,
//     this.decorationColor,
//     this.decoration,
//     this.fontSize,
//     this.fontWeight,
//     this.fontStyle,
//   }) : style = AppTextStyle.h6.copyWith(
//           color: color,
//           height: height,
//           letterSpacing: letterSpacing,
//           wordSpacing: wordSpacing,
//           decorationColor: decorationColor,
//           fontWeight: fontWeight,
//           decoration: decoration,
//           fontSize: fontSize,
//         );
//
//   /// h7 text
//   ///
//   /// fontSize `16`
//   /// fontWeight `600`
//   AppText.h7(
//     this.text, {
//     Key? key,
//     this.multiText = true,
//     this.overflow = TextOverflow.ellipsis,
//     this.centered = false,
//     this.color,
//     this.maxLines,
//     this.textAlign,
//     this.decoration,
//     this.wordSpacing,
//     this.height,
//     this.decorationColor,
//     this.letterSpacing,
//     this.fontSize,
//     this.fontWeight,
//     this.fontStyle,
//   }) : style = AppTextStyle.h7.copyWith(
//           color: color,
//           height: height,
//           letterSpacing: letterSpacing,
//           wordSpacing: wordSpacing,
//           fontWeight: fontWeight,
//           decorationColor: decorationColor,
//           decoration: decoration,
//           fontSize: fontSize,
//         );
//
//   /// body text
//   ///
//   /// fontSize `14`
//   /// fontWeight `500`
//   AppText.body(
//     this.text, {
//     Key? key,
//     this.multiText = true,
//     this.overflow = TextOverflow.ellipsis,
//     this.centered = false,
//     this.color,
//     this.maxLines,
//     this.textAlign,
//     this.decorationColor,
//     this.wordSpacing,
//     this.decoration,
//     this.height,
//     this.letterSpacing,
//     this.fontSize,
//     this.fontWeight,
//     this.fontStyle,
//   }) : style = AppTextStyle.body.copyWith(
//           color: color,
//           height: height,
//           letterSpacing: letterSpacing,
//           wordSpacing: wordSpacing,
//           fontWeight: fontWeight,
//           decorationColor: decorationColor,
//           decoration: decoration,
//           fontSize: fontSize,
//         );
//
//   /// bodySmall text
//   ///
//   /// fontSize `12`
//   /// fontWeight `500`
//   AppText.bodySmall(
//     this.text, {
//     Key? key,
//     this.multiText = true,
//     this.overflow = TextOverflow.ellipsis,
//     this.centered = false,
//     this.color,
//     this.maxLines,
//     this.textAlign,
//     this.wordSpacing,
//     this.height,
//     this.decorationColor,
//     this.letterSpacing,
//     this.decoration,
//     this.fontSize,
//     this.fontWeight,
//     this.fontStyle,
//   }) : style = AppTextStyle.bodySmall.copyWith(
//           color: color,
//           height: height,
//           letterSpacing: letterSpacing,
//           wordSpacing: wordSpacing,
//           decorationColor: decorationColor,
//           fontWeight: fontWeight,
//           fontSize: fontSize,
//           decoration: decoration,
//         );
//
//   /// caption text
//   ///
//   /// fontSize `10`
//   /// fontWeight `500`
//   AppText.caption(
//     this.text, {
//     Key? key,
//     this.multiText = true,
//     this.overflow = TextOverflow.ellipsis,
//     this.centered = false,
//     this.color,
//     this.maxLines,
//     this.textAlign,
//     this.wordSpacing,
//     this.height,
//     this.letterSpacing,
//     this.decorationColor,
//     this.fontSize,
//     this.decoration,
//     this.fontWeight,
//     this.fontStyle,
//   }) : style = AppTextStyle.caption.copyWith(
//           color: color,
//           height: height,
//           letterSpacing: letterSpacing,
//           wordSpacing: wordSpacing,
//           fontWeight: fontWeight,
//           decorationColor: decorationColor,
//           fontSize: fontSize,
//           decoration: decoration,
//         );
//
//   /// small text
//   ///
//   /// fontSize `8`
//   /// fontWeight `500`
//   AppText.small(
//     this.text, {
//     Key? key,
//     this.multiText = true,
//     this.overflow = TextOverflow.ellipsis,
//     this.centered = false,
//     this.color,
//     this.maxLines,
//     this.textAlign,
//     this.wordSpacing,
//     this.decorationColor,
//     this.height,
//     this.letterSpacing,
//     this.fontSize,
//     this.fontWeight,
//     this.decoration,
//     this.fontStyle,
//   }) : style = AppTextStyle.small.copyWith(
//           color: color,
//           height: height,
//           letterSpacing: letterSpacing,
//           wordSpacing: wordSpacing,
//           fontWeight: fontWeight,
//           decorationColor: decorationColor,
//           decoration: decoration,
//           fontSize: fontSize,
//         );
//
//   @override
//   Widget build(BuildContext context) {
//     return Text(
//       text,
//       maxLines: multiText || maxLines != null ? maxLines ?? 9999999999 : 1,
//       overflow: overflow,
//       textAlign: centered ? TextAlign.center : textAlign ?? TextAlign.left,
//       style: style,
//     );
//   }
// }
