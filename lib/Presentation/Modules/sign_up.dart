import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';
import 'package:sizer/sizer.dart';
import 'package:toggle_switch/toggle_switch.dart';
import '../../Domain/EnableLocation/LocationCubit.dart';
import '../../Domain/SignUpCubit/sign_cubit.dart';
import '../../Domain/SignUpCubit/sign_status.dart';
import '../../Domain/UserData/user_cubit.dart';
import '../../Domain/validator.dart';
import '../../Models/image_manager.dart';
import '../Dialog/toaste.dart';
import '../Widget/UserText.dart';
import '../Widget/button.dart';
import '../Widget/input_field.dart';
import 'home.dart';
import 'log_in.dart';

class SignUp extends StatefulWidget {
  const SignUp({Key? key}) : super(key: key);
  @override
  _SignUpState createState() => _SignUpState();
}

class _SignUpState extends State<SignUp> {
  bool isAsync = false ;
  int index = 0 ;
  GlobalKey<FormState> formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    return ModalProgressHUD(
      inAsyncCall: isAsync,
      child: Scaffold(
        body: Stack(
          children: [
            Container(
              decoration: BoxDecoration(
                  color: Colors.grey.shade200,
                  image:  const DecorationImage(
                      image: AssetImage(
                          ImageManager.splashImage
                      ),
                      fit: BoxFit.cover,
                      opacity: 0.8
                  )
              ),
            ),
            SafeArea(
              child: SingleChildScrollView(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(height: MediaQuery.of(context).size.height * 0.16),
                    Padding(
                      padding: EdgeInsets.symmetric(
                          horizontal: MediaQuery.of(context).size.width * 0.05
                      ),
                      child: CustomerText(
                        data: 'Join Us',
                        fontWeight: FontWeight.bold,
                        fontSize: 20.sp,
                        textAlign: TextAlign.right,
                      ),
                    ),
                    SizedBox(height: MediaQuery.of(context).size.height * 0.05),
                    Form(
                      key: formKey,
                        child: Column(
                          children: [
                            InputField(
                              hintText: "Enter your Name",
                              validator: (v){
                                return Validator.name(v);
                              },
                              onSaved: (v){
                                setState(() {
                                  UserCubit.get(context).userData.fullName = v.toString();
                                });
                              },
                            ),
                            InputField(
                              hintText: "Enter your Email",
                              validator: (v){
                                return Validator.email(v);
                              },
                              onSaved: (v){
                                setState(() {
                                  UserCubit.get(context).userData.email = v.toString();
                                });
                              },
                            ),
                            InputField(
                              hintText: "Enter your Password",
                              obscureText: true,
                              suffixIcon: true,
                              validator: (v){
                                return Validator.password(v);
                              },
                              onSaved: (v){
                                setState(() {
                                  UserCubit.get(context).userData.password = v.toString();
                                });
                              },
                            ),
                          ],
                        )
                    ),
                    Container(
                      width: 90.w,
                      margin : EdgeInsets.symmetric(
                        horizontal: MediaQuery.of(context).size.height * 0.025,
                        vertical:  8.sp
                      ),
                      alignment: Alignment.center,
                      padding: EdgeInsets.symmetric(vertical: 5.sp),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10.sp),
                        color: Colors.white,
                      ),
                      child: ToggleSwitch(
                        initialLabelIndex: index,
                        totalSwitches: 2,
                        labels:  ["Male" , "Female"],
                        customWidths: [42.w , 42.w],
                        minHeight: 30.sp,
                        radiusStyle: true,
                        activeBgColor: [Colors.green ,Colors.green ],
                        inactiveBgColor: Colors.white,
                        customTextStyles: [
                          GoogleFonts.tajawal(
                              fontSize: 15.sp,
                              fontWeight: FontWeight.w600,
                          ),
                          GoogleFonts.tajawal(
                            fontSize: 15.sp,
                            fontWeight: FontWeight.w600,
                          ),
                        ],
                        onToggle: (value) {
                          setState(() {
                            index = value! ;
                            UserCubit.get(context).userData.gender = value;
                          });
                        },
                      ),
                    ),
                    SizedBox(height: MediaQuery.of(context).size.height * 0.05),
                    BlocListener<SignUpCubit ,SignUpStatus>(
                      listener: (context, state) {
                        if(state is SignUpSuccess){
                          showToastError(msg: "Happy you joined us 1", state: ToastedStates.ERROR);
                          Navigator.push(context, MaterialPageRoute(builder: (context) => const Home()));
                        }
                        else if (state is SignUpFailed){
                          showToastError(msg: state.error.toString(), state: ToastedStates.ERROR);
                        }
                      },
                      child: Center(
                        child: UserButton(
                          title: "Join",
                          width: 0.9,
                          onTap: (){
                            setState(() {
                              isAsync = true;
                            });
                            if(formKey.currentState?.validate() == true){
                              formKey.currentState?.save();
                              try{
                                SignUpCubit.get(context).createAccount(UserCubit.get(context).userData);
                              }catch(e){
                                showToastError(msg: e.toString(), state: ToastedStates.ERROR);
                              }
                            }
                            setState(() {
                              isAsync = false;
                            });
                          },
                        ),
                      ),
                    ),

                    Padding(
                      padding: EdgeInsets.only(top: 15.sp),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          CustomerText(
                            data: "ALREADY HAVE AN ACCOUNT ?  ",
                            fontWeight: FontWeight.bold,
                          ),
                          CustomerText(
                            data: "LOGIN",
                            fontWeight: FontWeight.bold,
                            color: Colors.green,
                            onTap: (){
                              Navigator.push(context, MaterialPageRoute(builder: (_) => const LogIn()));
                            },
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        )
      ),
    );
  }
}
