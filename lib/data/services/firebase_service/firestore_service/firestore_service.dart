import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:test_weather/domain/models/marker_model/user_marker.dart';

class FirestoreService {
  static final FirestoreService _singleton = FirestoreService._internal();
  factory FirestoreService() => _singleton;
  FirestoreService._internal();

  final String _nameOfCollection = 'markers';

  final FirebaseFirestore _fireStoreInstance = FirebaseFirestore.instance;

  Future<void> addMarker(UserMarker marker) async {
    final markersCollection = _fireStoreInstance.collection(_nameOfCollection);

    try {
      await markersCollection.add(marker.toJson());
    } catch (e) {
      print(e);
    }
  }

  Future<List<Marker?>> getMarkers() async {
    final markersCollection = _fireStoreInstance.collection(_nameOfCollection);
    List<Marker?> markers = [];
    try {
      await markersCollection.get().then((QuerySnapshot snapshot) {
        if (snapshot.docs.isNotEmpty) {
          for (var doc in snapshot.docs) {
            final userMarker =
                UserMarker.fromJson(doc.data()! as Map<String, dynamic>);
            final Marker marker = Marker(
                markerId: MarkerId(
                  UniqueKey().toString(),
                ),
                position: LatLng(userMarker.lat, userMarker.lon),
                infoWindow: InfoWindow(
                    title: userMarker.title, snippet: userMarker.snippet));
            markers.add(marker);
          }
          print(markers.map((toElement) => toElement.toString()));
          return markers;
        } else {
          return null;
        }
      });
    } catch (e) {
      print(e);
    }
    return markers;
  }
}
