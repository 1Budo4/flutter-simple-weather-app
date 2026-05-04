import "package:flutter/material.dart";
import "package:geolocator/geolocator.dart";
import "package:lottie/lottie.dart";
import "package:simple_weather_app/models/weather_model.dart";
import "package:simple_weather_app/services/weather_service.dart";

class WeatherPage extends StatefulWidget {
  const WeatherPage({super.key});

  @override
  State<WeatherPage> createState() => _WeatherPageState();
}

class _WeatherPageState extends State<WeatherPage> {
  final _weatherService = WeatherService("6102794ca7a3eeb69ab4abfed990109d");
  Weather? _weather;

  Future<void> _fetchWeather() async {
    String city = await _weatherService.getCurrentCity();

    try {
      final weather = await _weatherService.getWeather(city);
      setState(() {
        _weather = weather;
      });
    } catch (e) {
      print(e);
    }
  }

  String _getWeatherAnimation(String? mainCondition) {
    if (mainCondition == null) return 'assets/sun.json';

    switch (mainCondition.toLowerCase()) {
      case 'fog':
        return 'assets/cloud.json';
      case 'shower rain':
        return "assets/rain.json";
      case 'thunderstorm':
        return "assets/storm.json";
      default:
        return 'assets/sun.json';
    }
  }

  @override
  void initState() {
    super.initState();
    _fetchWeather();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[900],
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              '${_weather?.cityName ?? "Loading..."}, ${_weather?.countryAbbr ?? ""}',
              style: TextStyle(color: Colors.white, fontSize: 32),
            ),

            SizedBox(height: 12),

            Lottie.asset(_getWeatherAnimation(_weather?.mainCondition)),

            SizedBox(height: 12),

            Text(
              '${_weather?.temperature.round()}°C',
              style: TextStyle(color: Colors.white, fontSize: 18),
            ),

            Text(
              _weather?.mainCondition ?? "",
              style: TextStyle(color: Colors.white, fontSize: 18),
            ),
          ],
        ),
      ),
    );
  }
}
