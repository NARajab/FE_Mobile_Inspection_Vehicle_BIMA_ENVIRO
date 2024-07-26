import 'package:http/http.dart' as http;
import 'dart:convert';

class KkhServices {
  static const String apiUrl = 'https://672e-116-254-97-119.ngrok-free.app/api/v1/kkh';

  Future<int> getAllKkhLength() async {
    try {
      final response = await http.get(Uri.parse(apiUrl));
      if (response.statusCode == 200) {
        Map<String, dynamic> responseData = jsonDecode(response.body);
        List<dynamic> kkhList = responseData['kkh'];
        return kkhList.length;
      } else {
        throw Exception('Failed to load data');
      }
    } catch (e) {
      throw Exception('Error: $e');
    }
  }
}