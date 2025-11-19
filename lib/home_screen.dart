import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

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

      final response = await http.get(Uri.parse(baseUrl + apiKey));

      response.statusCode;
      print("Status code: ${response.statusCode}");
      final data = jsonDecode(response.body);
      setState(() {
        temperature = "${data['main']['temp']}";
        humidity = "${data['main']['humidity']}";
        speed = "${data['wind']['speed']}";
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
