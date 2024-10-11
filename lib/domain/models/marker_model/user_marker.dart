//Модель данных о маркере google_maps
class UserMarker {
  final double lat;
  final double lon;
  final String snippet;
  final String title;

  UserMarker({
    required this.lat,
    required this.lon,
    required this.snippet,
    required this.title,
  });

  factory UserMarker.fromJson(Map<String, dynamic> json) => UserMarker(
        lat: json["lat"]?.toDouble(),
        lon: json["lon"]?.toDouble(),
        snippet: json["snippet"],
        title: json["title"],
      );

  Map<String, dynamic> toJson() => {
        "lat": lat,
        "lon": lon,
        "snippet": snippet,
        "title": title,
      };
}
