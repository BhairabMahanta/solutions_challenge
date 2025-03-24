import 'package:flutter/material.dart';
import 'package:new_solution/screens/present_screen.dart';
import 'package:new_solution/utils/energy_questionaire.dart';
import 'package:new_solution/utils/travel.questionaire.dart';

class GHGSourcesScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('GHG Emission Sources')),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 10),
            child: ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.green,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8),
                ),
                padding: EdgeInsets.symmetric(vertical: 10, horizontal: 20),
              ),
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => PresetScreen()),
                );
              },
              child: Text("View Presets", style: TextStyle(fontSize: 14)),
            ),
          ),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              child: GridView.builder(
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 3, // ✅ Smaller boxes, more items per row
                  crossAxisSpacing: 12,
                  mainAxisSpacing: 12,
                  childAspectRatio: 1.2, // ✅ Adjusted to look balanced
                ),
                itemCount: ghgSources.length,
                itemBuilder: (context, index) {
                  return _buildGridBox(
                    context,
                    ghgSources[index]["title"],
                    ghgSources[index]["color"],
                    ghgSources[index]["isActive"],
                    ghgSources[index]["icon"],
                  );
                },
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildGridBox(BuildContext context, String title, Color color,
      bool isActive, IconData icon) {
    return GestureDetector(
      onTap: isActive ? () => _handleSelection(context, title) : null,
      child: Container(
        decoration: BoxDecoration(
          color: isActive ? color : Colors.grey[300],
          borderRadius: BorderRadius.circular(12),
          boxShadow: [
            BoxShadow(
              color: Colors.black12,
              blurRadius: 4,
              offset: Offset(2, 3),
            ),
          ],
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(icon,
                size: 40,
                color:
                    isActive ? Colors.white : Colors.black45), // ✅ Added icon
            SizedBox(height: 8),
            Text(
              title,
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 13,
                fontWeight: FontWeight.w600,
                color: isActive ? Colors.white : Colors.black54,
              ),
            ),
          ],
        ),
      ),
    );
  }

  void _handleSelection(BuildContext context, String title) {
    if (title == "Travel") {
      _showPopup(context, TravelQuestionnaire());
    } else if (title == "Household Energy") {
      _showPopup(context, EnergyQuestionnaire());
    }
  }

  void _showPopup(BuildContext context, Widget questionnaire) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return questionnaire;
      },
    );
  }
}

// ✅ Now with icons & better spacing
final List<Map<String, dynamic>> ghgSources = [
  {
    "title": "Travel",
    "color": Colors.blue,
    "isActive": true,
    "icon": Icons.directions_car
  },
  {
    "title": "Work Commute",
    "color": Colors.green,
    "isActive": false,
    "icon": Icons.business
  },
  {
    "title": "Household Energy",
    "color": Colors.orange,
    "isActive": true,
    "icon": Icons.home
  },
  {
    "title": "Shopping Habits",
    "color": Colors.purple,
    "isActive": false,
    "icon": Icons.shopping_cart
  },
  {
    "title": "Diet & Food",
    "color": Colors.red,
    "isActive": false,
    "icon": Icons.fastfood
  },
  {
    "title": "Flights & Long Travel",
    "color": Colors.teal,
    "isActive": false,
    "icon": Icons.flight
  },
];
