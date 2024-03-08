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
              child: Image.asset('assets/images/milk0.png'),
            ),
            SizedBox(
              width: 10,
            ),
            Text(
              'Milk Register',
              style: TextStyle(
                  fontFamily: 'Europa', fontSize: 28, color: MyColors.col3),
            ),
          ],
        ),
        backgroundColor: MyColors.background,
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
                            labelStyle: TextStyle(fontSize: 20.0),
                            border: OutlineInputBorder(
                              borderSide: BorderSide(
                                color: MyColors.col2,
                                width: 2,
                              ),
                              borderRadius: BorderRadius.circular(20.0),
                            ),
                          ),
                        ),
                        SizedBox(height: 16),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'Milking Shift',
                              style: TextStyle(fontSize: 18),
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
                                Text(
                                  'Morning',
                                  style: TextStyle(
                                    fontSize: 16,
                                    fontFamily: 'opensans',
                                  ),
                                ),
                                SizedBox(
                                  width: 12,
                                ),
                                Radio<String>(
                                  value: 'Evening',
                                  groupValue: milkingShift,
                                  onChanged: (value) {
                                    setState(() {
                                      milkingShift = value;
                                    });
                                  },
                                ),
                                Text(
                                  'Evening',
                                  style: TextStyle(
                                    fontSize: 16,
                                    fontFamily: 'opensans',
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                        SizedBox(height: 16),
                        TextField(
                          controller: milkQuantityController,
                          decoration: InputDecoration(
                            labelText: 'Milk Quantity (in Ltrs)',
                            labelStyle: TextStyle(fontSize: 20.0),
                            border: OutlineInputBorder(
                              borderSide: BorderSide(
                                color: MyColors.col2,
                                width: 2,
                              ),
                              borderRadius: BorderRadius.circular(20.0),
                            ),
                          ),
                        ),
                        SizedBox(height: 16),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'Abnormal Milk',
                              style: TextStyle(fontSize: 18),
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.start,
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
                                Text(
                                  'Yes',
                                  style: TextStyle(
                                    fontSize: 16,
                                    fontFamily: 'opensans',
                                  ),
                                ),
                                SizedBox(
                                  width: 12,
                                ),
                                Radio<String>(
                                  value: 'No',
                                  groupValue: abnormalmilk,
                                  onChanged: (value) {
                                    setState(() {
                                      abnormalmilk = value;
                                    });
                                  },
                                ),
                                Text(
                                  'No',
                                  style: TextStyle(
                                    fontSize: 16,
                                    fontFamily: 'opensans',
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                        SizedBox(height: 16),
                        TextField(
                          controller: remarksController,
                          decoration: InputDecoration(
                            labelText: 'Additional Remarks',
                            labelStyle: TextStyle(fontSize: 20.0),
                            border: OutlineInputBorder(
                              borderSide: BorderSide(
                                color: MyColors.col3,
                                width: 2,
                              ),
                              borderRadius: BorderRadius.circular(20.0),
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
                              remarks: remarksController.text,
                            );

                            try {
                              await milkrecord(newMilkRecord);
                            } catch (e) {
                              print('Registration error: $e');
                            }
                          },
                          child: Container(
                            width: MediaQuery.of(context).size.width * 0.4,
                            child: Center(
                              child: Text(
                                'Register Milk',
                                style: TextStyle(
                                  fontSize: 16,
                                  color: MyColors.background,
                                ),
                              ),
                            ),
                          ),
                          style: ElevatedButton.styleFrom(
                            primary: MyColors.col3,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(40.0),
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
