import 'package:flutter/material.dart';

Widget primaryTextField(
    {bool? obscureText,
    TextEditingController? controller,
    required String hint,
    Widget? prefix,
    bool? readOnly,
    Function()? onTap}) {
  return TextField(
    readOnly: readOnly ?? false,
    controller: controller,
    style: const TextStyle(fontSize: 14),
    obscureText: obscureText ?? false,
    onTap: onTap,
    decoration: InputDecoration(
        prefixIcon: prefix,
        isDense: true,
        contentPadding: const EdgeInsets.all(12),
        hintText: hint,
        enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(20),
            borderSide: const BorderSide(width: 1, color: Colors.black12)),
        focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(20),
            borderSide: const BorderSide(width: 1, color: Colors.black12))),
  );
}
