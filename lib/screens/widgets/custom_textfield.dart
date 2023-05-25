import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_challenge/helpers/colors.dart';
import 'package:google_fonts/google_fonts.dart';

Widget customTextField({
  required String hintText,
  required TextEditingController controller,
  String? Function(String?)? validator,
  final Function(String?)? onSubmit,
}) {
  return Padding(
    padding: const EdgeInsets.only(top: 10, left: 20, right: 20),
    child: TextFormField(
      maxLines: null,
      style: GoogleFonts.poppins(
        fontSize: 16,
        color: Colors.black,
      ),
      onFieldSubmitted: onSubmit,
      controller: controller,
      validator: validator,
      textInputAction: TextInputAction.done,
      decoration: InputDecoration(
        fillColor: AppColors.TextWhite,
        filled: true,
        hintStyle: GoogleFonts.poppins(
          fontSize: 14,
          color: Colors.grey.shade500,
        ),
        hintText: hintText,

        // contentPadding: const EdgeInsets.all(5),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
          borderSide: BorderSide(width: 1, color: AppColors.bgColor),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
          borderSide: BorderSide(width: 1, color: AppColors.AppBarColor),
        ),
        errorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
          borderSide: const BorderSide(width: 1, color: Colors.red),
        ),
        focusedErrorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
          borderSide: const BorderSide(width: 1, color: Colors.red),
        ),
      ),
    ),
  );
}
