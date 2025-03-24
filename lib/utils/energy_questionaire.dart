import 'dart:convert';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:path_provider/path_provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

class EnergyQuestionnaire extends StatefulWidget {
  @override
  _EnergyQuestionnaireState createState() => _EnergyQuestionnaireState();
}

class _EnergyQuestionnaireState extends State<EnergyQuestionnaire> {
  List<Map<String, dynamic>> energyData = [];
  Map<String, int> co2PerHour = {
    "Refrigerator": 200,
    "Electric Stove": 500,
    "Television": 80,
    "Laptop/Desktop Computer": 100,
    "Air Conditioner": 800,
  };

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
          energyData =
              List<Map<String, dynamic>>.from(jsonData["user"]["energy"] ?? []);
        });
      }
    } catch (e) {
      print("❌ Error loading energy data: $e");
    }
  }

  Future<void> saveEnergyData(List<Map<String, dynamic>> energyData) async {
    final prefs = await SharedPreferences.getInstance();
    final energyJson = jsonEncode({
      "user": {"energy": energyData}
    });
    await prefs.setString("energy_data", energyJson);
    print("✅ Energy data saved in SharedPreferences!");
  }

  void addDevice() {
    setState(() {
      energyData.add({"device": "", "hours": "", "co2_emission": ""});
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
            Text("Energy Questionnaire",
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
            SizedBox(height: 10),
            Expanded(
              child: ListView.builder(
                itemCount: energyData.length,
                itemBuilder: (context, index) {
                  return Column(
                    children: [
                      DropdownButtonFormField(
                        value: energyData[index]["device"].isNotEmpty
                            ? energyData[index]["device"]
                            : null,
                        decoration: InputDecoration(labelText: "Device"),
                        items: co2PerHour.keys.map((device) {
                          return DropdownMenuItem(
                              value: device, child: Text(device));
                        }).toList(),
                        onChanged: (value) {
                          setState(() {
                            energyData[index]["device"] = value;
                          });
                        },
                      ),
                      TextField(
                        decoration: InputDecoration(labelText: "Usage Hours"),
                        keyboardType: TextInputType.number,
                        onChanged: (value) {
                          setState(() {
                            int hours = int.tryParse(value) ?? 0;
                            energyData[index]["hours"] = hours.toString();
                            energyData[index]["co2_emission"] = (hours *
                                    co2PerHour[energyData[index]["device"]]!)
                                .toString();
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
                TextButton(onPressed: addDevice, child: Text("+ Add Device")),
                ElevatedButton(
                  onPressed: () async {
                    await saveEnergyData(energyData); // ✅ Pass list directly
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
