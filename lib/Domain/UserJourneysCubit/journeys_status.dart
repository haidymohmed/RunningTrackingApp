import 'package:task_final/Models/LiveData.dart';

class DisplayJourneyStatus{}
class LoadingJourneys extends DisplayJourneyStatus{}
class JourneysLoaded extends DisplayJourneyStatus{
  List<LiveData> list ;
  JourneysLoaded(this.list);
}
class JourneysFailed extends DisplayJourneyStatus{
  String error ;
  JourneysFailed(this.error);
}