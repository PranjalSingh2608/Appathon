import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../utils/colors.dart';

class AlertProdScreen extends StatefulWidget {
  const AlertProdScreen({super.key});

  @override
  State<AlertProdScreen> createState() => _AlertProdScreenState();
}

class _AlertProdScreenState extends State<AlertProdScreen> {
  List<Map<String, dynamic>> alertProducts = [];

  @override
  void initState() {
    super.initState();
    fetchAlertProducts();
  }

  Future<void> fetchAlertProducts() async {
    try {
      final prefs = await SharedPreferences.getInstance();
      String number = prefs.getString('phoneNo').toString();
      final apiUrl =
          'https://smiling-garment-deer.cyclic.app/alertprod/$number';
      final response = await http.get(Uri.parse(apiUrl));

      if (response.statusCode == 200) {
        final dynamic responseData = jsonDecode(response.body);
        final List<dynamic> oldProducts = responseData['oldProducts'];

        setState(() {
          alertProducts = oldProducts
              .map((product) => {
                    'animalIdentificationNumber':
                        product['animalIdentificationNumber'],
                    'milkingDate': product['milkingDate'],
                  })
              .toList();
        });
      } else {
        throw Exception('Failed to fetch alert products. '
            'Status code: ${response.statusCode}');
      }
    } catch (e) {
      print('Error: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: MyColors.background,
      appBar: AppBar(
        titleSpacing: 0.0,
        iconTheme: IconThemeData(
          color: MyColors.col3,
          size: 40,
        ),
        title: Row(
          children: [
            Container(
                width: 35,
                height: 35,
                child: Image.asset('assets/images/milk1.png')),
            SizedBox(
              width: 10,
            ),
            Text(
              'Milk Record',
              style: TextStyle(
                  fontFamily: 'Europa', fontSize: 28, color: MyColors.col3),
            ),
          ],
        ),
        backgroundColor: MyColors.background,
      ),
      body: ListView.builder(
        itemCount: alertProducts.length,
        itemBuilder: (context, index) {
          final product = alertProducts[index];
          return ListTile(
            title: Text(
              'Animal ID: ${product['animalIdentificationNumber']}',
            ),
            subtitle: Text('Milking Date: ${product['milkingDate']}'),
          );
        },
      ),
    );
  }
}
