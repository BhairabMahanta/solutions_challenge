import 'package:flutter/material.dart';
import 'package:firebase_dart/firebase_dart.dart' as firebase;
import 'package:new_solution/screens/unloggedScreens/dashboard_screen.dart';

class UserProfileMenu extends StatefulWidget {
  final firebase.User user;
  const UserProfileMenu({Key? key, required this.user}) : super(key: key);

  @override
  _UserProfileMenuState createState() => _UserProfileMenuState();
}

class _UserProfileMenuState extends State<UserProfileMenu> {
  OverlayEntry? _overlayEntry;
  final LayerLink _layerLink = LayerLink();
  bool isDropdownOpen = false;

  void toggleDropdown() {
    if (isDropdownOpen) {
      _overlayEntry?.remove();
      _overlayEntry = null;
    } else {
      _overlayEntry = _createOverlayEntry();
      Overlay.of(context).insert(_overlayEntry!);
    }
    setState(() {
      isDropdownOpen = !isDropdownOpen;
    });
  }

  OverlayEntry _createOverlayEntry() {
    return OverlayEntry(
      builder: (context) => Positioned(
        width: 200, // Adjust dropdown width
        child: CompositedTransformFollower(
          link: _layerLink,
          offset: Offset(0, 50), // Adjust dropdown position
          child: Material(
            color: Colors.white,
            elevation: 5,
            borderRadius: BorderRadius.circular(8),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                ListTile(
                  leading: Icon(Icons.person),
                  title: Text("Profile"),
                  onTap: () {},
                ),
                ListTile(
                  leading: Icon(Icons.settings),
                  title: Text("Settings"),
                  onTap: () {},
                ),
                ListTile(
                  leading: Icon(Icons.logout, color: Colors.red),
                  title: Text("Log Out", style: TextStyle(color: Colors.red)),
                  onTap: () async {
                    // Close dropdown before signing out
                    _overlayEntry?.remove();
                    _overlayEntry = null;
                    setState(() {
                      isDropdownOpen = false;
                    });

                    await firebase.FirebaseAuth.instance.signOut();
                  },
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return CompositedTransformTarget(
      link: _layerLink,
      child: GestureDetector(
        onTap: toggleDropdown,
        child: Row(
          children: [
            CircleAvatar(
              backgroundImage: widget.user.photoURL != null
                  ? NetworkImage(widget.user.photoURL!)
                  : AssetImage("images/avatar1.jpg") as ImageProvider,
              radius: 18,
            ),
            SizedBox(width: 8),
            Text(
              widget.user.displayName ?? "User",
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
            ),
            Icon(
              isDropdownOpen ? Icons.arrow_drop_up : Icons.arrow_drop_down,
            ),
          ],
        ),
      ),
    );
  }
}
