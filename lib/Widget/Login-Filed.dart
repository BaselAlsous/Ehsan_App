// ignore_for_file: file_names

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class LoginField extends StatelessWidget {
  final String? hintText;
  final String? labelText;
  final TextInputType? keyboardType;
  final TextEditingController? controller;
  final bool obscureText;
  final String? Function(String?)? validator;
  final Function(String)? onChange;
  final bool readOnly;

  // ignore: use_key_in_widget_constructors
  const LoginField(
      {this.hintText,
      this.obscureText = false,
      @required this.labelText,
      this.controller,
      this.keyboardType,
      this.validator,
      this.onChange,
      this.readOnly = false}); 

  @override
  Widget build(BuildContext context) {
    return TextFormField(
        readOnly: readOnly,
        onChanged: onChange,
        validator: validator,
        keyboardType: keyboardType,
        controller: controller,
        obscureText: obscureText,
        textAlignVertical: const TextAlignVertical(y: 0.6),
        decoration: InputDecoration(
          fillColor: const Color(0xfff2f9fe),
          labelText: labelText,
          labelStyle: GoogleFonts.montserrat(
            color: Colors.grey,
            fontSize: 15,
          ),
          hintText: hintText,
          hintStyle: GoogleFonts.montserrat(
            color: Colors.grey,
            fontSize: 15,
          ),
          disabledBorder: OutlineInputBorder(
              borderSide:const BorderSide(color: Colors.grey),
              borderRadius: BorderRadius.circular(25)),
          enabledBorder: OutlineInputBorder(
              borderSide: const BorderSide(color: Colors.grey),
              borderRadius: BorderRadius.circular(25)),
          focusedBorder: OutlineInputBorder(
              borderSide:const BorderSide(color: Colors.grey),
              borderRadius: BorderRadius.circular(25)),
        ));
  }
}
