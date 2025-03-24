import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:new_solution/utils/calculator.dart';
import 'package:new_solution/widgets/home1/components/daily_task.dart';
import 'package:shared_preferences/shared_preferences.dart';

class PresetScreen extends StatefulWidget {
  @override
  _PresetScreenState createState() => _PresetScreenState();
}

class _PresetScreenState extends State<PresetScreen> {
  List<Map<String, dynamic>> travelData = [];
  List<Map<String, dynamic>> energyData = [];

  @override
  void initState() {
    super.initState();
    _loadPresets();
  }

  Future<void> _loadPresets() async {
    try {
      final prefs = await SharedPreferences.getInstance();

      // Load Travel Data
      String? travelJson = prefs.getString("travel_data");
      if (travelJson != null) {
        var decoded = jsonDecode(travelJson);
        if (decoded is Map && decoded.containsKey("user")) {
          setState(() {
            travelData =
                List<Map<String, dynamic>>.from(decoded["user"]["travel"])
                    .map((item) {
              return {
                "mode": item["mode"],
                "distance_km":
                    double.tryParse(item["distance_km"].toString()) ?? 0.0,
              };
            }).toList();
          });
        }
      }

      // Load Energy Data
      String? energyJson = prefs.getString("energy_data");
      if (energyJson != null) {
        var decoded = jsonDecode(energyJson);
        if (decoded is Map && decoded.containsKey("user")) {
          setState(() {
            energyData =
                List<Map<String, dynamic>>.from(decoded["user"]["energy"])
                    .map((item) {
              return {
                "device": item["device"],
                "hours": int.tryParse(item["hours"].toString()) ?? 0,
                "co2_emission":
                    int.tryParse(item["co2_emission"].toString()) ?? 0,
              };
            }).toList();
          });
        }
      }

      print("✅ Travel Data: $travelData");
      print("✅ Energy Data: $energyData");
    } catch (e) {
      print("❌ Error loading presets: $e");
    }
  }

  @override
  Widget build(BuildContext context) {
    bool hasPresets = travelData.isNotEmpty || energyData.isNotEmpty;

    return Scaffold(
      appBar: AppBar(
        title:
            Text("Your Presets", style: TextStyle(fontWeight: FontWeight.bold)),
        actions: [
          Padding(
            padding: EdgeInsets.only(right: 16.0),
            child: TextButton(
              style: TextButton.styleFrom(
                foregroundColor: Colors.black, // Text color
                textStyle: TextStyle(
                  fontWeight: FontWeight.w600,
                  fontSize: 16,
                ),
              ),
              onPressed: () {
                showDialog(
                  context: context,
                  builder: (context) => DailyTasksPopup(),
                );
              },
              child: Text("Daily Tasks"),
            ),
          ),
        ],
      ),
      body: hasPresets
          ? Padding(
              padding: EdgeInsets.all(16),
              child: ListView(
                children: [
                  if (travelData.isNotEmpty)
                    _buildPresetSection("Travel Data", travelData, true),
                  if (energyData.isNotEmpty)
                    _buildPresetSection("Energy Usage", energyData, false),
                ],
              ),
            )
          : Center(
              child: Text(
                "No saved presets yet!",
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.w500),
              ),
            ),
    );
  }

  Widget _buildPresetSection(
      String title, List<Map<String, dynamic>> data, bool isTravel) {
    return Card(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
      elevation: 4,
      margin: EdgeInsets.symmetric(vertical: 10),
      child: Padding(
        padding: EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Icon(
                  isTravel ? Icons.directions_car : Icons.electric_bolt,
                  color: isTravel ? Colors.blue : Colors.green,
                  size: 28,
                ),
                SizedBox(width: 10),
                Text(title,
                    style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        color: Colors.black87)),
              ],
            ),
            Divider(),
            ...data.map((item) {
              String subtitleText = "Usage: ";
              double co2Emission = 0.0;

              if (isTravel) {
                double distance = (item["distance_km"] ?? 0.0).toDouble();
                double co2PerKm =
                    EmissionCalculator.travelEmissionRates[item["mode"]] ?? 0.0;
                co2Emission = distance * co2PerKm;
                subtitleText += "$distance km";
              } else {
                int hours = item["hours"] ?? 0;
                List<int>? co2Range =
                    EmissionCalculator.energyEmissionRates[item["device"]];
                if (co2Range != null) {
                  double co2PerHour =
                      ((co2Range[0] + co2Range[1]) / 2).toDouble();
                  co2Emission = hours * co2PerHour;
                }
                subtitleText += "$hours hours";
              }

              return ListTile(
                leading: CircleAvatar(
                  backgroundColor:
                      isTravel ? Colors.blue[100] : Colors.green[100],
                  child: Icon(
                    isTravel ? Icons.directions_bus : Icons.bolt,
                    color: isTravel ? Colors.blue[700] : Colors.green[700],
                  ),
                ),
                title: Text(
                  item["device"] ?? item["mode"] ?? "Unknown",
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
                ),
                subtitle: Text(
                  subtitleText,
                  style: TextStyle(fontSize: 14, color: Colors.grey[700]),
                ),
                trailing: Chip(
                  backgroundColor: Colors.orange[100],
                  label: Text(
                    "${co2Emission.toStringAsFixed(2)} g CO₂",
                    style: TextStyle(fontWeight: FontWeight.w500),
                  ),
                ),
              );
            }),
          ],
        ),
      ),
    );
  }
}
