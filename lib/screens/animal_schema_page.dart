import 'package:flutter/cupertino.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../utils/http.dart';

class AnimalSchemaScreen extends StatefulWidget {
  const AnimalSchemaScreen({super.key});

  @override
  State<AnimalSchemaScreen> createState() => _AnimalSchemaScreenState();
}

class _AnimalSchemaScreenState extends State<AnimalSchemaScreen> {
  @override
  void initState() {
    super.initState();
    fetchData();
  }

  Future<void> fetchData() async {
    try {
      final prefs = await SharedPreferences.getInstance();
      final userId = prefs.getString('phoneNo').toString();;
      final animals = await getAnimalsForUserId(userId);
      print('Received animals: $animals');
    } catch (error) {
      print('Error fetching animals: $error');
    }
  }
  @override
  Widget build(BuildContext context) {
    return const Placeholder();
  }
}