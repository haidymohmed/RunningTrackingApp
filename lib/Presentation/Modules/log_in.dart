import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';
import 'package:sizer/sizer.dart';
import 'package:task_final/Presentation/Modules/sign_up.dart';
import '../../Domain/LogInCubit/login_cubit.dart';
import '../../Domain/LogInCubit/login_status.dart';
import '../../Domain/UserData/user_cubit.dart';
import '../../Domain/validator.dart';
import '../../Models/LocalStorage/db_helper_sharedPrefrences.dart';
import '../../Models/image_manager.dart';
import '../Dialog/toaste.dart';
import '../Widget/UserText.dart';
import '../Widget/button.dart';
import '../Widget/input_field.dart';
import 'home.dart';

class LogIn extends StatefulWidget {
  const LogIn({Key? key}) : super(key: key);
  @override
  _LogInState createState() => _LogInState();
}

class _LogInState extends State<LogIn> {
  int index = 0 ;
  bool isAsync = false;
  GlobalKey<FormState> formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    CacheHelper.setBool("firstTime", true);
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
                      SizedBox(height: MediaQuery.of(context).size.height * 0.18),
                      Padding(
                        padding: EdgeInsets.symmetric(
                            horizontal: MediaQuery.of(context).size.width * 0.05
                        ),
                        child: CustomerText(
                          data: 'LogIn',
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
                          ),
                      ),
                      SizedBox(height: 15.sp),
                      BlocListener<LogInCubit ,LogInStatus>(
                        listener: (context, state) {
                          if(state is LogInSuccess){
                            showToastError(msg: "Welcome Back", state: ToastedStates.SUCCESS);
                            Navigator.push(context, MaterialPageRoute(builder: (context) => const Home()));
                          }
                          else if (state is LogInFailed){
                            showToastError(msg: state.error.toString() + " Here", state: ToastedStates.ERROR);
                          }
                        },
                        child: Center(
                          child: UserButton(
                            title: "LOGIN",
                            width: 0.9,
                            onTap: (){
                              setState(() {
                                isAsync = true;
                              });
                              if(formKey.currentState?.validate() == true){
                                formKey.currentState?.save();
                                print(UserCubit.get(context).userData.password + UserCubit.get(context).userData.email);
                                try{
                                  LogInCubit.get(context).logIn(UserCubit.get(context).userData);
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
                              data: "DON'T HAVE AN ACCOUNT ?  ",
                              fontWeight: FontWeight.bold,
                            ),
                            CustomerText(
                              data: "SIGNUP",
                              fontWeight: FontWeight.bold,
                              color: Colors.green,
                              onTap: (){
                                Navigator.push(context, MaterialPageRoute(builder: (_) => const SignUp()));
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
