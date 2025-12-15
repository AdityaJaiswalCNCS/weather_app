import 'dart:ui';
import 'package:flutter/material.dart';
import 'weather_services.dart';
import 'hourly_forecast_item.dart';
import 'additional_info_item.dart';
import 'weather_model.dart';

class WeatherScreen extends StatefulWidget {
  const WeatherScreen({super.key});

  @override
  State<WeatherScreen> createState() => _WeatherScreenState();
}

class _WeatherScreenState extends State<WeatherScreen> {
  final WeatherService service = WeatherService();
  final TextEditingController controller = TextEditingController();

  late Future<List<WeatherModel>> weatherFuture;
  String city = "Delhi";
  bool isCelsius = true;

  @override
  void initState() {
    super.initState();
    weatherFuture = fetchWeatherModels(city);
  }

  // Kelvin → C / F
  double convertTemp(double kelvin) =>
      isCelsius ? kelvin - 273.15 : (kelvin - 273.15) * 9 / 5 + 32;

  // 🌙 Day/Night check
  bool isNight(String iconCode) => iconCode.endsWith('n');

  // 🌤 Weather icon logic
  IconData getWeatherIcon(String iconCode) {
    if (iconCode.endsWith('n')) return Icons.nightlight_round;

    switch (iconCode.substring(0, 2)) {
      case '01':
        return Icons.wb_sunny;
      case '02':
      case '03':
      case '04':
        return Icons.cloud;
      case '09':
      case '10':
        return Icons.grain;
      case '11':
        return Icons.flash_on;
      case '13':
        return Icons.ac_unit;
      case '50':
        return Icons.blur_on;
      default:
        return Icons.cloud;
    }
  }

  // API → Model mapping (SAFE)
  Future<List<WeatherModel>> fetchWeatherModels(String city) async {
    final data = await service.fetchWeather(city);

    if (!data.containsKey('list')) {
      throw Exception('Weather data unavailable');
    }

    final List list = data['list'];
    return list.map((e) => WeatherModel.fromJson(e)).toList();
  }

  String formatTime(DateTime dt) =>
      "${dt.hour.toString().padLeft(2, '0')}:${dt.minute.toString().padLeft(2, '0')}";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: FutureBuilder<List<WeatherModel>>(
        future: weatherFuture,
        builder: (context, snapshot) {
          // ⏳ Loading
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          }

          // ❌ Error (clean message)
          if (snapshot.hasError) {
            return Center(
              child: Padding(
                padding: const EdgeInsets.all(16),
                child: Text(
                  snapshot.error
                      .toString()
                      .replaceAll('Exception:', '')
                      .trim(),
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 16,
                  ),
                  textAlign: TextAlign.center,
                ),
              ),
            );
          }

          final weatherList = snapshot.data!;
          final current = weatherList.first;

          return Container(
            // 🌗 AUTO DAY / NIGHT BACKGROUND
            decoration: BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                colors: isNight(current.icon)
                    ? const [
                  Color(0xFF0F2027),
                  Color(0xFF203A43),
                  Color(0xFF2C5364),
                ]
                    : const [
                  Color(0xFF56CCF2),
                  Color(0xFF2F80ED),
                ],
              ),
            ),
            child: SafeArea(
              child: ListView(
                padding: const EdgeInsets.all(16),
                children: [
                  // 🔝 Top bar
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Text(
                        "Weather App",
                        style: TextStyle(
                          fontSize: 22,
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                        ),
                      ),
                      Row(
                        children: [
                          IconButton(
                            icon: const Icon(Icons.refresh,
                                color: Colors.white),
                            onPressed: () {
                              setState(() {
                                weatherFuture =
                                    fetchWeatherModels(city);
                              });
                            },
                          ),
                          Switch(
                            value: isCelsius,
                            onChanged: (v) =>
                                setState(() => isCelsius = v),
                          ),
                        ],
                      ),
                    ],
                  ),

                  const SizedBox(height: 20),

                  // 🔍 Search
                  TextField(
                    controller: controller,
                    style: const TextStyle(color: Colors.white),
                    decoration: InputDecoration(
                      hintText: "Search city",
                      hintStyle:
                      const TextStyle(color: Colors.white70),
                      suffixIcon: IconButton(
                        icon: const Icon(Icons.search,
                            color: Colors.white),
                        onPressed: () {
                          final input =
                          controller.text.trim();
                          if (input.isEmpty) return;

                          setState(() {
                            city = input;
                            weatherFuture =
                                fetchWeatherModels(city);
                          });
                        },
                      ),
                      enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12),
                        borderSide:
                        const BorderSide(color: Colors.white70),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12),
                        borderSide:
                        const BorderSide(color: Colors.white),
                      ),
                    ),
                  ),

                  const SizedBox(height: 20),

                  // 🌡 Current Weather (animated)
                  AnimatedSlide(
                    duration: const Duration(milliseconds: 600),
                    offset: const Offset(0, 0),
                    child: AnimatedOpacity(
                      duration:
                      const Duration(milliseconds: 600),
                      opacity: 1,
                      child: ClipRRect(
                        borderRadius:
                        BorderRadius.circular(16),
                        child: BackdropFilter(
                          filter: ImageFilter.blur(
                              sigmaX: 10, sigmaY: 10),
                          child: Card(
                            color:
                            Colors.white.withOpacity(0.2),
                            child: Padding(
                              padding:
                              const EdgeInsets.all(16),
                              child: Column(
                                children: [
                                  Text(
                                    "${convertTemp(current.temperature).toStringAsFixed(1)}°${isCelsius ? 'C' : 'F'}",
                                    style: const TextStyle(
                                      fontSize: 32,
                                      fontWeight:
                                      FontWeight.bold,
                                      color: Colors.white,
                                    ),
                                  ),
                                  const SizedBox(height: 10),
                                  AnimatedSwitcher(
                                    duration: const Duration(
                                        milliseconds: 500),
                                    transitionBuilder:
                                        (child, animation) =>
                                        ScaleTransition(
                                            scale: animation,
                                            child: child),
                                    child: Icon(
                                      getWeatherIcon(
                                          current.icon),
                                      key: ValueKey(
                                          current.icon),
                                      size: 60,
                                      color: Colors.white,
                                    ),
                                  ),
                                  const SizedBox(height: 10),
                                  Text(
                                    current.condition,
                                    style: const TextStyle(
                                      fontSize: 20,
                                      color: Colors.white,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),

                  const SizedBox(height: 20),

                  // ⏱ Hourly Forecast
                  const Text(
                    'Hourly Forecast',
                    style: TextStyle(
                        fontSize: 22,
                        fontWeight: FontWeight.bold,
                        color: Colors.white),
                  ),
                  const SizedBox(height: 8),
                  SingleChildScrollView(
                    scrollDirection: Axis.horizontal,
                    child: Row(
                      children: List.generate(
                        weatherList.length > 7
                            ? 6
                            : weatherList.length - 1,
                            (index) {
                          final hourly =
                          weatherList[index + 1];
                          return TweenAnimationBuilder(
                            tween:
                            Tween<double>(begin: 0, end: 1),
                            duration: Duration(
                                milliseconds:
                                300 + index * 100),
                            builder:
                                (context, value, child) {
                              return Transform.translate(
                                offset: Offset(
                                    0, 20 * (1 - value)),
                                child: Opacity(
                                    opacity: value,
                                    child: child),
                              );
                            },
                            child: HourlyForecastItem(
                              time:
                              formatTime(hourly.dateTime),
                              icon: getWeatherIcon(
                                  hourly.icon),
                              temperature:
                              "${convertTemp(hourly.temperature).toStringAsFixed(1)}°${isCelsius ? 'C' : 'F'}",
                            ),
                          );
                        },
                      ),
                    ),
                  ),

                  const SizedBox(height: 20),

                  // ℹ Additional Info
                  Row(
                    mainAxisAlignment:
                    MainAxisAlignment.spaceEvenly,
                    children: [
                      AdditionalInfoItem(
                        icon: Icons.water_drop,
                        label: 'Humidity',
                        value: '${current.humidity}%',
                      ),
                      AdditionalInfoItem(
                        icon: Icons.air,
                        label: 'Wind',
                        value:
                        '${current.windSpeed} m/s',
                      ),
                      AdditionalInfoItem(
                        icon: Icons.speed,
                        label: 'Pressure',
                        value:
                        '${current.pressure} hPa',
                      ),
                    ],
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
