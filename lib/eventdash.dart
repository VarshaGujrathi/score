import 'package:flutter/material.dart';

void main() {
  runApp(MaterialApp(
    home: EventDashPage(),
    routes: {
      '/leaderboard': (context) => EventLeadPage(),
      '/schedule': (context) => SchedulePage(),
    },
  ));
}

class EventDashPage extends StatefulWidget {
  @override
  _EventDashPageState createState() => _EventDashPageState();
}

class _EventDashPageState extends State<EventDashPage> {
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
    {
      'Team Name': 'Team C',
      'Captain Name': 'Alice Johnson',
      'Captain Mob. No': '5678901234',
      'Registration Status': 'Unpaid',
      'Sports': 'Volleyball',
    },
    {
      'Team Name': 'Team D',
      'Captain Name': 'Bob Brown',
      'Captain Mob. No': '6789012345',
      'Registration Status': 'Unpaid',
      'Sports': 'Cricket',
    },
    {
      'Team Name': 'Team E',
      'Captain Name': 'Carol Davis',
      'Captain Mob. No': '7890123456',
      'Registration Status': 'Unpaid',
      'Sports': 'Badminton',
    },
    {
      'Team Name': 'Team F',
      'Captain Name': 'Eve White',
      'Captain Mob. No': '8901234567',
      'Registration Status': 'Unpaid',
      'Sports': 'Tennis',
    },
    {
      'Team Name': 'Team G',
      'Captain Name': 'Frank Black',
      'Captain Mob. No': '9012345678',
      'Registration Status': 'Unpaid',
      'Sports': 'Hockey',
    },
    {
      'Team Name': 'Team H',
      'Captain Name': 'Grace Blue',
      'Captain Mob. No': '0123456789',
      'Registration Status': 'Unpaid',
      'Sports': 'Baseball',
    },
    {
      'Team Name': 'Team I',
      'Captain Name': 'Hank Green',
      'Captain Mob. No': '1234567890',
      'Registration Status': 'Unpaid',
      'Sports': 'Table Tennis',
    },
    {
      'Team Name': 'Team J',
      'Captain Name': 'Ivy Gold',
      'Captain Mob. No': '2345678901',
      'Registration Status': 'Unpaid',
      'Sports': 'Swimming',
    },
    {
      'Team Name': 'Team K',
      'Captain Name': 'Jack Silver',
      'Captain Mob. No': '3456789012',
      'Registration Status': 'Unpaid',
      'Sports': 'Athletics',
    },
    {
      'Team Name': 'Team L',
      'Captain Name': 'Jill Rose',
      'Captain Mob. No': '4567890123',
      'Registration Status': 'Unpaid',
      'Sports': 'Cycling',
    },
    {
      'Team Name': 'Team M',
      'Captain Name': 'Ken Reed',
      'Captain Mob. No': '5678901234',
      'Registration Status': 'Unpaid',
      'Sports': 'Gymnastics',
    },
    {
      'Team Name': 'Team N',
      'Captain Name': 'Lara Lee',
      'Captain Mob. No': '6789012345',
      'Registration Status': 'Unpaid',
      'Sports': 'Boxing',
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        iconTheme: IconThemeData(color: Colors.black),
        leading: IconButton(
          icon: Icon(Icons.menu),
          onPressed: () {
            _showMenu(context);
          },
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Table(
          border: TableBorder.all(color: Colors.black),
          columnWidths: const <int, TableColumnWidth>{
            0: FlexColumnWidth(2),
            1: FlexColumnWidth(2),
            2: FlexColumnWidth(2),
            3: FlexColumnWidth(2),
            4: FlexColumnWidth(2),
          },
          defaultVerticalAlignment: TableCellVerticalAlignment.middle,
          children: [
            TableRow(
              decoration: BoxDecoration(color: Colors.black),
              children: [
                tableCellText('Team Name', isHeader: true),
                tableCellText('Captain Name', isHeader: true),
                tableCellText('Sports', isHeader: true),
                tableCellText('Captain Mob. No', isHeader: true),
                tableCellText('Registration Status', isHeader: true),
              ],
            ),
            ...studentData.map((student) {
              return TableRow(
                children: [
                  tableCellText(student['Team Name']),
                  tableCellText(student['Captain Name']),
                  tableCellText(student['Sports']),
                  tableCellText(student['Captain Mob. No']),
                  tableCellPaidUnpaidStatus(student),
                ],
              );
            }).toList(),
          ],
        ),
      ),
    );
  }

  Widget tableCellText(String text, {bool isHeader = false}) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Text(
        text,
        style: TextStyle(
          fontWeight: isHeader ? FontWeight.bold : FontWeight.normal,
          color: isHeader ? Colors.white : Colors.black,
        ),
        textAlign: TextAlign.center,
      ),
    );
  }

  Widget tableCellPaidUnpaidStatus(Map<String, dynamic> student) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Expanded(
            child: ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor:
                    student['Registration Status'] == 'Paid' ? Colors.green : Colors.black,
                padding: EdgeInsets.symmetric(vertical: 4),
              ),
              onPressed: () {
                setState(() {
                  student['Registration Status'] = 'Paid';
                });

                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    content: Text('${student['Team Name']} is now Paid'),
                  ),
                );
              },
              child: Text(
                'Paid',
                style: TextStyle(color: Colors.white, fontSize: 12),
              ),
            ),
          ),
          SizedBox(width: 8),
          Expanded(
            child: ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor:
                    student['Registration Status'] == 'Unpaid' ? Colors.red : Colors.black,
                padding: EdgeInsets.symmetric(vertical: 4),
              ),
              onPressed: () {
                setState(() {
                  student['Registration Status'] = 'Unpaid';
                });

                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    content: Text('${student['Team Name']} is now Unpaid'),
                  ),
                );
              },
              child: Text(
                'Unpaid',
                style: TextStyle(color: Colors.white, fontSize: 12),
              ),
            ),
          ),
        ],
      ),
    );
  }

  void _showMenu(BuildContext context) {
    showModalBottomSheet(
      context: context,
      builder: (context) {
        return Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            ListTile(
              leading: Icon(Icons.leaderboard, color: Colors.black),
              title: Text('Leaderboard', style: TextStyle(color: Colors.black)),
              onTap: () {
                Navigator.pop(context);
                Navigator.pushNamed(context, '/leaderboard');
              },
            ),
            ListTile(
              leading: Icon(Icons.schedule, color: Colors.black),
              title: Text('Schedule', style: TextStyle(color: Colors.black)),
              onTap: () {
                Navigator.pop(context);
                Navigator.pushNamed(context, '/schedule');
              },
            ),
          ],
        );
      },
    );
  }
}

class EventLeadPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Leaderboard'),
      ),
      body: Center(
        child: Text('Leaderboard Page Content'),
      ),
    );
  }
}

class SchedulePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Schedule'),
      ),
      body: Center(
        child: Text('Schedule Page Content'),
      ),
    );
  }
}
