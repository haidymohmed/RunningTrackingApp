import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:sizer/sizer.dart';
// ignore: must_be_immutable
class UserButton extends StatefulWidget {
  double width = 100 ;
  String title ;
  // ignore: prefer_typing_uninitialized_variables
  var onTap ;
  UserButton({Key? key , required this.title , this.width = 100 , this.onTap}) : super(key: key);

  @override
  _UserButtonState createState() => _UserButtonState();
}

class _UserButtonState extends State<UserButton> {
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: widget.onTap,
      child: Container(
        width: MediaQuery.of(context).size.width * widget.width,
        padding: EdgeInsets.all(8.sp),
        decoration: BoxDecoration(
          color: Colors.green,
          borderRadius: BorderRadius.circular(18.sp)
        ),
        child: Text(
          widget.title,
          style: GoogleFonts.tajawal(
            fontSize: 18.sp,
            fontWeight: FontWeight.w600,
            color: Colors.white
          ),
          textAlign: TextAlign.center,
        ),
      ),
    );
  }
}
