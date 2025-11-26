
















// import 'package:flutter/material.dart';
// import 'package:weather_app/weather_screen.dart';

// class WelcomeScreen extends StatefulWidget {
//   const WelcomeScreen({super.key});

//   @override
//   State<WelcomeScreen> createState() => _WelcomeScreenState();
// }

// class _WelcomeScreenState extends State<WelcomeScreen>
//     with SingleTickerProviderStateMixin {
//   late AnimationController controller;
//   double value = 0.0;
//   @override
//   void initState() {
//     controller = AnimationController(
//       duration: Duration(seconds: 1),
//       vsync: this,
//     );
//     controller.forward();
//     controller.addListener(() {
//       setState(() {});
//       print(controller.value);
//       value = (controller.value * 100);
//     });
//     super.initState();
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       backgroundColor: Color(0xFF111438).withOpacity(controller!.value),
//       appBar: AppBar(title: const Text('Welcome Screen')),
//       body: Center(
//         child: Column(
//           mainAxisAlignment: MainAxisAlignment.center,
//           children: [
//             // Image.asset('assets/cloudy.png', width: 200, height: 200),
//             Hero(
//               tag: "hero",
//               child: Text("🤷", style: TextStyle(fontSize: 50)),
            
//             ),
//             Icon(
//               Icons.wb_cloudy,
//               size: controller.value * 100,
//               color: Colors.white,
//             ),
//             ElevatedButton(
//               onPressed: () {
//                 Navigator.push(
//                   context,
//                   MaterialPageRoute(builder: (context) => WeatherScreen()),
//                 );
//               },
//               child: const Text('Go to Weather Screen'),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }
