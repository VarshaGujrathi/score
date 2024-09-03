import 'package:flutter/material.dart';

class SchedulePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: Colors.black),
          onPressed: () {
            Navigator.pop(context); // Navigate back
          },
        ),
        backgroundColor: Colors.transparent, // Transparent background
        elevation: 0, // Remove shadow
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: SingleChildScrollView(
          child: DataTable(
            columns: const <DataColumn>[
              DataColumn(
                label: Text(
                  'Total Match',
                  style: TextStyle(
                      fontWeight: FontWeight.bold,
                      color: Colors.black), // Bold and black color
                ),
              ),
              DataColumn(
                label: Text(
                  'Date',
                  style: TextStyle(
                      fontWeight: FontWeight.bold,
                      color: Colors.black), // Bold and black color
                ),
              ),
              DataColumn(
                label: Text(
                  'Team Name',
                  style: TextStyle(
                      fontWeight: FontWeight.bold,
                      color: Colors.black), // Bold and black color
                ),
              ),
              DataColumn(
                label: Text(
                  'captain Name',
                  style: TextStyle(
                      fontWeight: FontWeight.bold,
                      color: Colors.black), // Bold and black color
                ),
              ),
              DataColumn(
                label: Text(
                  'captain Mob.No',
                  style: TextStyle(
                      fontWeight: FontWeight.bold,
                      color: Colors.black), // Bold and black color
                ),
              ),
              DataColumn(
                label: Text(
                  'Date',
                  style: TextStyle(
                      fontWeight: FontWeight.bold,
                      color: Colors.black), // Bold and black color
                ),
              ),
              DataColumn(
                label: Text(
                  'Timing',
                  style: TextStyle(
                      fontWeight: FontWeight.bold,
                      color: Colors.black), // Bold and black color
                ),
              ),
            ],
            rows: const <DataRow>[
              DataRow(
                cells: <DataCell>[
                  DataCell(Text('M1',
                      style:
                          TextStyle(color: Colors.black))), // Black color text
                  DataCell(Text('1/1/24',
                      style:
                          TextStyle(color: Colors.black))), // Black color text
                  DataCell(Text('Comps-TY',
                      style:
                          TextStyle(color: Colors.black))), // Black color text
                  DataCell(Text('Tanvi',
                      style:
                          TextStyle(color: Colors.black))), // Black color text
                  DataCell(Text('xxxxxxxx',
                      style:
                          TextStyle(color: Colors.black))), // Black color text
                  DataCell(Text('EXTC-TY vs COMPS-TY',
                      style: TextStyle(
                          color: Colors.black))), // Black color text for Date
                  DataCell(Text('3:00-4:00 PM',
                      style: TextStyle(
                          color: Colors
                              .black))), // Black color text for Total Match
                ],
              ),
              // Add more rows here if needed
            ],
          ),
        ),
      ),
    );
  }
}
