import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

TextStyle customTextStyle(
    {required double fontSize, required FontWeight? fontWeight}) {
  return GoogleFonts.varelaRound(
    color: Colors.white,
    fontSize: fontSize,
    fontWeight: fontWeight,
  );
}
