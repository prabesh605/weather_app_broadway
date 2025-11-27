import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:flutter/material.dart';
import 'package:weather_app/pages/screen_two.dart';
import 'package:flutter_animate/flutter_animate.dart';

class ScreenOne extends StatefulWidget {
  const ScreenOne({super.key});

  @override
  State<ScreenOne> createState() => _ScreenOneState();
}

class _ScreenOneState extends State<ScreenOne>
    with SingleTickerProviderStateMixin {
  late AnimationController controller;

  late Animation animation;

  @override
  void initState() {
    controller = AnimationController(
      duration: Duration(seconds: 1),
      vsync: this,
    );
    // controller.reverse(from: 1.0);
    controller.forward();
    animation = ColorTween(
      begin: Colors.white,
      end: Colors.blue,
    ).animate(controller);
    // animation = CurvedAnimation(parent: controller, curve: Curves.easeOut);
    // animation.addStatusListener((status) {
    //   if (status == AnimationStatus.completed) {
    //     controller.reverse(from: 1.0);
    //   } else if (status == AnimationStatus.dismissed) {
    //     controller.forward();
    //   }
    // });

    controller.addListener(() {
      setState(() {});
      // print(controller.value);
      print(animation.value);
    });
    super.initState();
  }

  @override
  void dispose() {
    controller.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: animation.value,
      appBar: AppBar(title: Text("Screen One")),
      body: Center(
        child: Column(
          children: [
            // Hero(
            //   tag: 'weather',
            //   child:
            //    Image.asset('assets/weather.png', height: 50),
            // ),
            // Row(
            //   children: [
            //     // SizedBox(width: controller.value * 100),
            //     Image.asset('assets/weather.png', height: animation.value),
            //   ],
            // ),
            Image.asset(
              'assets/weather.png',
              height: 60,
              // controller.value * 100,
              // animation.value * 100,
            ),
            Text("Before").animate().swap(
              duration: 900.ms,
              builder: (_, __) => Text("After"),
            ),

            // Text(
            //   "${(controller.value * 100).toInt()}%",
            //   style: TextStyle(fontSize: 40),
            // ),
            // Text("${controller.value}"),
            AnimatedTextKit(
              animatedTexts: [
                TyperAnimatedText("Welcome to Weather App"),
                TyperAnimatedText("Welcome to MY ap p"),
                TyperAnimatedText("Welcome to Flutter App"),
                TyperAnimatedText("Welcome to Dart App"),
              ],
            ),
            Text(
              "Welcome to Weather App",
              style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 60),
            ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => ScreenTwo()),
                );
              },
              child: Text("Next"),
            ),
          ],
        ),
      ),
    );
  }
}
