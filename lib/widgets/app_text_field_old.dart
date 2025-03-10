/*
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:telehealth/core/extensions/extensions.dart';
import 'package:telehealth/core/theme/colors.dart';
import 'package:telehealth/widgets/gap.dart';

import 'text/text.dart';

class AppTextField extends StatefulWidget {
  final String? text;
  final Widget? textWidget;
  final String? hint;
  final String? labelText;
  final String? Function(String value)? validator;
  final TextInputType keyboardType;
  final bool isPassword;
  final List<TextInputFormatter> formatter;
  final TextEditingController? controller;
  final Function(String)? onChanged;
  final int? maxLines;
  final int? minLines;
  final Color? fillColor;
  final Function(String)? onSubmitted;
  final int? maxLength;
  final double? height;
  final bool? enabled;
  final double? width;
  final FocusNode focusNode;
  final Widget? prefixIcon;
  final EdgeInsets? padding;
  final TextCapitalization textCapitalization;
  final Widget? bottomSection;
  final Color? bgColor;

  AppTextField({
    super.key,
    this.hint,
    this.text,
    this.labelText,
    this.height,
    this.enabled,
    this.width,
    this.bottomSection,
    FocusNode? focusNode,
    this.prefixIcon,
    this.padding,
    this.bgColor,
    this.controller,
    this.keyboardType = TextInputType.text,
    this.validator,
    this.textCapitalization = TextCapitalization.none,
    this.maxLines = 1,
    this.minLines,
    this.isPassword = false,
    this.formatter = const [],
    this.onChanged,
    this.onSubmitted,
    this.fillColor,
    this.maxLength,
  })  : textWidget = null,
        focusNode = focusNode ?? FocusNode();

  AppTextField.widgetTitle({
    super.key,
    this.hint,
    required this.textWidget,
    this.labelText,
    this.height,
    this.width,
    FocusNode? focusNode,
    this.enabled,
    this.prefixIcon,
    this.padding,
    this.bottomSection,
    this.bgColor,
    this.controller,
    this.keyboardType = TextInputType.text,
    this.validator,
    this.textCapitalization = TextCapitalization.none,
    this.maxLines = 1,
    this.minLines,
    this.isPassword = false,
    this.formatter = const [],
    this.onChanged,
    this.onSubmitted,
    this.fillColor,
    this.maxLength,
  })  : text = "",
        focusNode = focusNode ?? FocusNode();

  @override
  State<AppTextField> createState() => _AppTextFieldState();
}

class _AppTextFieldState extends State<AppTextField> {
  late bool obscure;
  late ValueNotifier<bool> hasFocus = ValueNotifier<bool>(false);
  late ValueNotifier<String?> errorState = ValueNotifier<String?>(null);

  @override
  void initState() {
    obscure = widget.isPassword;
    widget.focusNode.addListener(() {
      hasFocus.value = widget.focusNode.hasFocus;
    });
    super.initState();
  }

  toggleVisibility() {
    setState(() {
      obscure = !obscure;
    });
  }

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder<String?>(
      valueListenable: errorState,
      builder: (context, errorMessage, _) {
        return ValueListenableBuilder<bool>(
          valueListenable: hasFocus,
          builder: (context, hasFocus, _) {
            return Column(
              children: [
                GestureDetector(
                  onTap: () {
                    widget.focusNode.requestFocus();
                  },
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      if (widget.text != null) ...[
                        widget.textWidget ??
                            AppText.body(
                              widget.text ?? '',
                              style: context.textTheme.semiBold,
                            ),
                        Gap.h8,
                      ],
                      TextFormField(
                        enabled: widget.enabled,
                        textCapitalization: widget.textCapitalization,
                        focusNode: widget.focusNode,
                        maxLength: widget.maxLength,
                        maxLines: widget.maxLines,
                        minLines: widget.minLines,
                        controller: widget.controller,
                        inputFormatters: widget.formatter,
                        onFieldSubmitted: widget.onSubmitted,
                        validator: (value) {
                          errorState.value = null;
                          String? error;

                          if (widget.validator != null) {
                            error = widget.validator!(value!);
                          }

                          errorState.value = error;
                          return error;
                        },
                        keyboardType: widget.keyboardType,
                        obscureText: obscure,
                        decoration: InputDecoration(
                          labelText: widget.labelText,
                          suffixIconConstraints: const BoxConstraints(
                            maxHeight: 50,
                          ),
                          prefixIcon: widget.prefixIcon,
                          filled: true,
                          fillColor: AppColors.inputFieldBg,
                          suffixIcon: widget.isPassword
                              ? GestureDetector(
                                  onTap: toggleVisibility,
                                  child: Container(
                                    padding: const EdgeInsets.symmetric(
                                      horizontal: 9.5,
                                      vertical: 11,
                                    ),
                                    child: obscure
                                        ? const Icon(
                                            Icons.visibility_off_outlined)
                                        : const Icon(Icons.visibility_outlined),
                                  ),
                                )
                              : null,
                          isDense: true,
                          contentPadding: const EdgeInsets.symmetric(
                            horizontal: 16,
                            vertical: 16,
                          ),
                          hintText: widget.hint,
                          hintStyle: context.textTheme.regular?.copyWith(
                            fontSize: 14,
                          ),
                          enabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(8),
                            borderSide: BorderSide.none,
                          ),
                          disabledBorder: InputBorder.none,
                          focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(8),
                            borderSide:
                                const BorderSide(color: AppColors.primary),
                          ),
                          errorBorder: InputBorder.none,
                          focusedErrorBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(8),
                            borderSide: BorderSide(color: AppColors.red),
                          ),
                        ),
                        onChanged: widget.onChanged,
                      ),
                      if (widget.bottomSection != null) widget.bottomSection!,
                    ],
                  ),
                ),
              ],
            );
          },
        );
      },
    );
  }
}
*/
