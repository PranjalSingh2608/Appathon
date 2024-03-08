import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

class StockScreen extends StatefulWidget {
  const StockScreen({Key? key}) : super(key: key);

  @override
  _StockScreenState createState() => _StockScreenState();
}

class _StockScreenState extends State<StockScreen> {
  int totalStock = 0;
  int soldStock = 0;
  int availableStock = 0;
  int monthlyStock = 0;
  List<Map<String, dynamic>> datewiseStock = [];

  @override
  void initState() {
    super.initState();
    fetchData();
  }

  Future<void> fetchData() async {
    await fetchTotalStock();
    await fetchMonthlyStock();
  }

  Future<void> fetchTotalStock() async {
    final prefs = await SharedPreferences.getInstance();
    String number = prefs.getString('phoneNo').toString();
    final apiUrl = 'https://smiling-garment-deer.cyclic.app/stock/$number';

    try {
      final response = await http.get(Uri.parse(apiUrl));

      if (response.statusCode == 200) {
        final dynamic responseData = json.decode(response.body);
        setState(() {
          totalStock = responseData['totalStock'];
          soldStock = responseData['soldStock'];
          availableStock = responseData['availableStock'];
        });
      } else {
        throw Exception('Failed to fetch total stock. Status code: ${response.statusCode}');
      }
    } catch (e) {
      print('Error: $e');
    }
  }

  Future<void> fetchMonthlyStock() async {
    final prefs = await SharedPreferences.getInstance();
    String number = prefs.getString('phoneNo').toString();
    final apiUrl = 'https://smiling-garment-deer.cyclic.app/getQtylastMonth/$number';

    try {
      final response = await http.get(Uri.parse(apiUrl));

      if (response.statusCode == 200) {
        final dynamic responseData = json.decode(response.body);
        setState(() {
          monthlyStock = responseData['totalMilkProduction'];
        });
      } else {
        throw Exception('Failed to fetch monthly stock. Status code: ${response.statusCode}');
      }
    } catch (e) {
      print('Error: $e');
    }
  }

  Future<void> pickDateAndFetchData() async {
    DateTime? pickedDate = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(2000),
      lastDate: DateTime.now(),
    );

    if (pickedDate != null) {
      await fetchDatewiseStock(pickedDate);
    }
  }

  Future<void> fetchDatewiseStock(DateTime date) async {
    final prefs = await SharedPreferences.getInstance();
    String number = prefs.getString('phoneNo').toString();
    final apiUrl = 'https://smiling-garment-deer.cyclic.app/getmilkprodbydate/$number';

    try {
      final response = await http.post(
        Uri.parse(apiUrl),
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode({'date': date.toIso8601String()}),
      );

      if (response.statusCode == 200) {
        final dynamic responseData = json.decode(response.body);
        setState(() {
          datewiseStock = [responseData];
        });
      } else {
        throw Exception('Failed to fetch datewise stock. Status code: ${response.statusCode}');
      }
    } catch (e) {
      print('Error: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Stock Information'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Total Stock: $totalStock'),
            Text('Sold Stock: $soldStock'),
            Text('Available Stock: $availableStock'),
            SizedBox(height: 16),
            Text('Monthly Stock: $monthlyStock'),
            SizedBox(height: 16),
            ElevatedButton(
              onPressed: pickDateAndFetchData,
              child: Text('Choose Date'),
            ),
            SizedBox(height: 16),
            Text('Datewise Stock:'),
            if (datewiseStock.isNotEmpty)
              ...datewiseStock.map(
                (data) => Text('${data['date']}: ${data['totalMilkQuantity']}'),
              ),
          ],
        ),
      ),
    );
  }
}
