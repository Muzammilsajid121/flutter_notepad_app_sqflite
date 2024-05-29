import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

SnackBar customSnackbar(String title) {
  return SnackBar(
    backgroundColor: const Color.fromARGB(255, 253, 183, 178),
    elevation: 1,
    shape: RoundedRectangleBorder( borderRadius: BorderRadius.circular(1.0), ),
    duration: const Duration(milliseconds: 800),

    content: Text(title,
      style: GoogleFonts.montserrat( 
        textStyle: const TextStyle(
      color: Colors.black, fontSize: 17, fontWeight: FontWeight.w600,   ), )),


  );
}
