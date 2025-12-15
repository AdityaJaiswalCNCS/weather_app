class WeatherModel {
  final double temperature;   // in °C
  final String condition;     // Clear, Clouds, Rain, etc.
  final String icon;          // 01d, 01n, 02d, etc.
  final int humidity;         // %
  final int pressure;         // hPa
  final double windSpeed;     // m/s
  final DateTime dateTime;    // parsed DateTime

  WeatherModel({
    required this.temperature,
    required this.condition,
    required this.icon,
    required this.humidity,
    required this.pressure,
    required this.windSpeed,
    required this.dateTime,
  });

  // ✅ Factory constructor to parse OpenWeather API data
  factory WeatherModel.fromJson(Map<String, dynamic> json) {
    return WeatherModel(
      temperature: (json['main']['temp'] as num).toDouble(),
      condition: json['weather'][0]['main'],
      icon: json['weather'][0]['icon'], // 👈 DAY/NIGHT FIX
      humidity: json['main']['humidity'],
      pressure: json['main']['pressure'],
      windSpeed: (json['wind']['speed'] as num).toDouble(),
      dateTime: DateTime.parse(json['dt_txt']),
    );
  }
}
