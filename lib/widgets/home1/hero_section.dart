import 'package:flutter/material.dart';
import 'package:new_solution/screens/unloggedScreens/dashboard_screen.dart';

class HeroSection extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 30.0),
      child: Column(
        children: [
          Text(
            "🌱 Climate Action Made Effortless",
            style: TextStyle(color: Colors.green, fontSize: 14),
          ),
          SizedBox(height: 10),
          RichText(
            textAlign: TextAlign.center,
            text: TextSpan(
              style: TextStyle(
                  fontSize: 32,
                  fontWeight: FontWeight.bold,
                  color: Colors.black),
              children: [
                TextSpan(text: "Your Daily "),
                TextSpan(
                    text: "Climate Wins",
                    style: TextStyle(color: Colors.green)),
                TextSpan(text: " Add Up!"),
              ],
            ),
          ),
          SizedBox(height: 10),
          Text(
            "Earn XP for eco-actions, compete in community challenges, and see real impact. "
            "From hydrating during heatwaves to supporting green businesses - make sustainability addictive!",
            textAlign: TextAlign.center,
            style: TextStyle(fontSize: 16, color: Colors.grey[700]),
          ),
          SizedBox(height: 20),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              ElevatedButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => DashboardScreen()),
                  );
                },
                style: ElevatedButton.styleFrom(backgroundColor: Colors.green),
                child: Text("Play Your Part"),
              ),
              SizedBox(width: 12),
              OutlinedButton(
                onPressed: () {},
                child: Text("See How It Works"),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
