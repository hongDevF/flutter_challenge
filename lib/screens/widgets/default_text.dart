import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class DefaultText extends StatelessWidget {
  const DefaultText({
    super.key,
    required this.text,
    this.color = Colors.black,
    this.fonstSize = 20,
    this.istile = false,
    this.textDecoration,
  });
  final String text;
  final Color color;
  final double fonstSize;
  final bool istile;
  final TextDecoration? textDecoration;
  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      maxLines: null,
      style: GoogleFonts.roboto(
          fontSize: fonstSize,
          color: color,
          fontWeight: istile ? FontWeight.bold : FontWeight.normal,
          textStyle: TextStyle(
            decoration: textDecoration,
          )),
    );
  }
}
