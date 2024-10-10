part of 'map_bloc.dart';

abstract class MapBlocState {
  const MapBlocState();

  List<Object> get props => [];
}

class MapInitialState extends MapBlocState {}

class MapLoadingState extends MapBlocState {}

class MapSuccessMarkFetchingState extends MapBlocState {
  final List<Marker?> markers;

  const MapSuccessMarkFetchingState(this.markers);
  @override
  List<Object> get props => [markers];
}

class MapMarkAddingState extends MapBlocState {
  final String massage;
  MapMarkAddingState({required this.massage});
}

class MapMarkAddingSuccess extends MapBlocState {}

class MapFailureState extends MapBlocState {
  final String errorMessage;

  const MapFailureState(this.errorMessage);

  @override
  List<Object> get props => [errorMessage];
}
