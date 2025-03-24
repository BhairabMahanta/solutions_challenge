import 'package:flutter/material.dart';
import 'package:new_solution/services/daily_tasks_service.dart';

class DailyTasksPopup extends StatefulWidget {
  @override
  _DailyTasksPopupState createState() => _DailyTasksPopupState();
}

class _DailyTasksPopupState extends State<DailyTasksPopup> {
  final DailyTasksService _taskService = DailyTasksService();
  List<Map<String, String>> tasks = [];
  Map<String, bool> checkedStates = {};

  @override
  void initState() {
    super.initState();
    _loadTasks();
  }

  Future<void> _loadTasks() async {
    List<Map<String, String>> newTasks = await _taskService.fetchDailyTasks();
    setState(() {
      tasks = newTasks;
      checkedStates.clear();
      for (var task in tasks) {
        checkedStates[task["task"]!] = false;
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Dialog(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: Padding(
        padding: EdgeInsets.all(12),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            _buildScrollBar(),
            _buildTaskList(),
            _buildScrollBar(),
            SizedBox(height: 10),
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: Text("Close", style: TextStyle(fontSize: 16)),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildTaskList() {
    return Container(
      decoration: BoxDecoration(
        color: Color(0xFFFEF7EA),
        borderRadius: BorderRadius.circular(6),
        border: Border.symmetric(
          vertical: BorderSide(color: Colors.lightBlue[50]!, width: 6),
        ),
      ),
      child: Stack(
        children: [
          _buildSideBar(left: true),
          _buildSideBar(left: false),
          Padding(
            padding: EdgeInsets.all(12),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                ...tasks.map((task) => _buildActionItem(task)),
                SizedBox(height: 10),
                ElevatedButton(
                  onPressed: _loadTasks, // ✅ Now fetches new tasks!
                  child: Text("Next Day"),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSideBar({required bool left}) {
    return Positioned(
      left: left ? -6 : null,
      right: left ? null : -6,
      top: 0,
      bottom: 0,
      width: 6,
      child: Container(color: Color(0xFFD9B36E)),
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
            colors: [Color(0xFF9B6AFF), Color(0xFF4C21AA)],
          ),
        ),
      ),
    );
  }

  Widget _buildActionItem(Map<String, String> task) {
    return Container(
      margin: EdgeInsets.symmetric(vertical: 4),
      padding: EdgeInsets.symmetric(vertical: 8, horizontal: 12),
      decoration: BoxDecoration(
        color: Color(0xFFF0EDE8),
        borderRadius: BorderRadius.circular(8),
        boxShadow: [
          BoxShadow(color: Colors.black12, blurRadius: 3, offset: Offset(1, 2)),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              CircleAvatar(
                backgroundColor: Colors.blue[100],
                radius: 16,
                child: Icon(Icons.bolt, color: Colors.blue),
              ),
              SizedBox(width: 8),
              Expanded(
                child: Text(task["task"]!,
                    style:
                        TextStyle(fontSize: 16, fontWeight: FontWeight.w500)),
              ),
              Checkbox(
                value: checkedStates[task["task"]!] ?? false,
                onChanged: (bool? value) {
                  setState(() {
                    checkedStates[task["task"]!] = value!;
                  });
                },
              ),
            ],
          ),
          SizedBox(height: 5),
          Text(
            "📝 ${task["reason"]}",
            style: TextStyle(fontSize: 14, fontStyle: FontStyle.italic),
          ),
        ],
      ),
    );
  }
}
