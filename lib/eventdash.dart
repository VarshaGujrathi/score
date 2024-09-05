import 'package:flutter/material.dart';
import 'event_lead.dart'; // Import EventLeadPage
import 'schedule_event.dart'; // Import SchedulePage

void main() {
  runApp(MaterialApp(
  initialRoute: '/',
  routes: {
    '/leaderboard': (context) => EventLeadPage(),
    '/schedule': (context) => EventSchedulePage(),
  },
  ));
}

class EventDashPage extends StatefulWidget {
  @override
  _EventDashPageState createState() => _EventDashPageState();
}

class _EventDashPageState extends State<EventDashPage> {
  // Sample student/team data
  List<Map<String, dynamic>> studentData = [
    {
      'Team Name': 'Team A',
      'Captain Name': 'John Doe',
      'Captain Mob. No': '1234567890',
      'Registration Status': 'Unpaid',
      'Sports': 'Football',
    },
    {
      'Team Name': 'Team B',
      'Captain Name': 'Jane Smith',
      'Captain Mob. No': '0987654321',
      'Registration Status': 'Unpaid',
      'Sports': 'Basketball',
    },
    // Add more student/team data as needed
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        iconTheme: IconThemeData(color: Colors.black),
        leading: PopupMenuButton<int>(
          icon: Icon(Icons.menu),
          onSelected: (value) {
            if (value == 0) {
              Navigator.pushNamed(context, '/leaderboard');
            } else if (value == 1) {
              Navigator.pushNamed(context, '/schedule');
            }
          },
          itemBuilder: (context) => [
            PopupMenuItem<int>(
              value: 0,
              child: ListTile(
                leading: Icon(Icons.leaderboard, color: Colors.black),
                title: Text('Leaderboard'),
              ),
            ),
            PopupMenuItem<int>(
              value: 1,
              child: ListTile(
                leading: Icon(Icons.schedule, color: Colors.black),
                title: Text('Schedule'),
              ),
            ),
          ],
        ),
      ),
      body: Padding(
        padding: EdgeInsets.all(MediaQuery.of(context).size.width * 0.02),
        child: SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          child: ConstrainedBox(
            constraints: BoxConstraints(
              minWidth: MediaQuery.of(context).size.width,
            ),
            child: Table(
              border: TableBorder.all(color: Colors.black),
              columnWidths: const <int, TableColumnWidth>{
                0: FlexColumnWidth(2),
                1: FlexColumnWidth(2),
                2: FlexColumnWidth(2),
                3: FlexColumnWidth(2),
                4: FlexColumnWidth(2),
                5: FlexColumnWidth(2),
              },
              defaultVerticalAlignment: TableCellVerticalAlignment.middle,
              children: [
                TableRow(
                  decoration: BoxDecoration(color: Colors.black),
                  children: [
                    tableCellText('Team Name', isHeader: true),
                    tableCellText('Captain Name', isHeader: true),
                    tableCellText('Sports', isHeader: true),
                    tableCellText('Captain Mob.No', isHeader: true),
                    tableCellText('Status', isHeader: true),
                    tableCellText('Action', isHeader: true),
                  ],
                ),
                ...studentData.map((student) {
                  return TableRow(
                    children: [
                      tableCellText(student['Team Name']),
                      tableCellText(student['Captain Name']),
                      tableCellText(student['Sports']),
                      tableCellText(student['Captain Mob. No']),
                      tableCellStatus(student['Registration Status']),
                      tableCellAction(),
                    ],
                  );
                }).toList(),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget tableCellText(String text, {bool isHeader = false}) {
    return Padding(
      padding: EdgeInsets.all(MediaQuery.of(context).size.width * 0.01),
      child: Text(
        text,
        style: TextStyle(
          fontWeight: isHeader ? FontWeight.bold : FontWeight.normal,
          color: isHeader ? Colors.white : Colors.black,
          fontSize: MediaQuery.of(context).size.width * 0.04,
        ),
        textAlign: TextAlign.center,
      ),
    );
  }

  Widget tableCellStatus(String status) {
    bool isUnpaid = status == 'Unpaid';
    return Padding(
      padding: EdgeInsets.all(MediaQuery.of(context).size.width * 0.01),
      child: Checkbox(
        value: !isUnpaid,
        onChanged: (bool? newValue) {
          setState(() {
            // Update the registration status based on the checkbox
            studentData.firstWhere((student) => student['Registration Status'] == status)['Registration Status'] =
                newValue! ? 'Paid' : 'Unpaid';
          });
        },
        checkColor: Colors.white,
        activeColor: Colors.green,
        side: BorderSide(color: Colors.black),
      ),
    );
  }

  Widget tableCellAction() {
    return Padding(
      padding: EdgeInsets.all(MediaQuery.of(context).size.width * 0.01),
      child: IconButton(
        icon: Icon(Icons.notifications),
        color: const Color.fromARGB(255, 240, 173, 27),
        onPressed: () {
          // Display a snack bar when the action button is pressed
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text('Reminder icon clicked'),
            ),
          );
        },
      ),
    );
  }
}
