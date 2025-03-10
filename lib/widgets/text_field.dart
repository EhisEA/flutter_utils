// import 'package:flutter/material.dart';
//
// import 'widgets.dart';
//
// class AppTextField extends StatefulWidget {
//   final TextEditingController? controller;
//   final String? hintText;
//   final String? labelText;
//   final String? title;
//   final bool obscureText;
//   final Widget? prefixIcon;
//   final Widget? suffixIcon;
//   final TextInputType? keyboardType;
//   final TextInputAction? textInputAction;
//   final FocusNode? focusNode;
//   final bool? autocorrect;
//   final bool enabled;
//   final Function(String)? onChanged;
//   final Function(String)? onSubmitted;
//   final Color? fillColor;
//   final Color? borderColor;
//   final Color? labelColor;
//   final Color? hintColor;
//   final Color? textColor;
//   final Color? cursorColor;
//   final int maxLines;
//   final EdgeInsetsGeometry? contentPadding;
//   final TextStyle? textStyle;
//   final double? borderRadius;
//   final EdgeInsetsGeometry? margin;
//   final double? width;
//   final double? height;
//   final bool isPassword; // New parameter
//
//   const AppTextField({
//     super.key,
//     this.controller,
//     this.title,
//     this.hintText,
//     this.labelText,
//     this.obscureText = false,
//     this.prefixIcon,
//     this.suffixIcon,
//     this.keyboardType,
//     this.textInputAction,
//     this.focusNode,
//     this.autocorrect,
//     this.enabled = true,
//     this.onChanged,
//     this.onSubmitted,
//     this.fillColor,
//     this.borderColor,
//     this.labelColor,
//     this.hintColor,
//     this.textColor,
//     this.maxLines = 1,
//     this.cursorColor,
//     this.contentPadding,
//     this.textStyle,
//     this.borderRadius = 8.0,
//     this.margin,
//     this.width,
//     this.height,
//     this.isPassword = false, // Default isPassword to false
//   });
//
//   @override
//   createState() => _AppTextFieldState();
// }
//
// class _AppTextFieldState extends State<AppTextField> {
//   bool _obscureText = false;
//
//   @override
//   void initState() {
//     super.initState();
//     if (widget.isPassword) {
//       _obscureText = true;
//     } else {
//       _obscureText = widget.obscureText;
//     }
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return Column(
//       crossAxisAlignment: CrossAxisAlignment.start,
//       children: [
//         if (widget.title != null) ...[
//           AppText.body(widget.title!),
//           Gap.h8,
//         ],
//         Container(
//           width: widget.width,
//           height: widget.height,
//           margin: widget.margin,
//           child: TextFormField(
//             controller: widget.controller,
//             obscureText: _obscureText,
//             keyboardType: widget.keyboardType,
//             textInputAction: widget.textInputAction,
//             focusNode: widget.focusNode,
//             autocorrect: widget.autocorrect ?? true,
//             enabled: widget.enabled,
//             onChanged: widget.onChanged,
//             // onSubmitted: widget.onSubmitted,
//             maxLines: widget.maxLines,
//             decoration: InputDecoration(
//               hintText: widget.hintText,
//               labelText: widget.labelText,
//               prefixIcon: widget.prefixIcon,
//               suffixIcon: widget.isPassword
//                   ? IconButton(
//                       icon: Icon(
//                         _obscureText
//                             ? Icons.visibility_outlined
//                             : Icons.visibility_off_outlined,
//                         color: const Color(0xff292D32),
//                       ),
//                       onPressed: () {
//                         setState(() {
//                           _obscureText = !_obscureText;
//                         });
//                       },
//                     )
//                   : widget.suffixIcon,
//               fillColor: widget.fillColor,
//               filled: widget.fillColor != null,
//               enabledBorder: OutlineInputBorder(
//                 borderRadius: BorderRadius.circular(widget.borderRadius!),
//                 borderSide: BorderSide(
//                   color: widget.borderColor ??
//                       const Color(0xFFBFBFBF), // Default inactive color
//                 ),
//               ),
//               focusedBorder: OutlineInputBorder(
//                 borderRadius: BorderRadius.circular(widget.borderRadius!),
//                 borderSide: BorderSide(
//                   color: widget.borderColor ??
//                       const Color(0xFF346ED6), // Default focus color
//                 ),
//               ),
//               border: OutlineInputBorder(
//                 borderRadius: BorderRadius.circular(widget.borderRadius!),
//                 borderSide: BorderSide(
//                   color: widget.borderColor ??
//                       const Color(0xFFBFBFBF), // Default inactive color
//                 ),
//               ),
//               labelStyle: TextStyle(color: widget.labelColor),
//               hintStyle: TextStyle(color: widget.hintColor),
//               hintMaxLines: 1,
//               contentPadding: widget.contentPadding ??
//                   const EdgeInsets.symmetric(horizontal: 16.0, vertical: 12.0),
//             ),
//             style: widget.textStyle ?? TextStyle(color: widget.textColor),
//             cursorColor:
//                 widget.cursorColor ?? const Color(0xFF346ED6), // Default focus color
//           ),
//         ),
//       ],
//     );
//   }
// }
