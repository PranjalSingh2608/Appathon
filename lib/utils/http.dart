import 'dart:convert';

import 'package:http/http.dart' as http;

class AuthService {
  final String baseUrl = 'https://smiling-garment-deer.cyclic.app';
  Future<bool> registerUser(
      String username, String otp, String phoneNo) async {
    final url = Uri.parse('$baseUrl/signup');
    print(url);
    final response = await http.post(
      url,
      headers: {'Content-Type': 'application/json'},
      body: json.encode({
        "username": username,
        "otp": otp,
        "phoneNo": phoneNo
      }),
    );

    if (response.statusCode == 200||response.statusCode==201) {
      print("success");
      return true;
    } else if (response.statusCode == 400) {
      final Map<String, dynamic> responseData = json.decode(response.body);
      final String errorMessage =
          responseData['error'] ?? 'Registration failed.';
      throw Exception(errorMessage);
    } else {
      print(response.statusCode);
      throw Exception('Registration failed.');
    }
  }
  Future<bool> loginUser(
      String phoneNo) async {
    final url = Uri.parse('$baseUrl/login');
    print(url);
    final response = await http.post(
      url,
      headers: {'Content-Type': 'application/json'},
      body: json.encode({
        "phoneNo": phoneNo,
      }),
    );

    if (response.statusCode == 200||response.statusCode==201) {
      print("success");
      return true;
    } else if (response.statusCode == 400) {
      final Map<String, dynamic> responseData = json.decode(response.body);
      final String errorMessage =
          responseData['error'] ?? 'Registration failed.';
      throw Exception(errorMessage);
    } else {
      print(response.statusCode);
      throw Exception('Registration failed.');
    }
  }
}
