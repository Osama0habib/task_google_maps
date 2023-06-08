import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:task_google_maps/core/service/location_service.dart';
import 'package:task_google_maps/core/utils/enums.dart';
import 'package:task_google_maps/task/domain/use_cases/get_api_marker_usecase.dart';

import '../../../../core/constants/app_constant.dart';
import '../../../../core/service/service_locator.dart';
import '../../../domain/entities/marker.dart';
import '../../../domain/use_cases/get_location_stream_usecase.dart';
import '../../../domain/use_cases/get_stream_markers_usecase.dart';
import '../../../domain/use_cases/update_firebase_location_usecase.dart';

part 'map_event.dart';

part 'map_state.dart';

class MapBloc extends Bloc<MapEvent, MapState> {
  final GetApiMarkersUseCase getApiMarkersUseCase;
  final UpdateFirebaseLocationUseCase updateFirebaseLocationUseCase;
  final GetStreamMarkersUseCase getStreamMarkersUseCase;
  final GetLocationStreamUseCase getLocationStreamUseCase;
  final Completer<GoogleMapController> _controller =
  Completer<GoogleMapController>();
  MapBloc(this.getApiMarkersUseCase, this.updateFirebaseLocationUseCase,
      this.getStreamMarkersUseCase, this.getLocationStreamUseCase)
      : super(const MapState()) {
    on<InitMapScreenEvent>(_initMapScreen);
    on<GetApiMarkerEvent>(_getApiMarker);
    on<GetStreamMarkersEvent>(_getStreamMarker);
    on<UpdateFirebaseLocationEvent>(_updateFirebaseLocation);
    on<SteamLiveLocationEvent>(_streamLiveLocation);
    on<OnMapCreatedEvent>(_onMapCreated);
  }

  Future<FutureOr<void>> _getApiMarker(
      GetApiMarkerEvent event, Emitter<MapState> emit) async {
    emit(state.copyWith(getMarkersState: RequestState.loading));
    final result = await getApiMarkersUseCase(
        GetApiMarkersParameter(token: user!.userToken));
    result.fold(
      (l) => emit(
        state.copyWith(
            getMarkersState: RequestState.error, errorMsg: l.message),
      ),
      (r) async {
        for (var e in r) {
          final marker = Marker(
              markerId: MarkerId(e.taskId),
              position: LatLng(double.parse(e.lat), double.parse(e.lng)),
              infoWindow: InfoWindow(title: e.name));
          state.markers[MarkerId(e.taskId)] = marker;

        }
        // print(r);

        emit(
          state.copyWith(
              getMarkersState: RequestState.loaded, markers: state.markers),
        );
      },
    );
  }

  FutureOr<void> _getStreamMarker(
      GetStreamMarkersEvent event, Emitter<MapState> emit) {
    final result = getStreamMarkersUseCase(
        GetStreamMarkersParameter(userId: user!.usersID));
    result.fold(
      (l) => emit(
        state.copyWith(
            streamMarkerState: RequestState.error, errorMsg: l.message),
      ),
      (r) {
        emit(
          state.copyWith(stream: r),
        );
      },
    );
  }

  FutureOr<void> _updateFirebaseLocation(
      UpdateFirebaseLocationEvent event, Emitter<MapState> emit) async {
    if (state.position != null) {
      final result = await updateFirebaseLocationUseCase(
          UpdateFirebaseLocationParameter(
              userId: user!.usersID, position: state.position!));
      result.fold(
        (l) => emit(
          state.copyWith(
              updateLocationState: RequestState.error, errorMsg: l.message),
        ),
        (r) {
          state.controller?.moveCamera(CameraUpdate.newLatLngBounds(getLatLngBounds(state.markers.values.toList()), 50));
          print("UpdateFirebaseLocaiton");

          emit(
            state.copyWith(
                updateLocationState: RequestState.loaded,
                position: event.position),
          );
        },
      );
    }
  }

  Future<FutureOr<void>> _initMapScreen(
      InitMapScreenEvent event, Emitter<MapState> emit) async {
    await determinePosition().then((value) {
      final marker = Marker(
          markerId: const MarkerId("MyMarker"),
          position: LatLng(value.latitude, value.longitude),
          rotation: value.heading,
          icon: BitmapDescriptor.defaultMarkerWithHue(20),
          infoWindow: const InfoWindow(title: "MyLocation"));
      if (state.markers.isEmpty) {
        final Map<MarkerId, Marker> newMap = {};
        newMap[MarkerId("MyMarker")] = marker;
        emit(state.copyWith(position: value, markers: newMap));
      } else {
        state.markers[const MarkerId("MyMarker")] = marker;
        emit(state.copyWith(position: value, markers: state.markers));
      }
    });
  }

  Future<FutureOr<void>> _streamLiveLocation(
      SteamLiveLocationEvent event, Emitter<MapState> emit) async {
    final permission = await Geolocator.checkPermission();
    final result = getLocationStreamUseCase(
        GetLocationStreamParameter(permission: permission));
    result.fold(
      (l) => emit(
        state.copyWith(
            updateLocationState: RequestState.error, errorMsg: l.message),
      ),
      (r) async {
        r.listen((event) {
          add(UpdateFirebaseLocationEvent(event));
        });
      },
    );
  }

  LatLngBounds getLatLngBounds(List<Marker> markers) {
    double minLat = double.infinity;
    double maxLat = -double.infinity;
    double minLng = double.infinity;
    double maxLng = -double.infinity;

    for (Marker marker in markers) {
      LatLng position = marker.position;

      if (position.latitude < minLat) {
        minLat = position.latitude;
      }
      if (position.latitude > maxLat) {
        maxLat = position.latitude;
      }
      if (position.longitude < minLng) {
        minLng = position.longitude;
      }
      if (position.longitude > maxLng) {
        maxLng = position.longitude;
      }
    }

    LatLng southwest = LatLng(minLat, minLng);
    LatLng northeast = LatLng(maxLat, maxLng);

    return LatLngBounds(southwest: southwest, northeast: northeast);
  }

  Future<FutureOr<void>> _onMapCreated(
      OnMapCreatedEvent event, Emitter<MapState> emit) async {
     add(const GetApiMarkerEvent());

    await event.controller.animateCamera(CameraUpdate.newLatLngZoom(
        LatLng(state.position!.latitude, state.position!.longitude), 8));

    emit(state.copyWith(controller: event.controller));
     _controller.complete(event.controller);
  }
}
