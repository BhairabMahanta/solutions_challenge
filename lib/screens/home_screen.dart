import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/weather_provider.dart';
import '../widgets/chatbot_overlay.dart';
import '../widgets/weather_info_section.dart';
import '../features/feature_grid.dart';
import '../widgets/auth_buttons.dart';
import '../widgets/coming_soon_section.dart';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  bool showChat = false;

  @override
  void initState() {
    super.initState();
    Future.microtask(() {
      Provider.of<WeatherProvider>(context, listen: false).fetchWeather();
      print("Fetching weather data...");
    });
  }

  void toggleChat() {
    setState(() {
      showChat = !showChat;
      print("Chat toggled: $showChat");
    });
  }

  void navigateTo(BuildContext context, Widget screen) {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => screen),
    );
  }

  @override
  Widget build(BuildContext context) {
    final weather = Provider.of<WeatherProvider>(context).weather;

    return Stack(
      children: [
        Scaffold(
          appBar: PreferredSize(
            preferredSize: const Size.fromHeight(62), // Slightly thicker navbar
            child: AppBar(
              backgroundColor: const Color.fromARGB(255, 158, 223, 166),
              title: Row(
                children: [
                  Icon(Icons.menu,
                      size: 28, color: Colors.black87), // Menu icon
                  const SizedBox(width: 12), // Spacing
                  const Text(
                    'GreenStride',
                    style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
                  ),
                ],
              ),
              actions: [
                TextButton.icon(
                  onPressed: toggleChat,
                  icon: Icon(Icons.chat, size: 20, color: Colors.white),
                  label: const Text(
                    "Chat",
                    style: TextStyle(color: Colors.white),
                  ),
                ),
                AuthButtons(),
              ],
            ),
          ),
          body: Container(
            color:
                const Color(0xFFE5F5EC), // Replaced gradient with solid color
            padding: const EdgeInsets.all(25.0),
            child: LayoutBuilder(
              builder: (context, constraints) {
                return SingleChildScrollView(
                  child: ConstrainedBox(
                    constraints: BoxConstraints(
                      minHeight: constraints.maxHeight,
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        // Gradient Title
                        Center(
                          child: ShaderMask(
                            shaderCallback: (Rect bounds) {
                              return const LinearGradient(
                                colors: [Colors.green, Colors.blue],
                                begin: Alignment.centerLeft,
                                end: Alignment.centerRight,
                              ).createShader(bounds);
                            },
                            child: const Text(
                              "EcoNavigation",
                              style: TextStyle(
                                fontSize: 32, // Bigger title
                                fontWeight: FontWeight.bold,
                                color: Colors.white, // Overridden by gradient
                              ),
                            ),
                          ),
                        ),
                        const SizedBox(height: 8), // Spacing
                        // Subtitle
                        Center(
                          child: Text(
                            "Your guide to sustainable living and climate action",
                            style: TextStyle(
                              fontSize: 16,
                              color: Colors.grey.shade700,
                            ),
                          ),
                        ),
                        const SizedBox(
                            height: 20), // Spacing before other sections
                        WeatherInfoSection(weather: weather),
                        const SizedBox(height: 20),
                        FeatureGrid(navigateTo: navigateTo),
                        const SizedBox(height: 20),
                        ComingSoonSection(),
                      ],
                    ),
                  ),
                );
              },
            ),
          ),
        ),
        if (showChat)
          Positioned(
            left: 0,
            right: 0,
            bottom: 0,
            child: ChatbotOverlay(onClose: toggleChat),
          ),
      ],
    );
  }
}
