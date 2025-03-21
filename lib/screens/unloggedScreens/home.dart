import 'package:flutter/material.dart';
import 'package:new_solution/widgets/home1/login_popup.dart';
import 'package:new_solution/widgets/home1/signup_popup.dart';
import '../../widgets/home1/navbar.dart';
import '../../widgets/home1/hero_section.dart';
import '../../widgets/home1/top_bar.dart';
import '../../widgets/home1/cards.dart'; // Import all cards together
import '../../widgets/chatbot_overlay.dart'; // Import chatbot overlay
import 'contributors_screen.dart'; // Import contributors section

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  bool showChat = false; // Track chatbot visibility

  void toggleChat() {
    setState(() {
      showChat = !showChat;
      print("Chat toggled: $showChat"); // Debugging
    });
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Scaffold(
          backgroundColor: Colors.lightBlue[50],
          endDrawer: Drawer(
            child: ListView(
              padding: EdgeInsets.zero,
              children: [
                DrawerHeader(
                  decoration: BoxDecoration(color: Colors.green[400]),
                  child: Text(
                    "Menu",
                    style: TextStyle(color: Colors.white, fontSize: 24),
                  ),
                ),
                _drawerItem("Solutions"),
                _drawerItem("Impact"),
                _drawerItem("About Us"),
                _drawerItem("Roadmap"),
                ListTile(
                  leading: Icon(Icons.chat),
                  title: Text("Sherpa AI"),
                  onTap: () {
                    ChatbotPopup.show(context);
                  },
                ),
                _drawerItem("Sign In", action: () => LoginPopup.show(context)),
                _drawerItem("Get Started",
                    action: () => SignupPopup.show(context)),
              ],
            ),
          ),
          body: SafeArea(
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  SizedBox(height: 60), // Adjust space for the fixed navbar
                  HeroSection(),
                  TopBar(),
                  const SizedBox(height: 30),

                  // Cards Section
                  LayoutBuilder(
                    builder: (context, constraints) {
                      double screenWidth = constraints.maxWidth;
                      double cardWidth = screenWidth > 1200
                          ? screenWidth * 0.27
                          : (screenWidth > 800
                              ? screenWidth * 0.3
                              : screenWidth * 0.85);
                      double cardHeight = screenWidth > 1200
                          ? 280
                          : (screenWidth > 800 ? 240 : 220);
                      double spacing = screenWidth * 0.04;

                      if (screenWidth > 800) {
                        return Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            SizedBox(
                                width: cardWidth,
                                height: cardHeight,
                                child: FootprintCard()),
                            SizedBox(width: spacing),
                            SizedBox(
                                width: cardWidth,
                                height: cardHeight,
                                child: CommunityCard()),
                            SizedBox(width: spacing),
                            SizedBox(
                                width: cardWidth,
                                height: cardHeight,
                                child: ClimateScoreCard()),
                          ],
                        );
                      } else {
                        return Column(
                          children: [
                            SizedBox(
                                width: cardWidth,
                                height: cardHeight,
                                child: FootprintCard()),
                            SizedBox(height: spacing),
                            SizedBox(
                                width: cardWidth,
                                height: cardHeight,
                                child: CommunityCard()),
                            SizedBox(height: spacing),
                            SizedBox(
                                width: cardWidth,
                                height: cardHeight,
                                child: ClimateScoreCard()),
                          ],
                        );
                      }
                    },
                  ),

                  const SizedBox(height: 40), // Space before contributors

                  // Contributors Section - Placed Separately Below
                  Container(
                    width: double.infinity,
                    padding: const EdgeInsets.symmetric(vertical: 50),
                    color: Colors
                        .lightBlue[50], // Background to separate the section
                    child: ContributorsScreen(),
                  ),
                ],
              ),
            ),
          ),
        ),

        // Sticky Navbar
        Positioned(
          top: 0,
          left: 0,
          right: 0,
          child: Container(
            color: Colors.lightBlue[50], // Ensure it's not transparent
            child: NavBar(toggleChat: toggleChat),
          ),
        ),

        // Chatbot Overlay
        if (showChat)
          Positioned(
            left: 0,
            right: 0,
            bottom: 0,
            child: FloatingActionButton(
              onPressed: () {
                ChatbotPopup.show(context);
              },
              child: Icon(Icons.chat),
            ),
          ),
      ],
    );
  }

  // Drawer Item Function
  Widget _drawerItem(String title, {VoidCallback? action}) {
    return ListTile(
      title: Text(title),
      onTap: action ?? () {},
    );
  }
}
