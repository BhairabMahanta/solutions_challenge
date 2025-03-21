import 'package:flutter/material.dart';
import 'package:new_solution/screens/unloggedScreens/home.dart';
import 'package:provider/provider.dart';
import 'providers/weather_provider.dart';
import 'screens/unusedScreens/mitigation_screen.dart';
import 'widgets/chatbot_overlay.dart';
import 'services/firebase_service.dart';
import 'package:firebase_core/firebase_core.dart' as firebase_core;
import 'package:firebase_dart/firebase_dart.dart' as firebase_dart;

final GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  // Initialize Firebase for Firebase Core
  await FirebaseService.initializeFirebase();

  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (context) => WeatherProvider()),
      ],
      child: MaterialApp(
        navigatorKey: navigatorKey,
        title: 'Climate App',
        theme: ThemeData(primarySwatch: Colors.blue),
        initialRoute: '/',
        routes: {
          '/': (context) => HomePage(),
          '/mitigation': (context) => MitigationScreen(),
        },
      ),
    );
  }
}
