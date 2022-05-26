import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';
// ignore: must_be_immutable
class InputField extends StatefulWidget {
  // ignore: prefer_typing_uninitialized_variables
  var validator , onSaved;
  String hintText ;
  bool obscureText , suffixIcon;
  InputField({
    Key? key,
    required this.hintText,
    this.validator ,
    this.onSaved,
    this.obscureText = false,
    this.suffixIcon = false,
  }) : super(key: key);

  @override
  State<InputField> createState() => _InputFieldState();
}

class _InputFieldState extends State<InputField> {
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(
        horizontal: MediaQuery.of(context).size.height * 0.025,
        vertical:  8.sp
      ),
      child: TextFormField(
          validator: widget.validator,
          obscureText: widget.obscureText,
          onSaved: widget.onSaved,
          decoration: InputDecoration(
            suffixIcon: widget.suffixIcon ?InkWell(
              onTap: (){
                setState(() {
                  widget.obscureText = ! widget.obscureText;
                });
              },
              child: const Icon(
                Icons.remove_red_eye_rounded,
                color: Colors.green,
              ),
            ) : null,
            filled: true,
            fillColor: Colors.white,
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(10.sp),
                topRight: Radius.circular(10.sp),
                bottomRight: Radius.circular(10.sp),
              ),
            ),
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(10.sp),
                topRight: Radius.circular(10.sp),
                bottomRight: Radius.circular(10.sp),
              ),
              borderSide: BorderSide(
                color: Colors.grey.shade300,
              ),
            ),
            hintText: widget.hintText,
          ),
        ),
    );
  }
}
