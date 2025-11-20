import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:weather_app/weather_model.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final apiKey = "0b10461d5a30e6612ce19d84c97ef651#";
  String cityName = "Kathmandu";
  String temperature = "";

  String humidity = "";
  String speed = '';
  final searchController = TextEditingController();

  Future<void> fetchWeather(String cityName) async {
    try {
      final baseUrl =
          "https://api.openweathermap.org/data/2.5/weather?q=$cityName&units=metric&appid=";

      ///step 1 base url

      final response = await http.get(
        Uri.parse(baseUrl + apiKey),
      ); //step 2 make a get request

      response.statusCode;
      print("Status code: ${response.statusCode}");
      final data = jsonDecode(response.body); //step 3 decode the response
      final weatherData = Weather.fromJson(data);

      setState(() {
        //step 4 map in variables
        temperature = weatherData.main.temp.toString();
        humidity = weatherData.main.humidity.toString();
        speed = weatherData.wind.speed.toString();
        // temperature = "${data['main']['temp']}";
        // humidity = "${data['main']['humidity']}";
        // speed = "${data['wind']['speed']}";
      });

      // print("Temperature: $temperature");
    } catch (e) {
      setState(() {
        temperature = "Not found";
      });

      print(e.toString());
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Weather App")),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: TextField(
              controller: searchController,
              decoration: InputDecoration(
                prefixIcon: Icon(Icons.search),
                labelText: "Enter City Name",
                border: OutlineInputBorder(),
              ),
            ),
          ),
          ElevatedButton(
            onPressed: () {
              fetchWeather(searchController.text);
            },
            child: Text("Get Weather"),
          ),

          Text("Your Temperature is $temperature"),
          Text("Your humidity is $humidity"),
          Text("Wind Speed is $speed"),
        ],
      ),
    );
  }
}
