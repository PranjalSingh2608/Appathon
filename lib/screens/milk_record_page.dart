import 'package:appathon/utils/http.dart';
import 'package:flutter/material.dart';

import '../models/milkrecord.dart';
import '../utils/colors.dart';

class MilkRecordScreen extends StatefulWidget {
  const MilkRecordScreen({super.key});

  @override
  State<MilkRecordScreen> createState() => _MilkRecordScreenState();
}

class _MilkRecordScreenState extends State<MilkRecordScreen> {
  String? milkingShift;
  String? abnormalmilk;
  final TextEditingController animalIdentificationNumberController =
      TextEditingController();
  final TextEditingController milkQuantityController = TextEditingController();
  final TextEditingController remarksController =
      TextEditingController(text: "none");
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Milk Record',
          style: TextStyle(
            fontFamily: 'Europa',
            fontSize: 32,
          ),
        ),
        backgroundColor: MyColors.col3,
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Card(
                  color: Theme.of(context).backgroundColor.withOpacity(0.95),
                  elevation: 4,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20.0),
                  ),
                  margin: EdgeInsets.symmetric(horizontal: 20),
                  child: Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Column(
                      children: [
                        TextField(
                          controller: animalIdentificationNumberController,
                          decoration: InputDecoration(
                            labelText: 'Animal Identification Number',
                            border: OutlineInputBorder(
                              borderSide: BorderSide(
                                color: MyColors.col2,
                                width: 2,
                              ),
                              borderRadius: BorderRadius.circular(30.0),
                            ),
                          ),
                        ),
                        SizedBox(height: 16),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'Milking Shift',
                              style: TextStyle(fontSize: 16),
                            ),
                            Row(
                              children: [
                                Radio<String>(
                                  value: 'Morning',
                                  groupValue: milkingShift,
                                  onChanged: (value) {
                                    setState(() {
                                      milkingShift = value;
                                    });
                                  },
                                ),
                                Text('Morning'),
                                Radio<String>(
                                  value: 'Evening',
                                  groupValue: milkingShift,
                                  onChanged: (value) {
                                    setState(() {
                                      milkingShift = value;
                                    });
                                  },
                                ),
                                Text('Evening'),
                              ],
                            ),
                          ],
                        ),
                        SizedBox(height: 16),
                        TextField(
                          controller: milkQuantityController,
                          decoration: InputDecoration(
                            labelText: 'Milk Quantity(in Ltrs)',
                            border: OutlineInputBorder(
                              borderSide: BorderSide(
                                color: MyColors.col2,
                                width: 2,
                              ),
                              borderRadius: BorderRadius.circular(30.0),
                            ),
                          ),
                        ),
                        SizedBox(height: 16),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'Abnormal Milk',
                              style: TextStyle(fontSize: 16),
                            ),
                            Row(
                              children: [
                                Radio<String>(
                                  value: 'Yes',
                                  groupValue: abnormalmilk,
                                  onChanged: (value) {
                                    setState(() {
                                      abnormalmilk = value;
                                    });
                                  },
                                ),
                                Text('Yes'),
                                Radio<String>(
                                  value: 'No',
                                  groupValue: abnormalmilk,
                                  onChanged: (value) {
                                    setState(() {
                                      abnormalmilk = value;
                                    });
                                  },
                                ),
                                Text('No'),
                              ],
                            ),
                          ],
                        ),
                        SizedBox(height: 16),
                        TextField(
                          controller: remarksController,
                          decoration: InputDecoration(
                            labelText: 'Additional Remarks',
                            border: OutlineInputBorder(
                              borderSide: BorderSide(
                                color: MyColors.col2,
                                width: 2,
                              ),
                              borderRadius: BorderRadius.circular(30.0),
                            ),
                          ),
                        ),
                        SizedBox(height: 16),
                        ElevatedButton(
                          onPressed: () async {
                            MilkRecord newMilkRecord = MilkRecord(
                              animalIdentificationNumber:
                                  animalIdentificationNumberController.text,
                              milkingShift: milkingShift ?? '',
                              milkQuantity:
                                  double.parse(milkQuantityController.text),
                              abnormalMilk: abnormalmilk ?? '',
                              remarks: remarksController.text ?? "none",
                            );

                            try {
                              await milkrecord(newMilkRecord);
                            } catch (e) {
                              print('Registration error: $e');
                            }
                          },
                          child: Container(
                            width: MediaQuery.of(context).size.width / 2,
                            padding: EdgeInsets.symmetric(vertical: 16),
                            child: Center(
                              child: Text(
                                'Register',
                                style: TextStyle(
                                  fontSize: 18,
                                  color: Colors.white,
                                ),
                              ),
                            ),
                          ),
                          style: ElevatedButton.styleFrom(
                            primary: MyColors.col2,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(30.0),
                            ),
                            elevation: 4,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
