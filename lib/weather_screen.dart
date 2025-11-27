import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:weather_app/service.dart';
import 'package:weather_app/weather_model.dart';
import 'package:geolocator/geolocator.dart';
import 'package:intl/intl.dart';
import 'package:animated_text_kit/animated_text_kit.dart';

class WeatherScreen extends StatefulWidget {
  const WeatherScreen({super.key});

  @override
  State<WeatherScreen> createState() => _WeatherScreenState();
}

class _WeatherScreenState extends State<WeatherScreen> {
  String cityName = "Kathmandu";
  String temperature = "18";

  String humidity = "21";
  String speed = '21';
  int codition = 0;
  String iconValue = '🤷';
  String myMessage = "";
  String locationName = "Your City";
  final now = DateTime.now();
  DateFormat dateFormat = DateFormat('MMM d, yyy');
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

  // Future<Position> getCurrentLocation() async {
  //   // LocationPermission permission;
  //   await Geolocator.checkPermission();
  //   await Geolocator.requestPermission();

  //   // permission =
  //   // await Geolocator.requestPermission();

  //   Position position = await Geolocator.getCurrentPosition(
  //     desiredAccuracy: LocationAccuracy.low,
  //   );
  //   return position;
  //   // print(position.latitude);
  //   // print(position.longitude);
  // }

  Future<Position> getCurrentLocation() async {
    bool serviceEnabled;
    LocationPermission permission;

    serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      return Future.error('Location services are disabled.');
    }

    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        return Future.error('Location permissions are denied');
      }
    }

    if (permission == LocationPermission.deniedForever) {
      return Future.error(
        'Location permissions are permanently denied, we cannot request permissions.',
      );
    }

    return await Geolocator.getCurrentPosition();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFF111438),
      appBar: AppBar(
        backgroundColor: Color(0xff1B1E48),
        title: Text("Weather App", style: TextStyle(color: Colors.white)),
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
            hint: Text("Select a city", style: TextStyle(color: Colors.white)),
            onChanged: (value) async {
              print(value);
              selectedCity = value.toString();
              print(selectedCity);
              final data = await weatherService.fetchWeather(selectedCity!);
              final iconData = weatherService.getWeatherIcon(data.cod);
              final message = weatherService.getMessage(data.main.temp.toInt());
              setState(() {
                locationName = data.name;
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
          final iconData = weatherService.getWeatherIcon(data.cod);
          final message = weatherService.getMessage(data.main.temp.toInt());

          setState(() {
            locationName = data.name;
            temperature = data.main.temp.toString();
            humidity = data.main.humidity.toString();
            speed = data.wind.speed.toString();
            myMessage = message;
            iconValue = iconData;
          });
        },
        child: Icon(Icons.location_city),
      ),
      drawer: Drawer(child: DrawerHeader(child: Text("This is drawer"))),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.all(12.0),
                  child: TextField(
                    style: TextStyle(color: Colors.white),
                    controller: searchController,
                    decoration: InputDecoration(
                      labelStyle: TextStyle(color: Colors.white),
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
                onPressed: () async {
                  final Weather data = await weatherService.fetchWeather(
                    searchController.text,
                  );
                  final iconData = weatherService.getWeatherIcon(data.cod);
                  final message = weatherService.getMessage(
                    data.main.temp.toInt(),
                  );
                  setState(() {
                    locationName = data.name;
                    temperature = data.main.temp.toString();
                    humidity = data.main.humidity.toString();
                    speed = data.wind.speed.toString();
                    myMessage = message;
                    iconValue = iconData;
                  });
                },
                child: Text("Search", style: TextStyle(color: Colors.white)),
              ),
              SizedBox(width: 10),
            ],
          ),
          Text(
            "About Weather",
            style: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 24,
              color: Colors.white,
            ),
          ),
          SizedBox(height: 20),
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Spacer(),
              Align(
                alignment: Alignment.center,
                child: Text(
                  locationName,
                  style: TextStyle(fontSize: 20, color: Colors.white),
                ),
              ),
              SizedBox(height: 10),
              Align(
                alignment: Alignment.center,
                child: Hero(
                  tag: "hero",
                  child: Text(
                    iconValue,
                    style: TextStyle(fontSize: 140, color: Colors.white),
                  ),
                ),
              ),
              SizedBox(height: 10),
              Align(
                alignment: Alignment.center,
                child: Text(
                  dateFormat.format(now),
                  style: TextStyle(fontSize: 16, color: Colors.white),
                ),
              ),
              SizedBox(height: 10),
              // SizedBox(height: 200),
              Align(
                alignment: Alignment.center,
                child: Text(
                  "$temperature°",
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 64,
                    color: Colors.white,
                  ),
                ),
              ),
              SizedBox(height: 60),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  CustomContainerWidget(
                    value: humidity,
                    iconSymbol: '☁',
                    title: 'Humidity',
                  ),
                  CustomContainerWidget(
                    value: temperature,
                    iconSymbol: '🌡️°',
                    title: 'Temperature',
                  ),
                  CustomContainerWidget(
                    value: speed,
                    iconSymbol: '💨',
                    title: 'Speed',
                  ),
                ],
              ),
              // SizedBox(height: 20),
              // Text(
              //   "Wind Speed is $speed",
              //   style: TextStyle(
              //     fontWeight: FontWeight.bold,
              //     fontSize: 18,
              //     color: Colors.white,
              //   ),
              // ),

              // Text(
              //   myMessage,
              //   style: TextStyle(fontSize: 40, color: Colors.white),
              // ),
              // SizedBox(height: 20),
            ],
          ),
        ],
      ),
    );
  }
}

class CustomContainerWidget extends StatelessWidget {
  const CustomContainerWidget({
    super.key,
    required this.value,
    required this.iconSymbol,
    required this.title,
  });

  final String value;
  final String iconSymbol;
  final String title;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: Color(0xff1B1E48),
        borderRadius: BorderRadius.circular(12),
      ),
      child: Column(
        children: [
          Text(iconSymbol, style: TextStyle(color: Colors.white, fontSize: 64)),
          SizedBox(height: 10),
          Text(
            value,
            style: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 18,
              color: Colors.white,
            ),
          ),
          SizedBox(height: 10),
          Text(
            title,
            style: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 18,
              color: Colors.grey,
            ),
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