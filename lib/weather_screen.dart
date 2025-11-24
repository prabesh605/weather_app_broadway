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
  int codition = 0;
  String iconValue = '';
  String myMessage = "";
  final searchController = TextEditingController();
  WeatherService weatherService = WeatherService();
  String? selectedCity;
  final List<String> popularCities = [
    'Kathmandu',
    "Pokhara",
    "Delhi",
    "Mumbai",
    "New York",
    "London",
    "Tokyo",
  ];

  // DropdownButton<String>(
  //               hint: Icon(Icons.public, color: Colors.white),
  //               value: selectedCity,
  //               dropdownColor: Colors.blueAccent,
  //               underline: SizedBox(),
  //               iconEnabledColor: Colors.white,
  //               items: popularCities.map((city) {
  //                 return DropdownMenuItem(
  //                   value: city,
  //                   child: Text(
  //                     city,
  //                     style: TextStyle(color: Colors.white),
  //                   ),
  //                 );
  //               }).toList(),
  //               onChanged: (value) {
  //                 if (value != null) {
  //                   selectedCity = value;
  //                   fetchWeatherForCity(value);
  //                 }
  //               },
  //             ),

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
      backgroundColor: Colors.blueGrey[200],
      appBar: AppBar(
        backgroundColor: Colors.blueAccent,
        title: Text("Weather App"),
        actions: [
          DropdownButton<String>(
            items: popularCities.map((a) {
              return DropdownMenuItem(value: a, child: Text(a));
            }).toList(),
            // items: [
            //   DropdownMenuItem(child: Text("Kathmandu"), value: "Kathmandu"),
            //   DropdownMenuItem(child: Text("Pokhara"), value: "Kathmandu"),
            //   DropdownMenuItem(child: Text("China"), value: "China"),
            //   DropdownMenuItem(child: Text("India"), value: "India"),
            // ],
            hint: Text("Select a city"),
            onChanged: (value) async {
              print(value);
              selectedCity = value.toString();
              print(selectedCity);
              final data = await weatherService.fetchWeather(selectedCity!);
              final iconData = weatherService.getWeatherIcon(data.cod);
              final message = weatherService.getMessage(data.main.temp.toInt());
              setState(() {
                temperature = data.main.temp.toString();
                humidity = data.main.humidity.toString();
                speed = data.wind.speed.toString();
                codition = data.cod;
                iconValue = iconData;
                myMessage = message;
              });

              // print(icon);
            },
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
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
        child: Icon(Icons.location_city),
      ),
      drawer: Drawer(child: DrawerHeader(child: Text("This is drawer"))),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Row(
            children: [
              Expanded(
                child: Padding(
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
              ),
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.blueAccent,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(4),
                  ),
                ),
                onPressed: () {
                  weatherService.fetchWeather(searchController.text);
                },
                child: Text("Search", style: TextStyle(color: Colors.white)),
              ),
              SizedBox(width: 10),
            ],
          ),

          Column(
            // mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Spacer(),
              SizedBox(height: 200),
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
              Text(iconValue, style: TextStyle(fontSize: 100)),
              Text(myMessage, style: TextStyle(fontSize: 40)),
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