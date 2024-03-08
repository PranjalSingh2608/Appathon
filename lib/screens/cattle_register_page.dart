import 'package:appathon/utils/http.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../models/cattle.dart';
import '../utils/colors.dart';

class CattleRegister extends StatefulWidget {
  const CattleRegister({super.key});

  @override
  State<CattleRegister> createState() => _CattleRegisterState();
}

class _CattleRegisterState extends State<CattleRegister> {
  final TextEditingController animalNameController = TextEditingController();
  final TextEditingController animalIdController = TextEditingController();
  final TextEditingController numberOfChildsController =
      TextEditingController();
  final TextEditingController breedController = TextEditingController();
  final TextEditingController animalGenderController = TextEditingController();
  final TextEditingController DOBController = TextEditingController();
  final TextEditingController animalGirthController = TextEditingController();
  final TextEditingController weightController = TextEditingController();
  final TextEditingController pregnancyStatusController =
      TextEditingController();
  final TextEditingController lastCalvingController = TextEditingController();
  final TextEditingController lastDateOfAutoInseminationController =
      TextEditingController();
  final TextEditingController lactationNumberController =
      TextEditingController();
  final TextEditingController currentMilkingStageController =
      TextEditingController();
  String? animalType;
  String? currentMilkingStage;
  String? gender;
  bool isLoading = false;
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
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
                  child: Image.asset('assets/images/cow0.png')),
              SizedBox(
                width: 10,
              ),
              Text(
                'Cattle Register',
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
                    color: MyColors.background,
                    elevation: 4,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20.0),
                    ),
                    margin: EdgeInsets.symmetric(horizontal: 20),
                    child: Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: Column(children: [
                        TextField(
                          controller: animalNameController,
                          decoration: InputDecoration(
                            labelText: 'Animal Name',
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
                        TextField(
                          controller: animalIdController,
                          decoration: InputDecoration(
                            labelText: 'Animal Id',
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
                        TextField(
                          controller: numberOfChildsController,
                          decoration: InputDecoration(
                            labelText: 'Number of Childs',
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
                              'Animal Type',
                              style: TextStyle(fontSize: 16),
                            ),
                            Row(
                              children: [
                                Radio<String>(
                                  value: 'Buffalo',
                                  groupValue: animalType,
                                  onChanged: (value) {
                                    setState(() {
                                      animalType = value;
                                    });
                                  },
                                ),
                                Text('Buffalo'),
                                Radio<String>(
                                  value: 'Cow',
                                  groupValue: animalType,
                                  onChanged: (value) {
                                    setState(() {
                                      animalType = value;
                                    });
                                  },
                                ),
                                Text('Cow'),
                              ],
                            ),
                          ],
                        ),
                        // TextField(
                        //   controller: animalTypeController,
                        //   decoration: InputDecoration(
                        //     labelText: 'Type of Animal',
                        //     border: OutlineInputBorder(
                        //       borderSide: BorderSide(
                        //         color: MyColors.col2,
                        //         width: 2,
                        //       ),
                        //       borderRadius: BorderRadius.circular(30.0),
                        //     ),
                        //   ),
                        // ),
                        SizedBox(height: 16),
                        TextField(
                          controller: breedController,
                          decoration: InputDecoration(
                            labelText: 'Breed',
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
                        // TextField(
                        //   controller: animalGenderController,
                        //   decoration: InputDecoration(
                        //     labelText: 'Animal Gender',
                        //     border: OutlineInputBorder(
                        //       borderSide: BorderSide(
                        //         color: MyColors.col2,
                        //         width: 2,
                        //       ),
                        //       borderRadius: BorderRadius.circular(30.0),
                        //     ),
                        //   ),
                        // ),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'Animal Gender',
                              style: TextStyle(fontSize: 16),
                            ),
                            Row(
                              children: [
                                Radio<String>(
                                  value: 'Male',
                                  groupValue: gender,
                                  onChanged: (value) {
                                    setState(() {
                                      gender = value;
                                    });
                                  },
                                ),
                                Text('Male'),
                                Radio<String>(
                                  value: 'Female',
                                  groupValue: gender,
                                  onChanged: (value) {
                                    setState(() {
                                      gender = value;
                                    });
                                  },
                                ),
                                Text('Female'),
                              ],
                            ),
                          ],
                        ),
                        SizedBox(height: 16),
                        TextField(
                          controller: DOBController,
                          decoration: InputDecoration(
                            labelText: 'Animal DOB',
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
                        TextField(
                          controller: animalGirthController,
                          decoration: InputDecoration(
                            labelText: 'Girth of Animal',
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
                        TextField(
                          controller: weightController,
                          decoration: InputDecoration(
                            labelText: 'Animal Weight',
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
                        TextField(
                          controller: pregnancyStatusController,
                          decoration: InputDecoration(
                            labelText: 'Pregnancy Status',
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
                        TextField(
                          controller: lastCalvingController,
                          decoration: InputDecoration(
                            labelText: 'Last Calving',
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
                        TextField(
                          controller: lastDateOfAutoInseminationController,
                          decoration: InputDecoration(
                            labelText: 'Last Date of Auto Insemination',
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
                        TextField(
                          controller: lactationNumberController,
                          decoration: InputDecoration(
                            labelText: 'Lactation Number',
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
                        // TextField(
                        //   controller: currentMilkingStageController,
                        //   decoration: InputDecoration(
                        //     labelText: 'Current Milking Stage',
                        //     border: OutlineInputBorder(
                        //       borderSide: BorderSide(
                        //         color: MyColors.col2,
                        //         width: 2,
                        //       ),
                        //       borderRadius: BorderRadius.circular(30.0),
                        //     ),
                        //   ),
                        // ),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'Animal Type',
                              style: TextStyle(fontSize: 16),
                            ),
                            Row(
                              children: [
                                Radio<String>(
                                  value: 'Milking',
                                  groupValue: currentMilkingStage,
                                  onChanged: (value) {
                                    setState(() {
                                      currentMilkingStage = value;
                                    });
                                  },
                                ),
                                Text('Milking'),
                                Radio<String>(
                                  value: 'Dry',
                                  groupValue: currentMilkingStage,
                                  onChanged: (value) {
                                    setState(() {
                                      currentMilkingStage = value;
                                    });
                                  },
                                ),
                                Text('Dry'),
                              ],
                            ),
                          ],
                        ),
                        SizedBox(height: 16),
                        ElevatedButton(
                          onPressed: () async {
                            final prefs = await SharedPreferences.getInstance();
                            String number =
                                prefs.getString('phoneNo').toString();
                            Cattle newCattle = Cattle(
                              userId: number,
                              animalName: animalNameController.text,
                              animalId: animalIdController.text,
                              numberOfChilds:
                                  int.parse(numberOfChildsController.text),
                              animalType: animalType.toString(),
                              breed: breedController.text,
                              animalGender: gender.toString(),
                              DOB: DOBController.text,
                              animalGirth:
                                  double.parse(animalGirthController.text),
                              weight: double.parse(weightController.text),
                              pregnancyStatus: pregnancyStatusController.text,
                              lastCalving: lastCalvingController.text,
                              lastDateOfAutoInsemination:
                                  lastDateOfAutoInseminationController.text,
                              lactationNumber:
                                  int.parse(lactationNumberController.text),
                              currentMilkingStage:
                                  currentMilkingStage.toString(),
                            );
                            try {
                              await registerCattle(newCattle);
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
                      ]),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
