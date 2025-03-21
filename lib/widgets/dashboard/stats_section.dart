import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class StatsSection extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return GridView.count(
      crossAxisCount: 2, // Two-column layout
      shrinkWrap: true,
      physics: NeverScrollableScrollPhysics(), // Prevents internal scrolling
      crossAxisSpacing: 10,
      mainAxisSpacing: 10,
      childAspectRatio: 3.2, // Adjust to match reference image
      children: [
        _statItem(Icons.local_shipping, "Transport", 4, 6),
        _statItem(Icons.local_cafe, "Food & Nutrition", 4, 6),
        _statItem(Icons.bolt, "Energy", 6, 8),
        _statItem(Icons.delete, "Waste Management", 2, 6, italic: true),
        _statItem(Icons.more_horiz, "Other", 3, 6),
      ],
    );
  }

  Widget _statItem(IconData icon, String title, int filled, int total,
      {bool italic = false}) {
    return Container(
      padding: EdgeInsets.symmetric(vertical: 12, horizontal: 16),
      decoration: BoxDecoration(
        color: Colors.lightBlue[50],
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: Colors.grey.shade300),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.3),
            blurRadius: 4,
            offset: Offset(2, 2),
          )
        ],
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Icon(icon, color: Colors.green, size: 28),
          SizedBox(width: 10),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  title,
                  style: GoogleFonts.getFont(
                    'Micro 5',
                    fontSize: 25,
                    fontWeight: FontWeight.bold,
                    fontStyle: italic ? FontStyle.italic : FontStyle.normal,
                  ),
                ),
                SizedBox(height: 6),
                _pixelProgressBar(filled, total),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _pixelProgressBar(int filled, int total) {
    return Row(
      children: List.generate(total, (index) {
        double opacity = (1 - (index / total)) * 0.8 + 0.2; // Darker at start
        return Container(
          width: 14,
          height: 14,
          margin: EdgeInsets.symmetric(horizontal: 1),
          decoration: BoxDecoration(
            color: Colors.green.shade900.withOpacity(opacity),
            borderRadius: BorderRadius.circular(2),
          ),
        );
      }),
    );
  }
}
