import 'package:flutter/material.dart';

class ContributorsScreen extends StatelessWidget {
  final List<Map<String, String>> contributors = [
    {
      "name": "Dhrisit Mazumder",
      "role": "Lead UI/UX and Designer",
      "image": "images/dhrisit.jpg",
      "description":
          "Designed the interface for app (to be launched in future)."
    },
    {
      "name": "Pritom Sharma",
      "role": "Graphics and Ideation", // No role displayed
      "image": "images/pritom.jpg",
      "description":
          "Developed core app functionalities and backend integrations."
    },
    {
      "name": "Bhairab Kumar Mahanta",
      "role": "Lead Developer",
      "image": "images/bhairab.jpg",
      "description":
          "Developed core app functionalities and backend integrations."
    },
    {
      "name": "Sanskriti Barman",
      "role": "Research and strategy Lead",
      "image": "images/sanskriti.jpg",
      "description":
          "Conducted sustainability research for climate impact data."
    },
    {
      "name": "Jyotishman Kumar",
      "role": "Lead UI/UX Designer", // No role displayed
      "image": "images/jk.jpg",
      "description":
          "Guided project decisions with expertise in figma and user experience."
    },
  ];

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Container(
        decoration: BoxDecoration(
          color: Colors.lightBlue[50], // Background color
        ),
        padding: const EdgeInsets.symmetric(vertical: 40, horizontal: 16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            // About Us Section (With Gradient)
            Container(
              padding: EdgeInsets.all(16),
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: [Colors.blue.shade100, Colors.green.shade100],
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                ),
                borderRadius: BorderRadius.circular(12),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black12,
                    blurRadius: 8,
                    spreadRadius: 2,
                  ),
                ],
              ),
              child: Column(
                children: [
                  Text(
                    "About Us",
                    style: TextStyle(fontSize: 26, fontWeight: FontWeight.bold),
                  ),
                  SizedBox(height: 10),
                  Text(
                    "We're a passionate team working towards sustainability and reducing GHG emissions through innovation and technology.",
                    textAlign: TextAlign.center,
                    style: TextStyle(fontSize: 16, color: Colors.grey[700]),
                  ),
                ],
              ),
            ),
            SizedBox(height: 40),

            // Section Title
            Text(
              "Project Contributors",
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 20),

            // Contributors Grid (Wrap for Responsive Layout)
            LayoutBuilder(
              builder: (context, constraints) {
                double imageSize = constraints.maxWidth > 600
                    ? 110
                    : 90; // Adjust for smaller screens
                double textSize =
                    constraints.maxWidth > 600 ? 12 : 10; // Adjust text size

                return Wrap(
                  alignment: WrapAlignment.center,
                  spacing: 20, // Horizontal spacing
                  runSpacing: 20, // Vertical spacing
                  children: contributors.map((contributor) {
                    return _buildContributor(contributor, imageSize, textSize);
                  }).toList(),
                );
              },
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildContributor(
      Map<String, String> contributor, double imageSize, double textSize) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Container(
          padding: EdgeInsets.all(4), // Border effect
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            border: Border.all(color: Colors.blueAccent, width: 3),
          ),
          child: ClipOval(
            child: InteractiveViewer(
              boundaryMargin: EdgeInsets.all(10), // Allow panning
              minScale: 1.0, // Normal size
              maxScale: 3.0, // Zoom up to 3x
              child: SizedBox(
                width: imageSize,
                height: imageSize,
                child: Image.asset(
                  contributor['image']!,
                  fit: BoxFit.cover, // Keeps zoom effect natural
                ),
              ),
            ),
          ),
        ),
        SizedBox(height: 8),
        Text(
          contributor['name']!,
          style: TextStyle(fontWeight: FontWeight.bold, fontSize: 14),
        ),
        Text(
          contributor['role']!,
          style: TextStyle(fontSize: 12, color: Colors.grey[700]),
        ),
        SizedBox(height: 4),
        SizedBox(
          width: imageSize * 1.5, // Restrict text width
          child: Text(
            contributor['description']!,
            textAlign: TextAlign.center,
            style: TextStyle(fontSize: textSize, color: Colors.grey[600]),
            maxLines: 3,
            overflow: TextOverflow.ellipsis,
          ),
        ),
      ],
    );
  }
}
