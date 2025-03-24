import 'dart:convert';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:path_provider/path_provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

class TravelQuestionnaire extends StatefulWidget {
  @override
  _TravelQuestionnaireState createState() => _TravelQuestionnaireState();
}

class _TravelQuestionnaireState extends State<TravelQuestionnaire> {
  List<Map<String, dynamic>> travelData = [];
  List<String> predefinedLocations = [
    "University",
    "Marketplace",
    "Workplace",
    "Park",
    "Other"
  ];
  List<String> transportModes = [
    "Walking",
    "Bicycle",
    "Bus",
    "Car (Petrol)",
    "Car (Electric)",
    "Train",
    "Motorbike"
  ];

  @override
  void initState() {
    super.initState();
    loadData();
  }

  Future<void> loadData() async {
    try {
      final directory = await getApplicationDocumentsDirectory();
      final file = File('${directory.path}/user.json');

      if (await file.exists()) {
        String content = await file.readAsString();
        Map<String, dynamic> jsonData = jsonDecode(content);
        setState(() {
          travelData =
              List<Map<String, dynamic>>.from(jsonData["user"]["travel"] ?? []);
        });
      }
    } catch (e) {
      print("❌ Error loading travel data: $e");
    }
  }

  Future<void> saveTravelData(List<Map<String, dynamic>> travelData) async {
    final prefs = await SharedPreferences.getInstance();
    // Ensure correct structure
    final travelJson = jsonEncode({
      "user": {"travel": travelData}
    });

    await prefs.setString("travel_data", travelJson);

    print("✅ Travel data saved in SharedPreferences!");
  }

  Future<Map<String, dynamic>?> loadTravelData() async {
    final prefs = await SharedPreferences.getInstance();
    String? jsonData = prefs.getString("travel_data");
    return jsonData != null ? jsonDecode(jsonData) : null;
  }

  void addLocation() {
    setState(() {
      travelData.add({"location": "", "distance_km": "", "mode": ""});
    });
  }

  @override
  Widget build(BuildContext context) {
    return Dialog(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
      child: Container(
        padding: EdgeInsets.all(16),
        height: 500,
        child: Column(
          children: [
            Text("Travel Questionnaire",
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
            SizedBox(height: 10),
            Expanded(
              child: ListView.builder(
                itemCount: travelData.length,
                itemBuilder: (context, index) {
                  return Column(
                    children: [
                      DropdownButtonFormField(
                        value: travelData[index]["location"].isNotEmpty
                            ? travelData[index]["location"]
                            : null,
                        decoration: InputDecoration(labelText: "Location"),
                        items: predefinedLocations.map((location) {
                          return DropdownMenuItem(
                              value: location, child: Text(location));
                        }).toList(),
                        onChanged: (value) {
                          setState(() {
                            travelData[index]["location"] = value;
                          });
                        },
                      ),
                      TextField(
                        decoration: InputDecoration(labelText: "Distance (km)"),
                        keyboardType: TextInputType.number,
                        onChanged: (value) {
                          setState(() {
                            travelData[index]["distance_km"] = value;
                          });
                        },
                      ),
                      DropdownButtonFormField(
                        value: travelData[index]["mode"].isNotEmpty
                            ? travelData[index]["mode"]
                            : null,
                        decoration:
                            InputDecoration(labelText: "Mode of Travel"),
                        items: transportModes.map((mode) {
                          return DropdownMenuItem(
                              value: mode, child: Text(mode));
                        }).toList(),
                        onChanged: (value) {
                          setState(() {
                            travelData[index]["mode"] = value;
                          });
                        },
                      ),
                      Divider(),
                    ],
                  );
                },
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                TextButton(
                    onPressed: addLocation, child: Text("+ Add Location")),
                ElevatedButton(
                  onPressed: () async {
                    await saveTravelData(travelData); // ✅ Pass list directly
                    Navigator.of(context).pop();
                  },
                  child: Text("Save"),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
