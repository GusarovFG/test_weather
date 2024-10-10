import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:test_weather/data/services/firebase_service/firestore_service/firestore_service.dart';
import 'package:test_weather/domain/models/marker_model/user_marker.dart';

part 'map_event.dart';
part 'map_state.dart';

class MapBloc extends Bloc<MapBlocEvent, MapBlocState> {
  MapBloc() : super(MapInitialState()) {
    on<MapBlocEvent>(
      (event, emit) async {
        try {
          emit(MapLoadingState());
          final markers = await FirestoreService().getMarkers();

          emit(MapSuccessMarkFetchingState(markers));
        } catch (e) {
          emit(const MapFailureState('Ошибка'));
          print(e.toString());
        }
      },
    );
    on<AddMarkerEvent>((event, emit) async {
      try {
        emit(MapLoadingState());
        await FirestoreService().addMarker(UserMarker(
            lat: event.lat,
            lon: event.lon,
            snippet: event.snippet,
            title: event.title));
        emit(MapMarkAddingState(massage: 'Марка добавлена'));
        emit(MapMarkAddingSuccess());
      } catch (e) {
        print(e.toString());
      }
    });
  }
}
