import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class EventLeadPage extends StatefulWidget {
  @override
  _EventLeadPageState createState() => _EventLeadPageState();
}

class _EventLeadPageState extends State<EventLeadPage> {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  late Stream<QuerySnapshot> _leaderboardStream;
  late Stream<QuerySnapshot> _matchResultsStream;

  @override
  void initState() {
    super.initState();
    _leaderboardStream = _firestore
        .collection('leaderboard')
        .orderBy('score', descending: true)
        .snapshots();
    _matchResultsStream = _firestore.collection('match_results').snapshots();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: Colors.black), // Back arrow icon
          onPressed: () {
            Navigator.pop(context); // Navigate back
          },
        ),
        backgroundColor: Colors.transparent, // Make background transparent
        elevation: 0, // Remove shadow
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Text(
              'Top 2 Teams',
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
                color: Colors.black, // Text color
              ),
            ),
            SizedBox(height: 16),
            // Display top 2 teams
            StreamBuilder<QuerySnapshot>(
              stream: _leaderboardStream,
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return Center(child: CircularProgressIndicator());
                }
                if (snapshot.hasError) {
                  return Center(child: Text('Error: ${snapshot.error}'));
                }

                final leaderboardDocs = snapshot.data?.docs ?? [];
                leaderboardDocs.sort(
                    (a, b) => (b['score'] as int).compareTo(a['score'] as int));
                final topTeams = leaderboardDocs.take(2).toList();

                return Column(
                  children: topTeams.map((doc) {
                    final data = doc.data() as Map<String, dynamic>;
                    return ListTile(
                      leading: CircleAvatar(
                        child: Text('${topTeams.indexOf(doc) + 1}'),
                        backgroundColor: Colors.black,
                        foregroundColor: Colors.white,
                      ),
                      title: Text(data['name']),
                      trailing: Text('${data['score']}'),
                    );
                  }).toList(),
                );
              },
            ),
            SizedBox(height: 16),
            Text(
              'Match Results',
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
                color: Colors.black, // Text color
              ),
            ),
            SizedBox(height: 16),
            // Display match results and scoreboard
            Expanded(
              child: StreamBuilder<QuerySnapshot>(
                stream: _matchResultsStream,
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return Center(child: CircularProgressIndicator());
                  }
                  if (snapshot.hasError) {
                    return Center(child: Text('Error: ${snapshot.error}'));
                  }

                  final matchResultsDocs = snapshot.data?.docs ?? [];

                  return ListView(
                    children: matchResultsDocs.map((doc) {
                      final match = doc.data() as Map<String, dynamic>;
                      final int score1 = match['score1'] as int;
                      final int score2 = match['score2'] as int;
                      final String highestScoringTeam =
                          (score1 > score2) ? match['team1'] : match['team2'];
                      final int highestScore =
                          (score1 > score2) ? score1 : score2;

                      return Card(
                        margin: EdgeInsets.symmetric(vertical: 8),
                        child: Padding(
                          padding: const EdgeInsets.all(16.0),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text('${match['team1']} vs ${match['team2']}'),
                              SizedBox(height: 8),
                              Row(
                                children: [
                                  Expanded(
                                    child: Row(
                                      children: [
                                        Expanded(
                                          child: TextField(
                                            keyboardType: TextInputType.number,
                                            textAlign: TextAlign.center,
                                            decoration: InputDecoration(
                                              border: OutlineInputBorder(),
                                              hintText:
                                                  'Score ${match['team1']}',
                                            ),
                                            controller: TextEditingController(
                                                text: score1.toString()),
                                            onChanged: (value) {
                                              final newScore1 =
                                                  int.tryParse(value) ?? 0;
                                              _firestore
                                                  .collection('match_results')
                                                  .doc(doc.id)
                                                  .update(
                                                      {'score1': newScore1});
                                            },
                                          ),
                                        ),
                                        IconButton(
                                          icon: Icon(Icons.add),
                                          onPressed: () {
                                            _firestore
                                                .collection('match_results')
                                                .doc(doc.id)
                                                .update({'score1': score1 + 1});
                                          },
                                        ),
                                        IconButton(
                                          icon: Icon(Icons.remove),
                                          onPressed: () {
                                            _firestore
                                                .collection('match_results')
                                                .doc(doc.id)
                                                .update({'score1': score1 - 1});
                                          },
                                        ),
                                      ],
                                    ),
                                  ),
                                  SizedBox(width: 16),
                                  Expanded(
                                    child: Row(
                                      children: [
                                        Expanded(
                                          child: TextField(
                                            keyboardType: TextInputType.number,
                                            textAlign: TextAlign.center,
                                            decoration: InputDecoration(
                                              border: OutlineInputBorder(),
                                              hintText:
                                                  'Score ${match['team2']}',
                                            ),
                                            controller: TextEditingController(
                                                text: score2.toString()),
                                            onChanged: (value) {
                                              final newScore2 =
                                                  int.tryParse(value) ?? 0;
                                              _firestore
                                                  .collection('match_results')
                                                  .doc(doc.id)
                                                  .update(
                                                      {'score2': newScore2});
                                            },
                                          ),
                                        ),
                                        IconButton(
                                          icon: Icon(Icons.add),
                                          onPressed: () {
                                            _firestore
                                                .collection('match_results')
                                                .doc(doc.id)
                                                .update({'score2': score2 + 1});
                                          },
                                        ),
                                        IconButton(
                                          icon: Icon(Icons.remove),
                                          onPressed: () {
                                            _firestore
                                                .collection('match_results')
                                                .doc(doc.id)
                                                .update({'score2': score2 - 1});
                                          },
                                        ),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                              SizedBox(height: 16),
                              Text(
                                'Total Score ${match['team1']}: ${score1}',
                                style: TextStyle(fontWeight: FontWeight.bold),
                              ),
                              Text(
                                'Total Score ${match['team2']}: ${score2}',
                                style: TextStyle(fontWeight: FontWeight.bold),
                              ),
                              SizedBox(height: 8),
                              Text(
                                'Highest Score: $highestScore by $highestScoringTeam',
                                style: TextStyle(fontWeight: FontWeight.bold),
                              ),
                            ],
                          ),
                        ),
                      );
                    }).toList(),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
