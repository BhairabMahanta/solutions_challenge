import 'package:flutter/material.dart';

class ActionsSection extends StatefulWidget {
  @override
  _ActionsSectionState createState() => _ActionsSectionState();
}

class _ActionsSectionState extends State<ActionsSection> {
  final List<String> actions = [
    "Turn off unused lights",
    "Recycle plastic waste",
    "Use a reusable bottle",
    "Bike instead of drive"
  ];

  Map<String, bool> checkedStates = {};

  @override
  void initState() {
    super.initState();
    for (var action in actions) {
      checkedStates[action] = false;
    }
  }

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        double maxWidth = constraints.maxWidth * 0.65;
        double sideBarWidth = maxWidth * 0.025;
        double paddingHorizontal = maxWidth * 0.05;

        return Column(
          children: [
            _buildScrollBar(),
            Center(
              child: ConstrainedBox(
                constraints: BoxConstraints(
                  maxWidth: maxWidth.clamp(280, 600),
                ),
                child: Container(
                  padding: EdgeInsets.symmetric(horizontal: 0),
                  decoration: BoxDecoration(
                    color: Color(0xFFFEF7EA),
                    borderRadius: BorderRadius.circular(6),
                    border: Border.symmetric(
                      vertical: BorderSide(
                          color: Colors.lightBlue[50]!, width: sideBarWidth),
                    ),
                  ),
                  child: Stack(
                    children: [
                      _buildSideBar(left: true, width: sideBarWidth),
                      _buildSideBar(left: false, width: sideBarWidth),
                      Padding(
                        padding: EdgeInsets.symmetric(
                            horizontal: paddingHorizontal, vertical: 12),
                        child: Column(
                          children: actions
                              .map((action) => _buildActionItem(action))
                              .toList(),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
            _buildScrollBar(),
          ],
        );
      },
    );
  }

  Widget _buildSideBar({required bool left, required double width}) {
    return Positioned(
      left: left ? -width / 2 : null,
      right: left ? null : -width / 2,
      top: 0,
      bottom: 0,
      width: width,
      child: Container(color: Color(0xFFD9B36E)), // Brown parchment side
    );
  }

  Widget _buildScrollBar() {
    return FractionallySizedBox(
      widthFactor: 0.75,
      child: Container(
        height: 20,
        margin: EdgeInsets.symmetric(horizontal: 8),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(6),
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            stops: [0.45, 0.55],
            colors: [Color(0xFF9B6AFF), Color(0xFF4C21AA)],
          ),
        ),
      ),
    );
  }

  Widget _buildActionItem(String action) {
    return Container(
      margin: EdgeInsets.symmetric(vertical: 4),
      padding: EdgeInsets.symmetric(vertical: 8, horizontal: 12),
      decoration: BoxDecoration(
        color: Color(0xFFF0EDE8),
        borderRadius: BorderRadius.circular(8),
        boxShadow: [
          BoxShadow(
            color: Colors.black12,
            blurRadius: 3,
            offset: Offset(1, 2),
          )
        ],
      ),
      child: Row(
        children: [
          CircleAvatar(
            backgroundColor: Colors.blue[100],
            radius: 16,
            child: Icon(Icons.bolt, color: Colors.blue),
          ),
          SizedBox(width: 8),
          Expanded(
            child: Text(
              action,
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
            ),
          ),
          Checkbox(
            value: checkedStates[action] ?? false,
            onChanged: (bool? value) {
              setState(() {
                checkedStates[action] = value!;
              });
            },
          ),
        ],
      ),
    );
  }
}
