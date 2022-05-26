import 'package:bloc/bloc.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:task_final/Models/LiveData.dart';
import '../../Models/API/user_journeys.dart';
import 'journeys_status.dart';

class JourneysCubit extends Cubit<DisplayJourneyStatus>{
  JourneysCubit get(context) => BlocProvider.of(context);
  UserJourneysAPI userJourneysAPI = UserJourneysAPI();
  JourneysCubit() : super(LoadingJourneys()){
    userJourneysAPI.getJourneys().listen((result){
      List<LiveData> journrys = [];
      result.forEach((element){
        journrys.add(element);
      });
      emit(JourneysLoaded(journrys));
    }).onError((e){
      emit(JourneysFailed(e.toString()));
    });
  }
}