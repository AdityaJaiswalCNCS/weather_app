Flutter Weather App

A clean and modern Flutter Weather Application that shows real-time weather data with auto day/night theme, hourly forecast, and smooth UI animations, powered by the OpenWeather API.

✨ Features

🔍 Search weather by city name

🌗 Automatic Day / Night theme based on real weather data

⏱️ Hourly weather forecast

🌡️ Temperature in Celsius / Fahrenheit

🔄 Refresh weather data instantly

🎨 Smooth UI animations

📱 Responsive and clean UI

⚠️ Graceful error handling for invalid cities

🛠️ Tech Stack & Packages
Core Technologies

Flutter

Dart

Material UI

Packages & Libraries Used

http → REST API calls

dart:convert → JSON parsing

OpenWeather API → Weather data provider

📦 Dependencies
dependencies:
  flutter:
    sdk: flutter
  http: ^1.2.0


(JSON parsing is done using Dart’s built-in dart:convert library)

📂 Project Structure
lib/
 ├── main.dart
 ├── weather_screen.dart
 ├── weather_model.dart
 ├── weather_services.dart
 ├── hourly_forecast_item.dart
 ├── additional_info_item.dart
 └── secret.dart   # ignored (API key)
 🔑 API Key Setup

This project uses OpenWeather API.

Steps:

Sign up at
👉 https://openweathermap.org/api

Get your API key

Create file:

lib/secret.dart


Add:

const String openWeatherApiKey = 'YOUR_API_KEY';


Add to .gitignore:

lib/secret.dart

▶️ How to Run
flutter pub get
flutter run

🧠 JSON Handling (Important)

API responses are received in JSON format

Parsed using:

import 'dart:convert';


Converted into Dart models using WeatherModel.fromJson()

This keeps the code clean, safe, and scalable.


👨‍💻 Author

© Aditya Kumar Jaiswal
