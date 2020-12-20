import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

Color g1 = Colors.purple;
Color g2 = Colors.blue;

TextStyle heading = GoogleFonts.varelaRound(color: Colors.white, fontSize: 27.0, fontWeight: FontWeight.bold);
TextStyle subhead = GoogleFonts.varelaRound(color: Colors.white, fontSize: 16.0, fontWeight: FontWeight.bold);

final Shader linearGradient = LinearGradient(
  colors: <Color>[g1, g2],
).createShader(Rect.fromLTWH(0.0, 0.0, 200.0, 70.0));