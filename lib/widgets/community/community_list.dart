import 'package:flutter/material.dart';
import 'package:new_solution/screens/unloggedScreens/community_details_screen.dart';

class CommunityList extends StatelessWidget {
  final List<String> selectedTags;
  final String searchQuery;

  CommunityList({required this.selectedTags, required this.searchQuery});

  final List<Map<String, dynamic>> communities = [
    {
      "name": "Login Help",
      "members": "2K members",
      "icon": "images/avatar1.jpg",
      "tags": ["Tech"]
    },
    {
      "name": "Daily Challenge",
      "members": "1K members",
      "icon": "images/avatar2.jpg",
      "tags": ["Gaming"]
    },
    {
      "name": "Minecraft",
      "members": "2M members",
      "icon": "images/avatar3.jpg",
      "tags": ["Gaming", "Tech"]
    },
    {
      "name": "Roblox",
      "members": "2M members",
      "icon": "images/avatar4.jpg",
      "tags": ["Gaming"]
    },
    {
      "name": "Terraria",
      "members": "2M members",
      "icon": "images/avatar4.jpg",
      "tags": ["Gaming"]
    },
    {
      "name": "One Piece",
      "members": "2M members",
      "icon": "images/avatar3.jpg",
      "tags": ["Anime", "Entertainment"]
    },
    {
      "name": "Helldivers II",
      "members": "2M members",
      "icon": "images/avatar2.jpg",
      "tags": ["Gaming"]
    },
    {
      "name": "Valorant",
      "members": "2M members",
      "icon": "images/avatar1.jpg",
      "tags": ["Gaming", "Esports"]
    },
  ];

  @override
  Widget build(BuildContext context) {
    List<Map<String, dynamic>> filteredCommunities =
        communities.where((community) {
      bool matchesSearch =
          community["name"].toLowerCase().contains(searchQuery.toLowerCase());
      bool matchesTags = selectedTags.isEmpty ||
          selectedTags.any((tag) => community["tags"].contains(tag));
      return matchesSearch && matchesTags;
    }).toList();

    return Padding(
      padding: EdgeInsets.all(20),
      child: GridView.builder(
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 4,
          crossAxisSpacing: 15,
          mainAxisSpacing: 15,
          childAspectRatio: 3,
        ),
        itemCount: filteredCommunities.length,
        itemBuilder: (context, index) {
          return GestureDetector(
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => CommunityDetailScreen(
                    communityName: filteredCommunities[index]["name"],
                    // members: filteredCommunities[index]["members"],
                    // icon: filteredCommunities[index]["icon"],
                    // tags: filteredCommunities[index]["tags"],
                  ),
                ),
              );
            },
            child: _communityTile(
              filteredCommunities[index]["name"],
              filteredCommunities[index]["members"],
              filteredCommunities[index]["icon"],
              filteredCommunities[index]["tags"],
            ),
          );
        },
      ),
    );
  }

  Widget _communityTile(
      String name, String members, String icon, List<String> tags) {
    return Container(
      padding: EdgeInsets.all(15),
      decoration: BoxDecoration(
        color: Colors.grey[900],
        borderRadius: BorderRadius.circular(10),
      ),
      child: Row(
        children: [
          CircleAvatar(
            backgroundImage: AssetImage(icon),
            radius: 25,
          ),
          SizedBox(width: 15),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(name, style: TextStyle(color: Colors.white, fontSize: 16)),
              Text(members, style: TextStyle(color: Colors.grey, fontSize: 12)),
              Wrap(
                spacing: 5,
                children: tags
                    .map((tag) => Chip(
                          label: Text(tag, style: TextStyle(fontSize: 10)),
                          backgroundColor: Colors.blueGrey,
                        ))
                    .toList(),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

// class CommunityDetailScreen extends StatelessWidget {
//   final String name;
//   final String members;
//   final String icon;
//   final List<String> tags;

//   CommunityDetailScreen(
//       {required this.name,
//       required this.members,
//       required this.icon,
//       required this.tags});

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text(name),
//       ),
//       body: Center(
//         child: Column(
//           mainAxisAlignment: MainAxisAlignment.center,
//           children: [
//             CircleAvatar(
//               backgroundImage: AssetImage(icon),
//               radius: 50,
//             ),
//             SizedBox(height: 20),
//             Text(name,
//                 style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold)),
//             Text(members, style: TextStyle(fontSize: 16, color: Colors.grey)),
//             SizedBox(height: 10),
//             Wrap(
//               spacing: 8,
//               children: tags
//                   .map((tag) => Chip(
//                         label: Text(tag),
//                         backgroundColor: Colors.blueGrey,
//                       ))
//                   .toList(),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }
