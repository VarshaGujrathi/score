import 'package:flutter/material.dart';

class EventLeadPage extends StatefulWidget {
  @override
  _EventLeadPageState createState() => _EventLeadPageState();
}

class _EventLeadPageState extends State<EventLeadPage> {
  // Sample leaderboard data with editable scores
  final List<Map<String, dynamic>> leaderboardData = [
    {'name': 'Team A', 'score': 1500},
    {'name': 'Team B', 'score': 1450},
    {'name': 'Team C', 'score': 1400},
    {'name': 'Team D', 'score': 1300},
    // Add more leaderboard data here
  ];

  // Sample match results
  final List<Map<String, dynamic>> matchResults = [
    {'team1': 'Team A', 'team2': 'Team B', 'score1': 0, 'score2': 0},
    // Add more match results here
  ];

  @override
  Widget build(BuildContext context) {
    // Sort teams by score in descending order and take the top 2
    leaderboardData.sort((a, b) => b['score'].compareTo(a['score']));
    final topTeams = leaderboardData.take(2).toList();

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
            Column(
              children: topTeams.map((data) {
                return ListTile(
                  leading: CircleAvatar(
                    child: Text('${topTeams.indexOf(data) + 1}'),
                    backgroundColor: Colors.black,
                    foregroundColor: Colors.white,
                  ),
                  title: Text(data['name']),
                  trailing: Text('${data['score']}'),
                );
              }).toList(),
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
              child: ListView(
                children: matchResults.map((match) {
                  final int score1 = match['score1'] as int;
                  final int score2 = match['score2'] as int;
                  final String highestScoringTeam = (score1 > score2) ? match['team1'] : match['team2'];
                  final int highestScore = (score1 > score2) ? score1 : score2;

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
                                          hintText: 'Score ${match['team1']}',
                                        ),
                                        onChanged: (value) {
                                          setState(() {
                                            match['score1'] = int.tryParse(value) ?? 0;
                                          });
                                        },
                                      ),
                                    ),
                                    IconButton(
                                      icon: Icon(Icons.add),
                                      onPressed: () {
                                        setState(() {
                                          match['score1'] = (match['score1'] as int) + 1;
                                        });
                                      },
                                    ),
                                    IconButton(
                                      icon: Icon(Icons.remove),
                                      onPressed: () {
                                        setState(() {
                                          match['score1'] = (match['score1'] as int) - 1;
                                        });
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
                                          hintText: 'Score ${match['team2']}',
                                        ),
                                        onChanged: (value) {
                                          setState(() {
                                            match['score2'] = int.tryParse(value) ?? 0;
                                          });
                                        },
                                      ),
                                    ),
                                    IconButton(
                                      icon: Icon(Icons.add),
                                      onPressed: () {
                                        setState(() {
                                          match['score2'] = (match['score2'] as int) + 1;
                                        });
                                      },
                                    ),
                                    IconButton(
                                      icon: Icon(Icons.remove),
                                      onPressed: () {
                                        setState(() {
                                          match['score2'] = (match['score2'] as int) - 1;
                                        });
                                      },
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                          SizedBox(height: 16),
                          // Display scores for both teams
                          Text(
                            'Total Score ${match['team1']}: ${match['score1']}',
                            style: TextStyle(fontWeight: FontWeight.bold),
                          ),
                          Text(
                            'Total Score ${match['team2']}: ${match['score2']}',
                            style: TextStyle(fontWeight: FontWeight.bold),
                          ),
                          SizedBox(height: 8),
                          // Display highest score and team name
                          Text(
                            'Highest Score: $highestScore by $highestScoringTeam',
                            style: TextStyle(fontWeight: FontWeight.bold),
                          ),
                        ],
                      ),
                    ),
                  );
                }).toList(),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
