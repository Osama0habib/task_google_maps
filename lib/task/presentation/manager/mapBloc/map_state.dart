part of 'map_bloc.dart';

class MapState extends Equatable {
  final StreamSubscription<DatabaseEvent>? stream;
  final Map<MarkerId, Marker> markers;
  final Position? position;
  final RequestState getMarkersState;
  final RequestState streamMarkerState;
  final RequestState updateLocationState;
  final String errorMsg;
  final GoogleMapController? controller;

  const MapState({
    this.stream,
    this.controller,
    this.errorMsg = "",
    this.markers = const {},
    this.position,
    this.getMarkersState = RequestState.idle,
    this.streamMarkerState = RequestState.idle,
    this.updateLocationState = RequestState.idle});

  MapState copyWith({
    StreamSubscription<DatabaseEvent>? stream,
    Map<MarkerId, Marker>? markers,
    Position? position,
    RequestState? getMarkersState,
    RequestState? streamMarkerState,
    RequestState? updateLocationState,
    String? errorMsg,
    GoogleMapController? controller,
  }) =>
      MapState(
        stream: stream ?? this.stream,
        markers: markers ?? this.markers,
        position: position ?? this.position,
        getMarkersState: getMarkersState ?? this.getMarkersState,
        streamMarkerState: streamMarkerState ?? this.streamMarkerState,
        updateLocationState: updateLocationState ?? this.updateLocationState,
        errorMsg: errorMsg ?? this.errorMsg,
        controller: controller ?? this.controller,
      );


  @override
  List<Object?> get props =>
      [
        stream,
        markers,
        position,
        getMarkersState,
        streamMarkerState,
        updateLocationState,
        errorMsg,
        controller,
      ];
}
