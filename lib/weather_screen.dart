import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:weather_app/service.dart';
import 'package:weather_app/weather_model.dart';
import 'package:geolocator/geolocator.dart';

class WeatherScreen extends StatefulWidget {
  const WeatherScreen({super.key});

  @override
  State<WeatherScreen> createState() => _WeatherScreenState();
}

class _WeatherScreenState extends State<WeatherScreen> {
  String cityName = "Kathmandu";
  String temperature = "";

  String humidity = "";
  String speed = '';
  final searchController = TextEditingController();
  WeatherService weatherService = WeatherService();

  // Future<Position> getCurrentLocation() async {
  //   bool serviceEnabled;
  //   LocationPermission permission;

  //   serviceEnabled = await Geolocator.isLocationServiceEnabled();
  //   if (!serviceEnabled) {
  //     return Future.error('Location services are disabled.');
  //   }

  //   permission = await Geolocator.checkPermission();
  //   if (permission == LocationPermission.denied) {
  //     permission = await Geolocator.requestPermission();
  //     if (permission == LocationPermission.denied) {
  //       return Future.error('Location permissions are denied');
  //     }
  //   }

  //   if (permission == LocationPermission.deniedForever) {
  //     return Future.error(
  //       'Location permissions are permanently denied, we cannot request permissions.',
  //     );
  //   }

  //   return await Geolocator.getCurrentPosition();
  // }

  Future<Position> getCurrentLocation() async {
    // LocationPermission permission;
    await Geolocator.checkPermission();
    await Geolocator.requestPermission();

    // permission =
    // await Geolocator.requestPermission();

    Position position = await Geolocator.getCurrentPosition(
      desiredAccuracy: LocationAccuracy.low,
    );
    return position;
    // print(position.latitude);
    // print(position.longitude);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[200],
      appBar: AppBar(
        backgroundColor: Colors.blueAccent,
        title: Text("Weather App"),
      ),
      drawer: Drawer(child: DrawerHeader(child: Text("This is drawer"))),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(12.0),
            child: TextField(
              controller: searchController,
              decoration: InputDecoration(
                prefixIcon: Icon(Icons.search),
                labelText: "Enter City Name",
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
              ),
            ),
          ),
          ElevatedButton(
            onPressed: () {
              weatherService.fetchWeather(searchController.text);
            },
            child: Text("Get Weather"),
          ),
          ElevatedButton(
            onPressed: () async {
              Position positions = await getCurrentLocation();
              double lat = positions.latitude;
              double lon = positions.longitude;
              final Weather data = await weatherService.fetchWeatherByLocation(
                lat,
                lon,
              );
              setState(() {
                temperature = data.main.temp.toString();
                humidity = data.main.humidity.toString();
                speed = data.wind.speed.toString();
              });
            },
            child: Text("Get current weather "),
          ),
          Column(
            children: [
              Text(
                "Your Temperature is $temperature",
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
              ),
              SizedBox(height: 20),
              Text(
                "Your humidity is $humidity",
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
              ),
              SizedBox(height: 20),
              Text(
                "Wind Speed is $speed",
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
              ),
              SizedBox(height: 20),
            ],
          ),
        ],
      ),
    );
  }
}
// double temp = weatherData['main']['temp'];
  //     temperature = temp.toInt();
  //     var condition = weatherData['weather'][0]['id'];
  //     weatherIcon = weather.getWeatherIcon(condition);
  //     weatherMessage = weather.getMessage(temperature);
  //     cityName = weatherData['name'];

  // Future<void> getCurrentLocation() async {
  //   try {
  //     Position position = await Geolocator()
  //         .getCurrentPosition(desiredAccuracy: LocationAccuracy.low);

  //     latitude = position.latitude;
  //     longitude = position.longitude;
  //   } catch (e) {
  //     print(e);
  //   }
  // }
//     String getWeatherIcon(int condition) {
//     if (condition < 300) {
//       return '🌩';
//     } else if (condition < 400) {
//       return '🌧';
//     } else if (condition < 600) {
//       return '☔️';
//     } else if (condition < 700) {
//       return '☃️';
//     } else if (condition < 800) {
//       return '🌫';
//     } else if (condition == 800) {
//       return '☀️';
//     } else if (condition <= 804) {
//       return '☁️';
//     } else {
//       return '🤷‍';
//     }
//   }

//   String getMessage(int temp) {
//     if (temp > 25) {
//       return 'It\'s 🍦 time';
//     } else if (temp > 20) {
//       return 'Time for shorts and 👕';
//     } else if (temp < 10) {
//       return 'You\'ll need 🧣 and 🧤';
//     } else {
//       return 'Bring a 🧥 just in case';
//     }
//   }
// }