// import 'package:flutter/material.dart';
// import 'package:provider/provider.dart';
// import '../providers/weather_provider.dart';
// import '../widgets/chatbot_overlay.dart';
// import '../widgets/weather_info_section.dart';
// import '../features/feature_grid.dart';
// import '../widgets/auth_buttons.dart';
// import '../widgets/coming_soon_section.dart';

// class HomeScreen extends StatefulWidget {
//   @override
//   _HomeScreenState createState() => _HomeScreenState();
// }

// class _HomeScreenState extends State<HomeScreen> {
//   bool showChat = false;

//   @override
//   void initState() {
//     super.initState();
//     Future.microtask(() {
//       Provider.of<WeatherProvider>(context, listen: false).fetchWeather();
//       print("Fetching weather data...");
//     });
//   }

//   void toggleChat() {
//     setState(() {
//       showChat = !showChat;
//       print("Chat toggled: $showChat");
//     });
//   }

//   void navigateTo(BuildContext context, Widget screen) {
//     Navigator.push(
//       context,
//       MaterialPageRoute(builder: (context) => screen),
//     );
//   }

//   @override
//   Widget build(BuildContext context) {
//     final weather = Provider.of<WeatherProvider>(context).weather;

//     return Stack(
//       children: [
//         Scaffold(
//           appBar: AppBar(
//             backgroundColor: const Color.fromARGB(255, 158, 223, 166),
//             title: const Text(
//               'EcoNavigator',
//               style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
//             ),
//             actions: [AuthButtons()],
//           ),
//           body: Container(
//             decoration: BoxDecoration(
//               gradient: LinearGradient(
//                 colors: [Colors.blue.shade100, Colors.green.shade200],
//                 begin: Alignment.topLeft,
//                 end: Alignment.bottomRight,
//               ),
//             ),
//             padding: const EdgeInsets.all(25.0),
//             child: LayoutBuilder(
//               builder: (context, constraints) {
//                 return SingleChildScrollView(
//                   child: ConstrainedBox(
//                     constraints: BoxConstraints(
//                       minHeight: constraints.maxHeight,
//                     ),
//                     child: Column(
//                       crossAxisAlignment: CrossAxisAlignment.start,
//                       mainAxisSize:
//                           MainAxisSize.min, // Prevents extra white space
//                       children: [
//                         Center(
//                           child: Text(
//                             "Your guide to sustainable living and climate action",
//                             style: TextStyle(
//                                 fontSize: 16, color: Colors.grey.shade700),
//                           ),
//                         ),
//                         const SizedBox(height: 20),
//                         WeatherInfoSection(weather: weather),
//                         const SizedBox(height: 20),
//                         FeatureGrid(navigateTo: navigateTo),
//                         const SizedBox(height: 20),
//                         ComingSoonSection(),
//                       ],
//                     ),
//                   ),
//                 );
//               },
//             ),
//           ),
//           floatingActionButton: FloatingActionButton(
//             onPressed: toggleChat,
//             child: Icon(Icons.chat),
//           ),
//         ),
//         if (showChat)
//           Positioned(
//             left: 0,
//             right: 0,
//             bottom: 0,
//             child: ChatbotOverlay(onClose: toggleChat),
//           ),
//       ],
//     );
//   }
// }
