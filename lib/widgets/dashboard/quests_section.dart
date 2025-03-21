import 'package:flutter/material.dart';

class QuestsSection extends StatefulWidget {
  @override
  _QuestsSectionState createState() => _QuestsSectionState();
}

class _QuestsSectionState extends State<QuestsSection> {
  final List<String> quests = [
    "Plant a Tree",
    "Walk 10K Steps",
    "Reduce Plastic Use",
    "Eat Vegan for a Day",
    "Use Public Transport"
  ];

  Map<String, bool> checkedStates = {};

  @override
  void initState() {
    super.initState();
    for (var quest in quests) {
      checkedStates[quest] = false;
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
                          children: quests
                              .map((quest) => _buildQuestItem(quest))
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

  Widget _buildQuestItem(String quest) {
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
            backgroundColor: Colors.purple[100],
            radius: 16,
            child: Text(
              "A",
              style:
                  TextStyle(color: Colors.purple, fontWeight: FontWeight.bold),
            ),
          ),
          SizedBox(width: 8),
          Expanded(
            child: Text(
              quest,
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
            ),
          ),
          Checkbox(
            value: checkedStates[quest] ?? false,
            onChanged: (bool? value) {
              setState(() {
                checkedStates[quest] = value!;
              });
            },
          ),
        ],
      ),
    );
  }
}
