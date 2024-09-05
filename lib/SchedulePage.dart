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
        padding: const EdgeInsets.all(8.0), // Reduced padding
        child: SingleChildScrollView(
          scrollDirection: Axis.horizontal, // Enable horizontal scrolling
          child: DataTable(
            columnSpacing: 10.0, // Reduced spacing between columns
            columns: const <DataColumn>[
              DataColumn(
                label: Expanded(
                  child: Text(
                    'Total Match',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      color: Colors.black,
                      fontSize: 14, // Adjusted font size
                    ),
                    textAlign: TextAlign.center, // Center-align text
                  ),
                ),
              ),
              DataColumn(
                label: Expanded(
                  child: Text(
                    'Date',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      color: Colors.black,
                      fontSize: 14, // Adjusted font size
                    ),
                    textAlign: TextAlign.center,
                  ),
                ),
              ),
              DataColumn(
                label: Expanded(
                  child: Text(
                    'Team Name',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      color: Colors.black,
                      fontSize: 14, // Adjusted font size
                    ),
                    textAlign: TextAlign.center,
                  ),
                ),
              ),
              DataColumn(
                label: Expanded(
                  child: Text(
                    'Captain Name',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      color: Colors.black,
                      fontSize: 14, // Adjusted font size
                    ),
                    textAlign: TextAlign.center,
                  ),
                ),
              ),
              DataColumn(
                label: Expanded(
                  child: Text(
                    'Captain Mob.No',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      color: Colors.black,
                      fontSize: 14, // Adjusted font size
                    ),
                    textAlign: TextAlign.center,
                  ),
                ),
              ),
              DataColumn(
                label: Expanded(
                  child: Text(
                    'Opponent Team',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      color: Colors.black,
                      fontSize: 14, // Adjusted font size
                    ),
                    textAlign: TextAlign.center,
                  ),
                ),
              ),
              DataColumn(
                label: Expanded(
                  child: Text(
                    'Timing',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      color: Colors.black,
                      fontSize: 14, // Adjusted font size
                    ),
                    textAlign: TextAlign.center,
                  ),
                ),
              ),
            ],
            rows: const <DataRow>[
              DataRow(
                cells: <DataCell>[
                  DataCell(Text('M1',
                      style: TextStyle(color: Colors.black, fontSize: 12))),
                  DataCell(Text('1/1/24',
                      style: TextStyle(color: Colors.black, fontSize: 12))),
                  DataCell(Text('Comps-TY',
                      style: TextStyle(color: Colors.black, fontSize: 12))),
                  DataCell(Text('Tanvi',
                      style: TextStyle(color: Colors.black, fontSize: 12))),
                  DataCell(Text('xxxxxxxx',
                      style: TextStyle(color: Colors.black, fontSize: 12))),
                  DataCell(Text('EXTC-TY vs COMPS-TY',
                      style: TextStyle(color: Colors.black, fontSize: 12))),
                  DataCell(Text('3:00-4:00 PM',
                      style: TextStyle(color: Colors.black, fontSize: 12))),
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
