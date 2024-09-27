import 'dart:convert';
import 'package:http/http.dart' as http;

// Replace with your actual backend URL
const String backendUrl = 'https://example.com/api/user';

// Function to fetch user details from the backend
Future<Map<String, String>> fetchUserDetails() async {
  try {
    final response = await http.get(Uri.parse(backendUrl));
    
    if (response.statusCode == 200) {
      final data = json.decode(response.body);
      return {
        'name': data['name'] ?? 'N/A',
        'email': data['email'] ?? 'N/A',
        // Add more fields as needed
      };
    } else {
      throw Exception('Failed to load user details');
    }
  } catch (e) {
    print('Error fetching user details: $e');
    return {
      'name': 'Error',
      'email': 'Error',
    };
  }
}
