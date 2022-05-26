import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:sizer/sizer.dart';
// ignore: must_be_immutable
class CustomerText extends StatelessWidget {
  String data ;
  // ignore: prefer_typing_uninitialized_variables
  var onTap ;
  double fontSize ;
  FontWeight fontWeight ;
  Color color;
  TextAlign textAlign ;
  CustomerText({
    Key? key,
    required this.data,
    this.fontSize = 15,
    this.onTap,
    this.textAlign = TextAlign.start,
    this.color = Colors.white,
    this.fontWeight = FontWeight.w400
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Text(
        data,
        style: GoogleFonts.tajawal(
            fontSize: fontSize.sp,
            fontWeight: fontWeight,
            color: color
        ),
        textAlign: textAlign,
      ),
    );
  }
}
