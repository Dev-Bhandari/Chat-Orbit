import 'package:flutter/material.dart';

class CustomTextFormField extends StatelessWidget {
  const CustomTextFormField(
      {super.key,
      required this.controller,
      required this.hintText,
      required this.iconData,
      required this.validatorResult,
      required this.isobscure});

  final TextEditingController controller;
  final String hintText, validatorResult;
  final IconData iconData;
  final bool isobscure;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 38, vertical: 6),
      child: TextFormField(
        validator: (value) {
          if (isobscure) {
            if (value == null || value.length < 6) {
              return validatorResult;
            } else {
              return null;
            }
          } else {
            if (value == null || value.isEmpty) {
              return validatorResult;
            } else {
              return null;
            }
          }
        },
        controller: controller,
        style: const TextStyle(color: Colors.white),
        obscureText: isobscure,
        cursorColor: Colors.white,
        decoration: InputDecoration(
            hintText: hintText,
            hintStyle: const TextStyle(color: Colors.white),
            enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(10),
                borderSide: const BorderSide(color: Colors.white)),
            focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(10),
                borderSide: const BorderSide(color: Colors.white)),
            errorBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(10),
                borderSide: const BorderSide(color: Colors.white)),
            focusedErrorBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(10),
                borderSide: const BorderSide(color: Colors.white)),
            errorStyle: const TextStyle(color: Colors.white),
            prefixIcon: Icon(
              iconData,
              color: Colors.white,
            )),
      ),
    );
  }
}
