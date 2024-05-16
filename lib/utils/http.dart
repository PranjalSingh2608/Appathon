import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

import '../models/Animal_Schema.dart';
import '../models/cattle.dart';
import '../models/milkrecord.dart';

class AuthService {
  final String baseUrl = 'https://appathon.onrender.com';
  Future<bool> registerUser(String username, String otp, String phoneNo) async {
    final url = Uri.parse('$baseUrl/signup');
    print(url);
    final response = await http.post(
      url,
      headers: {'Content-Type': 'application/json'},
      body: json.encode({"username": username, "otp": otp, "phoneNo": phoneNo}),
    );

    if (response.statusCode == 200 || response.statusCode == 201) {
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

  Future<bool> loginUser(String phoneNo) async {
    final url = Uri.parse('$baseUrl/login');
    print(url);
    final response = await http.post(
      url,
      headers: {'Content-Type': 'application/json'},
      body: json.encode({
        "phoneNo": phoneNo,
      }),
    );

    if (response.statusCode == 200 || response.statusCode == 201) {
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

Future<void> registerCattle(Cattle cattle) async {
  final String apiUrl =
      'https://appathon.onrender.com/registerCattle';

  final http.Response response = await http.post(
    Uri.parse(apiUrl),
    headers: <String, String>{
      'Content-Type': 'application/json; charset=UTF-8',
    },
    body: jsonEncode(cattle.toJson()),
  );
  print(cattle.toJson());
  if (response.statusCode == 200 || response.statusCode == 201) {
    print('Cattle registered successfully');
  } else {
    print('Failed to register cattle. Status code: ${response.statusCode}');
    print('Response body: ${response.body}');
  }
}

Future<void> milkrecord(MilkRecord milkrecord) async {
  final prefs = await SharedPreferences.getInstance();
  String number = prefs.getString('phoneNo').toString();
  final String apiUrl =
      'https://appathon.onrender.com/createrecord/$number';

  final http.Response response = await http.post(
    Uri.parse(apiUrl),
    headers: <String, String>{
      'Content-Type': 'application/json; charset=UTF-8',
    },
    body: jsonEncode(milkrecord.toJson()),
  );
  print(jsonEncode(milkrecord));
  if (response.statusCode == 200 || response.statusCode == 201) {
    print('Milk Record registered successfully');
  } else {
    print('Failed to register cattle. Status code: ${response.statusCode}');
    print('Response body: ${response.body}');
  }
}

Future<List<AnimalSchema>> getAnimalsForUserId(String userId) async {
  final apiUrl = 'https://appathon.onrender.com/getanimals/$userId';
  print(userId);
  try {
    final response = await http.get(
      Uri.parse(apiUrl),
      headers: {'Content-Type': 'application/json'},
    );
    print(response.body);

    if (response.statusCode == 200 || response.statusCode == 201) {
      final dynamic jsonData = json.decode(response.body);
      if (jsonData is Map<String, dynamic> &&
          jsonData.containsKey('animalProfiles')) {
        List<AnimalSchema> animals = (jsonData['animalProfiles'] as List)
            .map((json) => AnimalSchema.fromJson(json))
            .toList();
        return animals;
      } else {
        throw Exception('Invalid response format. Expected a List.');
      }
    } else {
      throw Exception('Failed to load animals');
    }
  } catch (e) {
    print('Error: $e');
    throw Exception('Failed to load animals');
  }
}

Future<List<String>> getAnimalIds() async {
  final prefs = await SharedPreferences.getInstance();
  String number = prefs.getString('phoneNo').toString();
  final apiUrl = 'https://appathon.onrender.com/getanimalids/$number';

  final response = await http.get(Uri.parse(apiUrl));

  if (response.statusCode == 200) {
    final List<dynamic> data = json.decode(response.body);
    return data.cast<String>().toList();
  } else {
    throw Exception(
        'Failed to fetch animal IDs. Status code: ${response.statusCode}');
  }
}

Future<String> sendMsg() async {
  final apiUrl = 'https://appathon.onrender.com/sndmsg ';

  final response = await http.get(Uri.parse(apiUrl));

  if (response.statusCode == 200) {
    final data = json.decode(response.body);
    return data.toString();
  } else {
    throw Exception(
        'Failed to send message. Status code: ${response.statusCode}');
  }
}
