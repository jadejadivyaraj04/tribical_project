import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:tibicle_practical/app/app_colors.dart';

class CommonManropeText extends StatelessWidget {
  final String text;
  final double textSize;
  final Color? color;
  final TextDecoration? decoration;
  final FontWeight? fontWeight;
  final TextAlign? textAlign;
  final TextOverflow? overflow;
  final int? maxLines;

  const CommonManropeText(
      {Key? key,
      required this.text,
      required this.textSize,
      this.color = AppColors.colorED7844,
      this.decoration,
      this.fontWeight,
      this.textAlign,
      this.overflow,
      this.maxLines})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      textAlign: textAlign,
      overflow: overflow,
      softWrap: true,
      maxLines: maxLines,
      style: GoogleFonts.manrope(
          color: color, fontSize: textSize, decoration: decoration, fontWeight: fontWeight, height: 1.5),
    );
  }
}

class CommonMeaCulpaText extends StatelessWidget {
  final String text;
  final double textSize;
  final Color? color;
  final TextDecoration? decoration;
  final FontWeight? fontWeight;
  final TextAlign? textAlign;
  final TextOverflow? overflow;
  final int? maxLines;

  const CommonMeaCulpaText(
      {Key? key,
        required this.text,
        required this.textSize,
        this.color = AppColors.colorED7844,
        this.decoration,
        this.fontWeight,
        this.textAlign,
        this.overflow,
        this.maxLines})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      textAlign: textAlign,
      overflow: overflow,
      softWrap: true,
      maxLines: maxLines,
      style: GoogleFonts.meaCulpa(
          color: color, fontSize: textSize, decoration: decoration, fontWeight: fontWeight, height: 1.5),
    );
  }
}

