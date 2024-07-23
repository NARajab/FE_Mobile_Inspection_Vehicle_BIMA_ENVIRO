import 'package:http/http.dart' as http;
import 'dart:convert';

class AuthService {
  static const String apiUrl = 'https://d9d0-114-122-199-254.ngrok-free.app/api/v1/auth/login';

  Future<Map<String, dynamic>> login(String username, String password) async {
    final response = await http.post(
      Uri.parse(apiUrl),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(<String, String>{
        'username': username,
        'password': password,
      }),
    );

    // Error handling based on status code
    if (response.statusCode == 200) {
      final Map<String, dynamic> data = jsonDecode(response.body);
      return data;
    } else if (response.statusCode == 400) {
      throw Exception('Bad request: ${response.body}');
    } else if (response.statusCode == 401) {
      throw Exception('Unauthorized: ${response.body}');
    } else if (response.statusCode == 500) {
      throw Exception('Server error: ${response.body}');
    } else {
      throw Exception('Failed to login. Status code: ${response.statusCode}');
    }
  }
}


class RegisterService {
  static const String apiUrl = 'https://d9d0-114-122-199-254.ngrok-free.app/api/v1/auth/register-member';
  Future<Map<String, dynamic>> register(String username, String email, String password, String phoneNumber, String role) async {
    final response  = await http.post(
      Uri.parse(apiUrl),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(<String, String>{
        'username': username,
        'email': email,
        'password': password,
        'phoneNumber': phoneNumber,
        'role': role
      })
    );

    if(response.statusCode == 200){
      final Map<String, dynamic> data = jsonDecode(response.body);
      return data;
    } else {
      throw Exception('Failed to register');
    }
  }
}
