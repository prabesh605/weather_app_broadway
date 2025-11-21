import 'dart:convert';
import 'dart:math';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:weather_app/mobile_model.dart';

class MobilePage extends StatefulWidget {
  const MobilePage({super.key});

  @override
  State<MobilePage> createState() => _MobilePageState();
}

// https://jsonplaceholder.typicode.com/posts
class _MobilePageState extends State<MobilePage> {
  String url =
      "https://api.restful-api.dev/objects/ff8081819782e69e019aa41901e743ae";
  String name1 = "";
  List<Mobile> mobileList = [];
  var data = {"name": "This is python class"};
  Future<void> fetchData() async {
    try {
      final response = await http.delete(
        Uri.parse(url),
        // body: jsonEncode(data),
        headers: {
          "Content-Type": "application/json",
          "Accept": "*/*",
          "Authorization":
              "Bearer 17MMlieBYLeytGTagw9hTghvkAK7PwHm9EDF8CUHDv4iBolp1wqwsdAzGDasc9bi",
        },
      );
      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        print(data);
        // Mobile mobileData = Mobile.fromJson(data[0]);

        setState(() {
          mobileList = mobileFromJson(response.body);
          // String name = data['name'][0];
          // name1 = mobileData.name;
        });
        //  name1 = mobileData.name;
        // response.statusCode;
        print("Name: $name1");
      } else {
        print("Failed to load data");
        print("Status code: ${response.statusCode}");
      }
    } catch (e) {
      print(e.toString());
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Mobile Page')),
      body: Center(
        child: Column(
          children: [
            Text("Your Mobile Name: $name1"),
            ElevatedButton(
              onPressed: () {
                fetchData();
              },
              child: Text("Fetch Data"),
            ),
            Expanded(
              // height: 800,
              child: ListView.builder(
                itemCount: mobileList.length,
                itemBuilder: (context, index) {
                  final item = mobileList[index];
                  return ListTile(title: Text(item.name));
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
