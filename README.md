Flutter Weather App

A clean and modern Flutter Weather Application that displays real-time weather data using the OpenWeather API.
The app features automatic day/night theme, hourly forecast and reactive UI powered by Provider state management.

✨ Features

🔍 Search weather by city name

🌗 Automatic Day/Night theme based on real weather data

⏱ Hourly weather forecast

🌡 Temperature toggle (Celsius / Fahrenheit)

🔄 Instant weather refresh

⚡ Reactive UI using Provider

📡 Real-time weather from OpenWeather API

🎨 Smooth animations and clean UI

⚠ Graceful error handling for invalid city / network

🛠 Tech Stack

Framework: Flutter (Dart)
State Management: Provider
Networking: http package
API: OpenWeather API
Data Handling: JSON parsing (dart:convert)

📦 Dependencies
dependencies:
  flutter:
    sdk: flutter
  http: ^1.6.0
  provider: ^6.0.5

📂 Project Structure
lib/
 ├── main.dart
 ├── weather_screen.dart
 ├── weather_provider.dart
 ├── weather_services.dart
 ├── weather_model.dart
 ├── hourly_forecast_item.dart
 ├── additional_info_item.dart
 └── secret.dart (ignored)

🔑 API Key Setup

Sign up → https://openweathermap.org/api

Get API key

Create file:

lib/secret.dart


Add:

const String openWeatherApiKey = 'YOUR_API_KEY';


Add to .gitignore:

lib/secret.dart

▶️ Run Project
flutter pub get
flutter run

👨‍💻 Author

Aditya Kumar Jaiswal
GitHub: https://github.com/AdityaJaiswalCNCS
