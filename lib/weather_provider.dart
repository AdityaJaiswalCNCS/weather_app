import 'package:flutter/material.dart';
import 'weather_services.dart';

class WeatherProvider extends ChangeNotifier {
  final WeatherService _service = WeatherService();

  Map<String, dynamic>? weatherData;
  bool isLoading = false;
  String? error;

  Future<void> fetchWeather(String city) async {
    isLoading = true;
    error = null;
    notifyListeners();

    try {
      weatherData = await _service.fetchWeather(city);
    } catch (e) {
      error = e.toString().replaceAll('Exception:', '').trim();
      weatherData = null; // clear old data
    }

    isLoading = false;
    notifyListeners();
  }
}
