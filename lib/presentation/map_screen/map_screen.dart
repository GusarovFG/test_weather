import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:test_weather/data/services/location_service/location_service.dart';
import 'package:test_weather/presentation/map_screen/add_marker_dialog.dart';
import 'package:test_weather/presentation/map_screen/map_bloc/map_bloc.dart';

class MapScreen extends StatefulWidget {
  const MapScreen({super.key});

  @override
  State<MapScreen> createState() => MapScreenState();
}

class MapScreenState extends State<MapScreen> {
  final Completer<GoogleMapController> _controller =
      Completer<GoogleMapController>();

  static const CameraPosition _kGooglePlex = CameraPosition(
    target: LatLng(0, 0),
    zoom: 14.4746,
  );

  final _mapBloc = MapBloc();

  @override
  void initState() {
    getCurrentLocation();
    _mapBloc.add(GetMarkersEvent());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: BlocBuilder<MapBloc, MapBlocState>(
        bloc: _mapBloc,
        builder: (context, state) {
          switch (state.runtimeType) {
            case const (MapSuccessMarkFetchingState):
              final success = state as MapSuccessMarkFetchingState;

              return GoogleMap(
                mapType: MapType.hybrid,
                initialCameraPosition: _kGooglePlex,
                onMapCreated: (GoogleMapController controller) {
                  _controller.complete(controller);
                },
                markers: Set.from(success.markers),
                onLongPress: (argument) {
                  final titleController = TextEditingController();
                  final snippetController = TextEditingController();

                  showDialog(
                    context: context,
                    builder: (_) {
                      return AddMarkerDialog(
                        titleController: titleController,
                        snippetController: snippetController,
                        argument: argument,
                      );
                    },
                  );
                },
              );
            case const (MapLoadingState):
              return const Center(child: CircularProgressIndicator());
            default:
              return Container();
          }
        },
      ),
    );
  }

  Future<void> getCurrentLocation() async {
    final GoogleMapController controller = await _controller.future;

    final location = await LocationServiceImpl().getLocation();
    final lon = location?.longitude;
    final lat = location?.latitude;

    final CameraPosition position = CameraPosition(
      target: LatLng(lat ?? 0, lon ?? 0),
      zoom: 16,
    );
    await controller.animateCamera(CameraUpdate.newCameraPosition(position));
  }
}
