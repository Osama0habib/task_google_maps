import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:geolocator/geolocator.dart';
import 'package:meta/meta.dart';

part 'location_event.dart';
part 'location_state.dart';

class LocationBloc extends Bloc<LocationEvent, LocationState> {
  final Geolocator geolocator;
  late StreamSubscription _locationSubscription;
  LocationBloc(this.geolocator)
      : super(LocationInitial());

  @override
  LocationState get initialState => LocationInitial();

    @override
    Stream<LocationState> mapEventToState(
        LocationEvent event,) async* {
      if (event is LocationStarted) {
        yield LocationLoadInProgress();
        _locationSubscription.cancel();
        _locationSubscription = Geolocator.getPositionStream().listen(
              (Position position) => add(
            LocationChanged(position: position),
          ),
        );
      } else if (event is LocationChanged) {
        yield LocationLoadSuccess(position: event.position);
      }
    }

    @override
    Future<void> close() {
      _locationSubscription?.cancel();
      return super.close();
    }


}
