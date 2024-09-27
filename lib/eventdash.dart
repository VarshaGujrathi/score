// ignore_for_file: unused_import

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:score/SchedulePage.dart';
import 'package:score/event_Lead_page.dart';

class EventDashPage extends StatefulWidget {
  @override
  _EventDashPageState createState() => _EventDashPageState();
}

class _EventDashPageState extends State<EventDashPage> {
  String? selectedGame; // For filtering by game
  String? selectedPaymentStatus; // For filtering by payment status
  String? sortBy; // For sorting options

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white, // Set the background color to white
      appBar: AppBar(
        title: Text('Event Dashboard'),
        actions: [
          // Filter by Game Dropdown
          DropdownButton<String>(
            hint: Text("Filter by Game", style: TextStyle(color: Colors.black)),
            value: selectedGame,
            icon: Icon(Icons.arrow_downward, color: Colors.black),
            onChanged: (String? newValue) {
              setState(() {
                selectedGame = newValue;
              });
            },
            items: <String>[
              'All Games',
              'Football',
              'Cricket',
              'Volleyball',
              'Badminton',
              'Throwball',
              'Track'
            ].map<DropdownMenuItem<String>>((String value) {
              return DropdownMenuItem<String>(
                value: value == 'All Games' ? null : value,
                child: Text(value, style: TextStyle(color: Colors.black)),
              );
            }).toList(),
          ),
          SizedBox(width: 20),

          // Filter by Payment Status Dropdown
          DropdownButton<String>(
            hint: Text("Payment Status", style: TextStyle(color: Colors.black)),
            value: selectedPaymentStatus,
            icon: Icon(Icons.arrow_downward, color: Colors.black),
            onChanged: (String? newValue) {
              setState(() {
                selectedPaymentStatus = newValue;
              });
            },
            items: <String>['All', 'Completed', 'Pending']
                .map<DropdownMenuItem<String>>((String value) {
              return DropdownMenuItem<String>(
                value: value == 'All' ? null : value,
                child: Text(value, style: TextStyle(color: Colors.black)),
              );
            }).toList(),
          ),
          SizedBox(width: 20),

          // Sort Dropdown
          DropdownButton<String>(
            hint: Text("Sort by", style: TextStyle(color: Colors.black)),
            value: sortBy,
            icon: Icon(Icons.sort, color: Colors.black),
            onChanged: (String? newValue) {
              setState(() {
                sortBy = newValue;
              });
            },
            items: <String>['Game', 'Payment Status']
                .map<DropdownMenuItem<String>>((String value) {
              return DropdownMenuItem<String>(
                value: value,
                child: Text(value, style: TextStyle(color: Colors.black)),
              );
            }).toList(),
          ),
          SizedBox(width: 20),

          // Menu Icon Button
          PopupMenuButton<String>(
            icon: Icon(Icons.menu, color: Colors.black),
            onSelected: (String value) {
              if (value == 'Leaderboard') {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => EventLeadPage()),
                );
              } else if (value == 'Schedule') {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => SchedulePage()),
                );
              }
            },
            itemBuilder: (BuildContext context) {
              return {'Leaderboard', 'Schedule'}.map((String choice) {
                return PopupMenuItem<String>(
                  value: choice,
                  child: Text(choice, style: TextStyle(color: Colors.black)),
                );
              }).toList();
            },
          ),
        ],
      ),
      body: StreamBuilder(
        stream: _getFilteredAndSortedRegistrations(),
        builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          }

          if (snapshot.hasError) {
            return Center(child: Text('Error fetching data'));
          }

          if (!snapshot.hasData || snapshot.data!.docs.isEmpty) {
            return Center(child: Text('No registrations found'));
          }

          return ListView(
            children: snapshot.data!.docs.map((doc) {
              var data = doc.data() as Map<String, dynamic>;
              return Card(
                margin: EdgeInsets.all(10),
                child: ListTile(
                  title: Text(data['teamName'] ?? 'No team name'),
                  subtitle: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text('Captain: ${data['captainName']}'),
                      Text('Game: ${data['game']}'),
                      Text('Payment Status: ${data['paymentStatus']}'),
                    ],
                  ),
                  trailing: data['paymentStatus'] == 'Completed'
                      ? Icon(Icons.check_circle, color: Colors.green)
                      : Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Icon(Icons.error, color: Colors.red),
                            SizedBox(width: 8),
                            ElevatedButton(
                              onPressed: () {
                                _verifyPayment(doc.id, data['captainEmail']);
                              },
                              child: Text('Verify'),
                            ),
                          ],
                        ),
                ),
              );
            }).toList(),
          );
        },
      ),
    );
  }

  // Function to build the query based on filters and sorting
  Stream<QuerySnapshot> _getFilteredAndSortedRegistrations() {
    Query query = FirebaseFirestore.instance.collection('registrations');

    // Apply game filter if selected
    if (selectedGame != null && selectedGame != 'All Games') {
      query = query.where('game', isEqualTo: selectedGame);
    }

    // Apply payment status filter if selected
    if (selectedPaymentStatus != null && selectedPaymentStatus != 'All') {
      query = query.where('paymentStatus', isEqualTo: selectedPaymentStatus);
    }

    // Apply sorting
    if (sortBy == 'Game') {
      query = query.orderBy('game');
    } else if (sortBy == 'Payment Status') {
      query = query.orderBy('paymentStatus');
    }

    return query.snapshots();
  }

  // Function to verify payment status and send email notification
  Future<void> _verifyPayment(String docId, String captainEmail) async {
    try {
      // Update payment status in Firestore
      await FirebaseFirestore.instance
          .collection('registrations')
          .doc(docId)
          .update({
        'paymentStatus': 'Completed'
      }); // Make sure this matches the values in your Firestore

      // Send email notification via Cloud Functions
      await _sendEmailNotification(captainEmail);

      // Show success message
      Fluttertoast.showToast(
          msg: "Payment verified and email sent successfully!",
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.BOTTOM);
    } catch (e) {
      Fluttertoast.showToast(
          msg: "Error verifying payment: $e",
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.BOTTOM);
    }
  }

  // Function to send email notification using Firebase Cloud Functions
  Future<void> _sendEmailNotification(String captainEmail) async {
    await FirebaseFirestore.instance.collection('mail').add({
      'to': captainEmail,
      'message': {
        'subject': 'Payment Verification Successful',
        'text': 'Your registration payment has been verified successfully.',
      },
    });
  }
}
