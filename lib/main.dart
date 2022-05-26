import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:location/location.dart';
import 'package:one_context/one_context.dart';
import 'package:sizer/sizer.dart';
import 'package:task_final/Models/API/LocationApi.dart';
import 'Domain/CheckConnection/connect_cubit.dart';
import 'Domain/CheckConnection/connect_state.dart';
import 'Domain/EnableLocation/LocationCubit.dart';
import 'Domain/HomeController/controller.dart';
import 'Domain/LiveLocation/live_cubit.dart';
import 'Domain/LogInCubit/login_cubit.dart';
import 'Domain/SignUpCubit/sign_cubit.dart';
import 'Domain/UserData/user_cubit.dart';
import 'Domain/UserJourneysCubit/journeys_cubit.dart';
import 'Models/LocalStorage/db_helper_sharedPrefrences.dart';
import 'Presentation/Dialog/no_internet_connection.dart';
import 'Presentation/Modules/splash_screen.dart';

void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  await CacheHelper.init();
  runApp(
      MultiBlocProvider(
        providers: [
          BlocProvider (create: (_) => CheckConnectionCubit()..initialConnection()),
          BlocProvider(create: (_) => LiveLocationCubit()),
          BlocProvider(create: (_) => JourneysCubit()),
          BlocProvider (create: (_) => LocationCubit()..enable()),
          BlocProvider (create: (_) => HomeCubit()),
          BlocProvider (create : (_) => SignUpCubit()),
          BlocProvider(create: (_) => LogInCubit()),
          BlocProvider(create: (_) => UserCubit()),
        ],
          child: const RunningTrackingApp()
      )
  );
}
class RunningTrackingApp extends StatefulWidget {
  const RunningTrackingApp({Key? key}) : super(key: key);
  @override
  _RunningTrackingAppState createState() => _RunningTrackingAppState();
}

class _RunningTrackingAppState extends State<RunningTrackingApp> {
  final Location location = Location();
  late GoogleMapController googleMapController ;
  bool added = false;

  enable()async{
    await CheckConnectionCubit.get(context).initialConnection();
    await location.requestPermission();
    await LocationCubit.get(context).enable();
  }
  void initState() {
    // TODO: implement initState
    super.initState();
    enable();
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<CheckConnectionCubit , CheckConnectionState>(
      listener: (BuildContext context, state) {
        if( state is Connected ) {
          OneContext().popAllDialogs();
        }
        else if(state is DisConnected){
          OneContext().showDialog(
              builder: (context) => ShowCustomerDialog(
              title: "No Internet Connection.",
              subtitle: "Please check your internet connection and try again .",
              dismiss: false
          ));
        }
      },
      child: Sizer(
          builder: (context, orientation, deviceType) {
            return MaterialApp(
                debugShowCheckedModeBanner: false,
                builder: OneContext().builder,
                home: SplashScreen(),
              );
          }
      ),
    );
  }
}

