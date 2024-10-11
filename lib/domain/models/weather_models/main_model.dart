//Модель данных основных данных о погоде
class Main {
  final double temp;
  final double feelsLike;
  final int humidity;

  Main({
    required this.temp,
    required this.feelsLike,
    required this.humidity,
  });

  factory Main.fromJson(Map<String, dynamic> json) => Main(
        temp: json["temp"]?.toDouble(),
        feelsLike: json["feels_like"]?.toDouble(),
        humidity: json["humidity"],
      );

  Map<String, dynamic> toJson() => {
        "temp": temp,
        "feels_like": feelsLike,
        "humidity": humidity,
      };
}
