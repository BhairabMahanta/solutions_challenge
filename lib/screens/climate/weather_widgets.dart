import 'package:flutter/material.dart';

Widget buildWeatherCard(IconData icon, String label, String value) {
  return Card(
    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
    elevation: 3,
    child: Padding(
      padding: const EdgeInsets.all(8.0),
      child: Row(
        children: [
          Icon(icon, size: 28, color: Colors.blue),
          const SizedBox(width: 8),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SelectableText(label,
                  style: const TextStyle(fontWeight: FontWeight.bold)),
              SelectableText(value),
            ],
          ),
        ],
      ),
    ),
  );
}

Widget buildWeatherDetails(Map<String, dynamic> data) {
  final currentCondition = data['current_condition']?[0] ?? {};
  final astronomy = data['weather']?[0]['astronomy']?[0] ?? {};
  List<String> alertsData = [];

  if (data['weather_alerts'] != null && data['weather_alerts'] is List) {
    alertsData = List<String>.from(data['weather_alerts'] as List);
  }

  final weatherItems = [
    {
      'icon': Icons.thermostat_outlined,
      'label': 'Temp (°C)',
      'value': '${currentCondition['temp_C'] ?? 'N/A'}'
    },
    {
      'icon': Icons.opacity,
      'label': 'Humidity',
      'value': '${currentCondition['humidity'] ?? 'N/A'}%'
    },
    {
      'icon': Icons.air,
      'label': 'Wind Speed',
      'value': '${currentCondition['windspeedKmph'] ?? 'N/A'} km/h'
    },
    {
      'icon': Icons.wb_sunny_outlined,
      'label': 'Sunrise',
      'value': '${astronomy['sunrise'] ?? 'N/A'}'
    },
    {
      'icon': Icons.nights_stay_outlined,
      'label': 'Sunset',
      'value': '${astronomy['sunset'] ?? 'N/A'}'
    },
    {
      'icon': Icons.visibility,
      'label': 'Visibility',
      'value': '${currentCondition['visibility'] ?? 'N/A'} km'
    },
    {
      'icon': Icons.cloud_queue,
      'label': 'Cloud Cover',
      'value': '${currentCondition['cloudcover'] ?? 'N/A'}%'
    },
    {
      'icon': Icons.brightness_2,
      'label': 'Moon Phase',
      'value': '${astronomy['moon_phase'] ?? 'N/A'}'
    },
  ];

  return Padding(
    padding: const EdgeInsets.all(16.0),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Expanded(
          child: GridView.builder(
            itemCount: weatherItems.length,
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 3,
              childAspectRatio: 4,
              crossAxisSpacing: 100,
              mainAxisSpacing: 45,
            ),
            itemBuilder: (context, index) {
              final item = weatherItems[index];
              return buildWeatherCard(
                item['icon'] as IconData,
                item['label'] as String,
                item['value'] as String,
              );
            },
          ),
        ),
        const SizedBox(height: 16),
        const SelectableText('Weather Alerts',
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
        if (alertsData.isEmpty)
          const SelectableText('No alerts available.')
        else
          ...alertsData.map((alert) => Padding(
                padding: const EdgeInsets.symmetric(vertical: 4),
                child: SelectableText(alert),
              )),
      ],
    ),
  );
}
