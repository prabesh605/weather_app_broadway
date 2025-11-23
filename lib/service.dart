import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:weather_app/weather_model.dart';

class WeatherService {
  final apiKey = "0b10461d5a30e6612ce19d84c97ef651#";

  Future<Weather> fetchWeather(String cityName) async {
    try {
      final baseUrl =
          "https://api.openweathermap.org/data/2.5/weather?q=$cityName&units=metric&appid=";

      final response = await http.get(Uri.parse(baseUrl + apiKey));

      response.statusCode;
      print("Status code: ${response.statusCode}");
      final data = jsonDecode(response.body);
      final weatherData = Weather.fromJson(data);

      //step 3 decode the response
      // final weatherData = Weather.fromJson(data);
      return weatherData;
    } catch (e) {
      throw Exception('Failed to load weather data: $e');
    }
  }

  Future<Weather> fetchWeatherByLocation(double lat, double lon) async {
    //latitude
    //longitude
    String baseUrl =
        "https://api.openweathermap.org/data/2.5/weather?lat=$lat&lon=$lon&appid=$apiKey";
    final response = await http.get(Uri.parse(baseUrl));
    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);
      final weatherData = Weather.fromJson(data);
      print(weatherData);
      return weatherData;
    } else {
      throw Exception('Failed to load weather data');
    }
  }
}


// setState(() {
      //   //step 4 map in variables
      //   temperature = weatherData.main.temp.toString();
      //   humidity = weatherData.main.humidity.toString();
      //   speed = weatherData.wind.speed.toString();
      //   // temperature = "${data['main']['temp']}";
      //   // humidity = "${data['main']['humidity']}";
      //   // speed = "${data['wind']['speed']}";
      // });

      //  setState(() {
      //   temperature = "Not found";
      // });

      // print(e.toString());