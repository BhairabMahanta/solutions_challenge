import 'package:flutter/material.dart';

class CommunityTopBar extends StatefulWidget {
  @override
  _CommunityTopBarState createState() => _CommunityTopBarState();
}

class _CommunityTopBarState extends State<CommunityTopBar> {
  TextEditingController searchController = TextEditingController();
  List<String> selectedTags = [];

  // Sample tags (can be modified based on categories)
  final List<String> availableTags = [
    "Gaming",
    "Tech",
    "Education",
    "Entertainment",
    "Music",
    "Anime"
  ];

  void _showTagPopup() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text("Select Tags"),
          content: Wrap(
            spacing: 10,
            children: availableTags.map((tag) {
              bool isSelected = selectedTags.contains(tag);
              return FilterChip(
                label: Text(tag),
                selected: isSelected,
                onSelected: (bool value) {
                  setState(() {
                    if (value) {
                      selectedTags.add(tag);
                    } else {
                      selectedTags.remove(tag);
                    }
                  });
                  Navigator.pop(context); // Close dialog on selection
                },
              );
            }).toList(),
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
      decoration: BoxDecoration(
        color: Colors.black.withOpacity(0.5),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          // Search Bar
          Expanded(
            child: TextField(
              controller: searchController,
              style: TextStyle(color: Colors.white),
              decoration: InputDecoration(
                hintText: "Find a channel...",
                hintStyle: TextStyle(color: Colors.white70),
                prefixIcon: Icon(Icons.search, color: Colors.white),
                filled: true,
                fillColor: Colors.grey[800],
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                  borderSide: BorderSide.none,
                ),
              ),
            ),
          ),
          SizedBox(width: 15),

          // Tags Popup Button
          IconButton(
            icon: Icon(Icons.filter_list, color: Colors.white),
            onPressed: _showTagPopup,
          ),

          // Sorting & Hide Muted
          _filterButton("Last Active", Icons.swap_vert),
          SizedBox(width: 10),
          _toggleButton("Hide Muted Servers", true),
        ],
      ),
    );
  }

  Widget _filterButton(String title, IconData icon) {
    return TextButton.icon(
      style: TextButton.styleFrom(
        foregroundColor: Colors.white,
        padding: EdgeInsets.symmetric(horizontal: 15, vertical: 10),
        backgroundColor: Colors.grey[800],
      ),
      onPressed: () {},
      icon: Icon(icon, size: 18),
      label: Text(title),
    );
  }

  Widget _toggleButton(String title, bool isActive) {
    return TextButton.icon(
      style: TextButton.styleFrom(
        foregroundColor: Colors.white,
        padding: EdgeInsets.symmetric(horizontal: 15, vertical: 10),
        backgroundColor: isActive ? Colors.green[600] : Colors.grey[800],
      ),
      onPressed: () {},
      icon: isActive ? Icon(Icons.check) : Icon(Icons.close),
      label: Text(title),
    );
  }
}
