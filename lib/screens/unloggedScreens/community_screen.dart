import 'package:flutter/material.dart';
import 'package:new_solution/widgets/community/community_list.dart';
import 'package:new_solution/widgets/community/community_navbar.dart';
import 'package:new_solution/widgets/community/community_sidebars.dart';
import 'package:new_solution/widgets/community/community_topbar.dart';

class CommunityScreen extends StatefulWidget {
  @override
  _CommunityScreenState createState() => _CommunityScreenState();
}

class _CommunityScreenState extends State<CommunityScreen> {
  TextEditingController searchController = TextEditingController();
  List<String> selectedTags = [];

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
                  Navigator.pop(context);
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
    return Scaffold(
      backgroundColor: Colors.black, // Temporary, will adjust for effects
      body: Row(
        children: [
          // Left Sidebar (User Icons)
          CommunitySidebar(),

          // Main Content
          Expanded(
            child: Column(
              children: [
                // Navbar (Top Navigation)
                CommunityNavBar(),

                // TopBar (Search & Filters)
                Container(
                  padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                  decoration:
                      BoxDecoration(color: Colors.black.withOpacity(0.5)),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
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
                          onChanged: (value) {
                            setState(() {}); // Update search query in real-time
                          },
                        ),
                      ),
                      SizedBox(width: 15),
                      IconButton(
                        icon: Icon(Icons.filter_list, color: Colors.white),
                        onPressed: _showTagPopup,
                      ),
                    ],
                  ),
                ),

                // Community List Section
                Expanded(
                  child: CommunityList(
                    selectedTags: selectedTags,
                    searchQuery: searchController.text,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
