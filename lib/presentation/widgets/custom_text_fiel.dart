import 'package:flutter/material.dart';

class CustomTextField extends StatelessWidget {
  final String? hint;
  final String? label;
  final bool isObscureText;
  final Function(String)? onChanged;
  final Function(String)? onFieldSubmitted;
  final String? errorMessage;
  final Function()? onTap;
  final String? initialValue;
  final TextEditingController? controller;
  final bool readOnly;
  final bool enabled;
  final TextInputType keyboardType;

  const CustomTextField({
    super.key,
    this.hint,
    this.label,
    this.isObscureText = false,
    this.onChanged,
    this.onFieldSubmitted,
    this.errorMessage,
    this.onTap,
    this.initialValue,
    this.controller,
    this.readOnly = false,
    this.enabled = true,
    this.keyboardType = TextInputType.text,
  });

  @override
  Widget build(BuildContext context) {
    final colors = Theme.of(context).colorScheme;

    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(12),
      ),
      child: TextFormField(
        enabled: enabled,
        onChanged: onChanged,
        obscureText: isObscureText,
        onFieldSubmitted: onFieldSubmitted,
        initialValue: initialValue,
        controller: controller,
        keyboardType: keyboardType,
        onTap: onTap,
        readOnly: readOnly,
        style: const TextStyle(fontSize: 16, fontWeight: FontWeight.normal),
        cursorColor: colors.primary,
        decoration: InputDecoration(
          floatingLabelStyle: TextStyle(
            color: colors.primary,
          ),
          border: InputBorder.none,
          hintText: hint,
          labelStyle: const TextStyle(color: Color(0x6F303030), fontSize: 16),
          label: label != null ? Text(label!) : null,

          errorText: errorMessage,
          errorBorder: const OutlineInputBorder(
            borderSide: BorderSide(color: Color(0xFFC74A4A)),
            borderRadius: BorderRadius.all(Radius.circular(15.5)),
          ),
          focusedErrorBorder: const OutlineInputBorder(
            borderSide: BorderSide(color: Color(0xFFC74A4A)),
            borderRadius: BorderRadius.all(Radius.circular(15.5)),
          ),
          focusedBorder: OutlineInputBorder(
            borderSide: BorderSide(
              color: colors.primary,
            ),
            borderRadius: const BorderRadius.all(Radius.circular(15.5)),
          ),
          enabledBorder: const OutlineInputBorder(
            borderSide: BorderSide(
              color: Color.fromARGB(113, 48, 48, 48),
            ),
            borderRadius: BorderRadius.all(Radius.circular(15.5)),
          ),
        ),
      ),
    );
  }
}
