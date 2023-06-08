import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:task_google_maps/task/domain/use_cases/get_location_stream_usecase.dart';
import 'package:task_google_maps/task/presentation/manager/location_bloc/location_bloc.dart';
import 'package:task_google_maps/task/presentation/manager/mapBloc/map_bloc.dart';

import '../../../core/service/service_locator.dart';

class HomePage extends StatelessWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider<MapBloc>(
      create: (context) => sl<MapBloc>()
        ..add(const InitMapScreenEvent()),
      child: Scaffold(
        appBar: AppBar(
          title: Text("MapScreen"),
        ),
        body: BlocBuilder<MapBloc, MapState>(
          builder: (context, state) {
            if (state.position == null) {
              return const Center(
                child: CircularProgressIndicator(),
              );
            } else {

              return GoogleMap(
                markers: Set<Marker>.of(state.markers.values),
                myLocationEnabled: true,
                initialCameraPosition: CameraPosition(
                    target: LatLng(state.position!.latitude,
                        state.position!.longitude),zoom: 8),
                onMapCreated: (GoogleMapController controller) {
                    context.read<MapBloc>().add(OnMapCreatedEvent(controller));
                    context
                        .watch<MapBloc>()
                        .add(const SteamLiveLocationEvent());

                },
              );
            }
          },
        ),
      ),
    );
  }
}
