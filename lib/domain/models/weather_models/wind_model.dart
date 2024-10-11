//Модель данных скорости ветра
class Wind {
  final double speed;

  Wind({
    required this.speed,
  });

  factory Wind.fromJson(Map<String, dynamic> json) => Wind(
        speed: json["speed"]?.toDouble(),
      );

  Map<String, dynamic> toJson() => {
        "speed": speed,
      };
}
