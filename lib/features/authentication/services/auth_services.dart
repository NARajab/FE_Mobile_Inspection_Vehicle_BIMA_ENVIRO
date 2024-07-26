import 'package:http/http.dart' as http;
import 'dart:convert';

class AuthService {
  static const String apiUrl = 'https://672e-116-254-97-119.ngrok-free.app/api/v1/auth/login';

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

    final Map<String, dynamic> data = jsonDecode(response.body);

    if (response.statusCode == 201) {
      return data;
    } else {
      return data;
    }
  }
}


class RegisterService {
  static const String apiUrl = 'https://672e-116-254-97-119.ngrok-free.app/api/v1/auth/register-member';
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

    if(response.statusCode == 201){
      final Map<String, dynamic> data = jsonDecode(response.body);
      return data;
    } else {
      throw Exception('Failed to register');
    }
  }
}

class SendEmailService {
  static const String apiUrl = 'https://672e-116-254-97-119.ngrok-free.app/api/v1/auth/send-email';
  Future<Map<String, dynamic>> sendmail(String email) async {
    final response = await http.post(
      Uri.parse(apiUrl),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8'
      },
      body: jsonEncode(<String, String>{
        'email': email
      })
    );

    final Map<String, dynamic> data = jsonDecode(response.body);

    if (response.statusCode == 201) {
      return data;
    } else {
      return data;
    }
  }
}
