import 'package:flutter/material.dart';

class UserDashPage extends StatefulWidget {
  @override
  _UserDashPageState createState() => _UserDashPageState();
}

class _UserDashPageState extends State<UserDashPage> {
  // Sample data
  List<Map<String, dynamic>> studentData = [
    {
      'Total Student': '10',
      'Student Name': 'John Doe',
      'Student Email': 'john@example.com',
      'Branch': 'CSE',
      'College ID': '12345',
      'isApproved': false,
    },
    {
      'Total Student': '11',
      'Student Name': 'Jane Smith',
      'Student Email': 'jane@example.com',
      'Branch': 'ECE',
      'College ID': '54321',
      'isApproved': false,
    },
    {
      'Total Student': '12',
      'Student Name': 'Alice Johnson',
      'Student Email': 'alice@example.com',
      'Branch': 'ME',
      'College ID': '67890',
      'isApproved': false,
    },
    {
      'Total Student': '13',
      'Student Name': 'Bob Brown',
      'Student Email': 'bob@example.com',
      'Branch': 'CE',
      'College ID': '98765',
      'isApproved': false,
    },
    {
      'Total Student': '14',
      'Student Name': 'Carol Davis',
      'Student Email': 'carol@example.com',
      'Branch': 'IT',
      'College ID': '56789',
      'isApproved': false,
    },
    {
      'Total Student': '15',
      'Student Name': 'David Wilson',
      'Student Email': 'david@example.com',
      'Branch': 'CSE',
      'College ID': '34567',
      'isApproved': false,
    },
    {
      'Total Student': '16',
      'Student Name': 'Eva Lewis',
      'Student Email': 'eva@example.com',
      'Branch': 'ECE',
      'College ID': '87654',
      'isApproved': false,
    },
    {
      'Total Student': '17',
      'Student Name': 'Frank Clark',
      'Student Email': 'frank@example.com',
      'Branch': 'ME',
      'College ID': '23456',
      'isApproved': false,
    },
    {
      'Total Student': '18',
      'Student Name': 'Grace Martinez',
      'Student Email': 'grace@example.com',
      'Branch': 'CE',
      'College ID': '65432',
      'isApproved': false,
    },
    {
      'Total Student': '19',
      'Student Name': 'Hank Anderson',
      'Student Email': 'hank@example.com',
      'Branch': 'IT',
      'College ID': '12321',
      'isApproved': false,
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white, // Background set to white
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        iconTheme: IconThemeData(color: Colors.black),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Table(
          border: TableBorder.all(color: Colors.black), // Black border for the table
          columnWidths: const <int, TableColumnWidth>{
            0: FlexColumnWidth(1),
            1: FlexColumnWidth(2),
            2: FlexColumnWidth(2),
            3: FlexColumnWidth(2),
            4: FlexColumnWidth(1.5),
            5: FlexColumnWidth(2),
          },
          defaultVerticalAlignment: TableCellVerticalAlignment.middle,
          children: [
            TableRow(
              decoration: BoxDecoration(color: Colors.black), // Black column headers
              children: [
                tableCellText('Total Student', isHeader: true),
                tableCellText('Student Name', isHeader: true),
                tableCellText('Student Email', isHeader: true),
                tableCellText('Branch', isHeader: true),
                tableCellText('College ID', isHeader: true),
                tableCellText('Status', isHeader: true),
              ],
            ),
            ...studentData.map((student) {
              return TableRow(
                children: [
                  tableCellText(student['Total Student']),
                  tableCellText(student['Student Name']),
                  tableCellText(student['Student Email']),
                  tableCellText(student['Branch']),
                  tableCellText(student['College ID']),
                  tableCellCheckboxWithStatus(student),
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
          color: isHeader ? Colors.white : Colors.black, // White text for headers, black for content
        ),
        textAlign: TextAlign.center,
      ),
    );
  }

  Widget tableCellCheckboxWithStatus(Map<String, dynamic> student) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Expanded(
            child: ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: student['isApproved'] ? Colors.green : Colors.black, // Green if approved
                padding: EdgeInsets.symmetric(vertical: 4), // Reduced padding
              ),
              onPressed: () {
                setState(() {
                  student['isApproved'] = true;
                  student['Status'] = 'Approved';
                });

                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                      content: Text(
                          '${student['Student Name']} is now ${student['Status']}')),
                );
              },
              child: Text(
                'Approve',
                style: TextStyle(color: Colors.white, fontSize: 12), // Smaller text size
              ),
            ),
          ),
          SizedBox(width: 8),
          Expanded(
            child: ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: student['isApproved'] ? Colors.black : Colors.red, // Red if not approved
                padding: EdgeInsets.symmetric(vertical: 4), // Reduced padding
              ),
              onPressed: () {
                setState(() {
                  student['isApproved'] = false;
                  student['Status'] = 'Rejected';
                });

                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                      content: Text(
                          '${student['Student Name']} is now ${student['Status']}')),
                );
              },
              child: Text(
                'Reject',
                style: TextStyle(color: Colors.white, fontSize: 12), // Smaller text size
              ),
            ),
          ),
        ],
      ),
    );
  }
}
