import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

extension CustomTextStyles on TextTheme {
  TextStyle tituloAzul32(double scaleFactor) {
    return GoogleFonts.poppins(
      fontSize: 32 * scaleFactor,
      fontWeight: FontWeight.bold,
      color: const Color(0xFF4C98E9),
    );
  }

  TextStyle tituloBlanco72(double scaleFactor) {
    return GoogleFonts.poppins(
      fontSize: 72 * scaleFactor,
      fontWeight: FontWeight.bold,
      color: const Color(0xFFFFFFFF),
    );
  }

  TextStyle tituloBlanco42(double scaleFactor) {
    return GoogleFonts.poppins(
      fontSize: 42 * scaleFactor,
      fontWeight: FontWeight.bold,
      color: const Color(0xFFFFFFFF),
    );
  }

  TextStyle textoBlanco16(double scaleFactor) {
    return GoogleFonts.poppins(
      fontSize: 16 * scaleFactor,
      color: const Color(0xFFFFFFFF),
    );
  }

  TextStyle textoGris14(double scaleFactor) {
    return GoogleFonts.poppins(
      fontSize: 14 * scaleFactor,
      color: const Color(0xFF727272),
    );
  }
  
  TextStyle textoNegro14(double scaleFactor) {
    return GoogleFonts.poppins(
      fontSize: 14 * scaleFactor,
      color: const Color(0xFF000000),
    );
  }

  TextStyle textoNegro54(double scaleFactor) {
    return GoogleFonts.poppins(
      fontSize: 54 * scaleFactor,
      color: const Color(0xFF000000),
    );
  }
}
