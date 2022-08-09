// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';
import 'package:cuidapet_mobile/app/core/ui/extensions/theme_extension.dart';

class CuidapetTextFormField extends StatelessWidget {
  final TextEditingController? controller;
  final FormFieldValidator<String>? validator;
  final String label;
  final bool obscureText;
  final ValueNotifier<bool> _obscureTextVN;

  CuidapetTextFormField({
    super.key,
    this.controller,
    this.validator,
    required this.label,
    this.obscureText = false,
  })  : _obscureTextVN = ValueNotifier<bool>(obscureText);

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder<bool>(
      valueListenable: _obscureTextVN,
      builder: (context, obscureTextVNValue, __) => TextFormField(
        controller: controller,
        validator: validator,
        obscureText: obscureTextVNValue,
        decoration: InputDecoration(
          labelText: label,
          labelStyle: const TextStyle(fontSize: 15, color: Colors.black),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(15),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(15),
            gapPadding: 0,
            borderSide: const BorderSide(color: Colors.grey),
          ),
          suffixIcon: obscureText
              ? IconButton(
                  onPressed: () {
                    _obscureTextVN.value = !obscureTextVNValue;
                  },
                  color: context.primaryColor,
                  icon: Icon(
                    obscureTextVNValue ? Icons.lock : Icons.lock_open,
                  ),
                )
              : null,
        ),
      ),
    );
  }
}
