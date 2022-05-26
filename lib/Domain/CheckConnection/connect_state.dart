abstract class CheckConnectionState {}
class Connected extends CheckConnectionState{}
class DisConnected extends CheckConnectionState{
  String error ;
  DisConnected(this.error);
}
class LoadingConnection extends CheckConnectionState{}