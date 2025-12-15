import 'dart:convert';
import 'package:http/http.dart' as http;

class WeatherService {
  static const String _apiKey = '1c8da9e3391c67eeb1ee89c5b72ad27c';

  Future<Map<String, dynamic>> fetchWeather(String city) async {
    final url = Uri.parse(
      'https://api.openweathermap.org/data/2.5/forecast?q=$city&appid=$_apiKey',
    );

    final response = await http.get(url);
    final data = json.decode(response.body);

    if (response.statusCode == 200) {
      return data;
    } else {
      // 👇 OpenWeather gives useful error messages
      throw Exception(data['message'] ?? 'City not found');
    }
  }
}
