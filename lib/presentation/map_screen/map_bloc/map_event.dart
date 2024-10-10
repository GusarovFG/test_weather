part of 'map_bloc.dart';

abstract class MapBlocEvent {
  const MapBlocEvent();
  List<Object> get props;
}

class GetMarkersEvent extends MapBlocEvent {
  @override
  List<Object> get props => [];
}

class AddMarkerEvent extends MapBlocEvent {
  final String title;
  final String snippet;
  final double lat;
  final double lon;

  AddMarkerEvent(this.title, this.snippet, this.lat, this.lon);

  @override
  List<Object> get props => [title, snippet, lat, lon];
}
