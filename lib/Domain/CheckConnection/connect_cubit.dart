import 'package:bloc/bloc.dart';
import 'package:connectivity/connectivity.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'connect_state.dart';

class CheckConnectionCubit extends Cubit<CheckConnectionState>{
  final Connectivity connectivity = Connectivity();
  late bool isConnected = false;
  static CheckConnectionCubit get(context) => BlocProvider.of(context) ;
  CheckConnectionCubit() : super(
      LoadingConnection()
  );
  initialConnection()async{
    connectivity.onConnectivityChanged.listen(connectChange);
  }
  Future<bool?> checkConnection(ConnectivityResult connectivityResult) async{
    if(ConnectivityResult.none == connectivityResult){
      isConnected = false;
      emit(DisConnected("Error"));
    }
    else{
      isConnected = true;
      emit(Connected());
    }
    return null;
  }
  connectChange(ConnectivityResult connectivityResult){
    print("check Connection");
    checkConnection(connectivityResult);
  }
}