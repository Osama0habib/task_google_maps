part of 'map_bloc.dart';

abstract class MapEvent extends Equatable {
  const MapEvent();
}

class InitMapScreenEvent extends MapEvent {

  const InitMapScreenEvent();

  @override
  List<Object> get props => [];

}


class GetApiMarkerEvent extends MapEvent {


  const GetApiMarkerEvent();

  @override
  List<Object> get props => [];
}

class GetStreamMarkersEvent extends MapEvent {

  const GetStreamMarkersEvent();

  @override
  List<Object> get props => [];
}

class UpdateFirebaseLocationEvent extends MapEvent {
final Position position;
  const UpdateFirebaseLocationEvent(this.position);

  @override
  List<Object> get props => [];

}

class SteamLiveLocationEvent extends MapEvent {
  const SteamLiveLocationEvent();

  @override
  List<Object> get props => [];
}

class OnMapCreatedEvent extends MapEvent {
  final GoogleMapController controller;
  const OnMapCreatedEvent(this.controller);

  @override
  List<Object> get props => [controller];
}

