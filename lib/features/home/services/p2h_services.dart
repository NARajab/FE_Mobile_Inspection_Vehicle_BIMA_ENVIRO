import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class P2hServices {
  final String baseUrl = dotenv.env['API_URL']!;

  Future<int> getAllP2hLength() async {
    const String endpoint = '/p2h/all';
    final String apiUrl = '$baseUrl$endpoint';
    try {
      final response = await http.get(Uri.parse(apiUrl));
      if (response.statusCode == 200) {
        Map<String, dynamic> responseData = jsonDecode(response.body);
        List<dynamic> p2hList = responseData['p2h'];
        return p2hList.length;
      } else {
        throw Exception('Failed to load data');
      }
    } catch (e) {
      throw Exception('Error: $e');
    }
  }

  Future<Map<String, dynamic>> getLastP2hByUser(String token) async {
    const String endpoint = '/p2h/last';
    final String apiUrl = '$baseUrl$endpoint';
    try {
      final response = await http.get(
        Uri.parse(apiUrl),
        headers: {
          'Authorization': 'Bearer $token',
        },
      );
      if (response.statusCode == 200) {
        return jsonDecode(response.body);
      } else {
        throw Exception('Failed to load data');
      }
    } catch (e) {
      throw Exception('Error: $e');
    }
  }
}

class FormServices{
  final String baseUrl = dotenv.env['API_URL']!;

   Future<void> submitP2hDt(Map<String, dynamic> requestData, String token) async {
    const String endpoint = '/p2h/dt';
    final String apiUrl = '$baseUrl$endpoint';

    final response = await http.post(
      Uri.parse(apiUrl),
      headers: {
        'Content-Type': 'application/json',
        'Authorization': 'Bearer $token',
      },
      body: jsonEncode(requestData),
    );

    if (response.statusCode == 200) {
      print('Data submitted successfully');
    } else {
      print('Failed to submit data');
    }
  }
}