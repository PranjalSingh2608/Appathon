import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

import '../utils/colors.dart';

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
        throw Exception(
            'Failed to fetch total stock. Status code: ${response.statusCode}');
      }
    } catch (e) {
      print('Error: $e');
    }
  }

  Future<void> fetchMonthlyStock() async {
    final prefs = await SharedPreferences.getInstance();
    String number = prefs.getString('phoneNo').toString();
    final apiUrl =
        'https://smiling-garment-deer.cyclic.app/getQtylastMonth/$number';

    try {
      final response = await http.get(Uri.parse(apiUrl));

      if (response.statusCode == 200) {
        final dynamic responseData = json.decode(response.body);
        setState(() {
          monthlyStock = responseData['totalMilkProduction'];
        });
      } else {
        throw Exception(
            'Failed to fetch monthly stock. Status code: ${response.statusCode}');
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
      builder: (BuildContext context, Widget? child) {
        return Theme(
          data: ThemeData.light().copyWith(
            colorScheme: ColorScheme.light(
              primary: MyColors.col3, // Change primary color
              onPrimary: MyColors.background, // Change text color on primary
            ),
            buttonTheme: ButtonThemeData(
              textTheme: ButtonTextTheme.primary,
            ),
          ),
          child: child!,
        );
      },
    );

    if (pickedDate != null) {
      await fetchDatewiseStock(pickedDate);
    }
  }

  Future<void> fetchDatewiseStock(DateTime date) async {
    final prefs = await SharedPreferences.getInstance();
    String number = prefs.getString('phoneNo').toString();
    final apiUrl =
        'https://smiling-garment-deer.cyclic.app/getmilkprodbydate/$number';

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
        throw Exception(
            'Failed to fetch datewise stock. Status code: ${response.statusCode}');
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
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Image.asset('assets/images/milk2.png'),
            Divider(),
            Text(
              'Total Stock : $totalStock Litres',
              style: const TextStyle(
                  fontSize: 16,
                  color: Color(0xff181414),
                  fontWeight: FontWeight.w400,
                  fontFamily: 'opensans'),
            ),
            Divider(),
            Text(
              'Sold Stock : $soldStock Litres',
              style: const TextStyle(
                  fontSize: 16,
                  color: Color(0xff181414),
                  fontWeight: FontWeight.w400,
                  fontFamily: 'opensans'),
            ),
            Divider(),
            Text(
              'Available Stock : $availableStock Litres',
              style: const TextStyle(
                  fontSize: 16,
                  color: Color(0xff181414),
                  fontWeight: FontWeight.w400,
                  fontFamily: 'opensans'),
            ),
            Divider(),
            Text(
              'Monthly Stock : $monthlyStock Litres',
              style: const TextStyle(
                  fontSize: 16,
                  color: Color(0xff181414),
                  fontWeight: FontWeight.w400,
                  fontFamily: 'opensans'),
            ),
            Divider(),
            ElevatedButton(
              onPressed: pickDateAndFetchData,
              child: Text('Choose Date'),
              style: ElevatedButton.styleFrom(
                primary: MyColors.col3,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(40.0),
                ),
                elevation: 4,
              ),
            ),
            SizedBox(height: 16),
            Text(
              'Datewise Stock :',
              style: const TextStyle(
                  fontSize: 16,
                  color: Color(0xff181414),
                  fontWeight: FontWeight.w400,
                  fontFamily: 'opensans'),
            ),
            SizedBox(
              height: 10,
            ),
            if (datewiseStock.isNotEmpty)
              ...datewiseStock.map(
                (data) => Text(
                  'Date : ${data['date'].toString().substring(0, 10)}\nMilk Quantity : ${data['totalMilkQuantity']} Litres',
                  style: const TextStyle(
                      fontSize: 16,
                      color: Color(0xff181414),
                      fontWeight: FontWeight.w400,
                      fontFamily: 'opensans'),
                ),
              ),
          ],
        ),
      ),
    );
  }
}
