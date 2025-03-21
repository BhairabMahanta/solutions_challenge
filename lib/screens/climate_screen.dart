import 'package:flutter/material.dart';
import 'climate/climate_service.dart';
import 'climate/weather_widgets.dart';

class ClimateStatsScreen extends StatefulWidget {
  @override
  _ClimateStatsScreenState createState() => _ClimateStatsScreenState();
}

class _ClimateStatsScreenState extends State<ClimateStatsScreen> {
  final ClimateService _climateService = ClimateService();
  Map<String, dynamic>? climateData;
  String location = 'Guwahati';
  TextEditingController locationController = TextEditingController();
  List<String> locationSuggestions = [];

  @override
  void initState() {
    super.initState();
    fetchClimateStats();
  }

  void fetchClimateStats() async {
    final data = await _climateService.fetchClimateStats(location);
    setState(() => climateData = data);
  }

  void fetchLocationSuggestions(String query) async {
    final suggestions = await _climateService.fetchLocationSuggestions(query);
    setState(() => locationSuggestions = suggestions);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          title: const SelectableText('Climate Stats'),
          backgroundColor: Colors.green.shade700),
      body: Container(
        width: double.infinity,
        height: double.infinity,
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [Colors.green.shade100, Colors.blue.shade200],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
        ),
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                children: [
                  TextField(
                    controller: locationController,
                    decoration: const InputDecoration(
                        labelText: 'Enter Location',
                        border: OutlineInputBorder()),
                    onChanged: fetchLocationSuggestions,
                  ),
                  const SizedBox(height: 8),
                  if (locationSuggestions.isNotEmpty)
                    Container(
                      decoration: BoxDecoration(
                          border: Border.all(color: Colors.grey),
                          borderRadius: BorderRadius.circular(4)),
                      child: ListView.builder(
                        shrinkWrap: true,
                        itemCount: locationSuggestions.length,
                        itemBuilder: (context, index) {
                          final suggestion = locationSuggestions[index];
                          return ListTile(
                            title: SelectableText(suggestion),
                            onTap: () {
                              setState(() {
                                locationController.text = suggestion;
                                location = suggestion;
                                locationSuggestions.clear();
                                fetchClimateStats();
                              });
                            },
                          );
                        },
                      ),
                    ),
                  ElevatedButton(
                      onPressed: fetchClimateStats,
                      child: const SelectableText('Search')),
                ],
              ),
            ),
            Expanded(
                child: climateData == null
                    ? const Center(child: CircularProgressIndicator())
                    : buildWeatherDetails(climateData!)),
          ],
        ),
      ),
    );
  }
}
