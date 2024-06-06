import 'package:flutter/material.dart';

class MyTextField extends StatelessWidget {
  final String hint;
  final IconData? icon;
  final Widget? suffix;
  final TextEditingController? controller;
  final ValueChanged<String>? onChanged;
  final TextInputType? inputType;
  final String? Function(String?)? onValidator;
  int? maxLength;
  bool? autofocus;
  int? maxLines;

  MyTextField(
      {super.key,
      required this.hint,
      this.icon,
      this.controller,
      this.onChanged,
      this.onValidator,
      this.inputType,
      this.maxLength,
      this.suffix,
      this.autofocus,
      this.maxLines});

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      maxLength: maxLength,
      controller: controller,
      onChanged: onChanged,
      validator: onValidator,
      keyboardType: inputType ?? TextInputType.text,
      autofocus: autofocus ?? false,
      autovalidateMode: AutovalidateMode.onUserInteraction,
      maxLines: maxLines,
      decoration: InputDecoration(
        isDense: true,
        hintText: hint,
        prefixIcon: Icon(
          icon,
          color: Colors.orange,
        ),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
        ),
        enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12),
            borderSide: const BorderSide(color: Colors.grey)),
        suffixIcon: suffix,
        focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12),
            borderSide: const BorderSide(color: Colors.orange)),
        errorBorder:
            OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
      ),
    );
  }
}

class MyButton extends StatelessWidget {
  final String text;
  final VoidCallback? press;
  final Color? color;
  final double? width;
  final double? borderRadius;
  final bool disabled;

  const MyButton(
      {super.key,
      required this.text,
      this.press,
      this.disabled = false,
      this.color,
      this.width,
      this.borderRadius});
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
          color: disabled ? Colors.white : (color ?? Colors.orange),
          borderRadius: BorderRadius.circular(borderRadius ?? 12)),
      height: 44,
      width: width,
      child: MaterialButton(
          textColor: Colors.white,
          onPressed: disabled ? null : press,
          child: Text(text,
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w600,
              ))),
    );
  }
}
