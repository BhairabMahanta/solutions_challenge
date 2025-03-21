import 'package:flutter/material.dart';

import 'package:provider/provider.dart';
import 'providers/weather_provider.dart';
import 'screens/home_screen.dart';
import 'screens/unusedScreens/mitigation_screen.dart';
import 'screens/adaptation_screen.dart';
import 'widgets/chatbot_overlay.dart';
import 'firebase_options.dart'; // Ensure this file exists for Firebase configuration

final GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

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
          '/': (context) => HomeScreen(),
          '/mitigation': (context) => MitigationScreen(),
          '/adaptation': (context) => AdaptationScreen(),
        },
      ),
    );
  }
}
