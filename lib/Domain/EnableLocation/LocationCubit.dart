import 'package:bloc/bloc.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:location/location.dart';
import 'package:location/location.dart';
import 'package:task_final/Presentation/Dialog/toaste.dart';
import '../../Models/API/LocationApi.dart';
import '../../Models/LiveData.dart';
import 'LocationStatus.dart';

class LocationCubit extends Cubit<LocationStatus>{
  LocationCubit() : super(LoadingLocation());
  static LocationCubit get(context) =>BlocProvider.of(context);
  LocationApi locationApi = LocationApi();
  Location location = Location();
  late String _address = "null";
  late LiveData liveData ;
  enable() async {
    await Location().serviceEnabled().then((value){
      if(!value){
        Location().requestService();
      }
    }).catchError((onError){
      showToastError(msg: "Enable Location", state: ToastedStates.ERROR);
    });
    Location().hasPermission().then((value){
      if(value == PermissionStatus.denied){
        Location().requestPermission();
      }
    }).catchError((e){
      showToastError(msg: "Enable Location", state: ToastedStates.ERROR);
    });
  }
  setCurrentLocation()async {
  Location().getLocation().then((value){
    LocationApi locationApi = LocationApi();
    locationApi.setLocation(LiveData(
        latitude_1: value.latitude!,
        latitude_2: value.latitude!,
        longitude_1: value.longitude!,
        longitude_2: value.longitude!,
        distance: 0,
        cal: 0,
        source: "source",
        destination: "destination")
    );
  }).catchError((e){
    showToastError(msg: "Enable Location", state: ToastedStates.ERROR);
  });
  }
  getLocation(){
    return _checkLocation();
  }
  Future<bool> _checkLocation(){
    return Location.instance.serviceEnabled().then((value){
      return value;
    });
  }
}