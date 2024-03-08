import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../utils/colors.dart';
import 'package:http/http.dart' as http;
import 'package:flutter_tts/flutter_tts.dart';
import '../utils/http.dart';

enum Language { Hindi, English, Telugu }

class AnimalSchemaScreen extends StatefulWidget {
  const AnimalSchemaScreen({super.key});

  @override
  State<AnimalSchemaScreen> createState() => _AnimalSchemaScreenState();
}

class _AnimalSchemaScreenState extends State<AnimalSchemaScreen> {
  Language _selectedLanguage = Language.English;
  FlutterTts flutterTts = FlutterTts();

  Future<void> _speakText(String text, String languageCode) async {
    await flutterTts.setLanguage(languageCode);
    await flutterTts.setPitch(1);
    await flutterTts.speak(text);
    await flutterTts.setSpeechRate(0.5);
  }

  @override
  void initState() {
    super.initState();
    fetchData();
  }

  List animalsData = [];
  Future<Map<String, dynamic>> fetchMilkProduction(String animalId) async {
    try {
      final prefs = await SharedPreferences.getInstance();
      String number = prefs.getString('phoneNo').toString();
      final apiUrl =
          'https://smiling-garment-deer.cyclic.app/getmilkprodbyId/$number';
      final http.Response response = await http.post(
        Uri.parse(apiUrl),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        },
        body: jsonEncode({'animalId': animalId}),
      );

      if (response.statusCode == 200) {
        final dynamic responseData = jsonDecode(response.body);
        print(responseData);
        return responseData;
      } else {
        throw Exception(
            'Failed to fetch milk production. Status code: ${response.statusCode}');
      }
    } catch (e) {
      print('Error: $e');
      throw e;
    }
  }

  Future<void> fetchData() async {
    try {
      final prefs = await SharedPreferences.getInstance();
      final userId = prefs.getString('phoneNo').toString();
      final animals = await getAnimalsForUserId(userId);
      print('Received animals: $animals');
      setState(() {
        print(animals[0].breed);
        animalsData = animals;
      });
    } catch (error) {
      print('Error fetching animals: $error');
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
                child: Image.asset('assets/images/cow1.png')),
            SizedBox(
              width: 10,
            ),
            Text(
              'Cattle Archives',
              style: TextStyle(
                  fontFamily: 'Europa', fontSize: 28, color: MyColors.col3),
            ),
          ],
        ),
        backgroundColor: MyColors.background,
      ),
      body: Padding(
        padding: const EdgeInsets.only(top: 8.0),
        child: ListView.builder(
          itemCount: animalsData.length,
          itemBuilder: (context, index) {
            final animal = animalsData[index];
            return Padding(
              padding: const EdgeInsets.only(
                left: 12,
                right: 12,
              ),
              child: Card(
                child: ListTile(
                  leading: Container(
                    // width: 40,
                    // height: 40,
                    child: Image.asset(
                      'assets/images/cow1.png',
                      scale: 0.1,
                      fit: BoxFit.contain,
                    ),
                  ),
                  title: Text('Cattle ID - ${animal.animalId}'),
                  subtitle: Text(
                    'Cattle Type - ${animal.animalType}',
                    style: TextStyle(fontFamily: 'couture'),
                  ),
                  onTap: () {
                    showDialog(
                      context: context,
                      builder: (context) {
                        return AlertDialog(
                          backgroundColor: MyColors.background,
                          title: Text(
                            'Cattle: ${animal.animalId}',
                            style: const TextStyle(
                                color: Color(0xff181414),
                                fontFamily: 'couture'),
                          ),
                          content: SingleChildScrollView(
                            child: Container(
                              // height: MediaQuery.of(context).size.height * 0.2,
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.start,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  FutureBuilder<Map<String, dynamic>>(
                                    future:
                                        fetchMilkProduction(animal.animalId),
                                    builder: (context, snapshot) {
                                      if (snapshot.connectionState ==
                                          ConnectionState.waiting) {
                                        return Center(
                                            child: CircularProgressIndicator());
                                      } else if (snapshot.hasError) {
                                        return Text('Error: ${snapshot.error}');
                                      } else {
                                        var totalMilkQuantity =
                                            snapshot.data!['totalMilkQuantity'];
                                        return Column(
                                          mainAxisAlignment:
                                              MainAxisAlignment.start,
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Text(
                                              'Age : ${(animal.age).toString()} years',
                                              style: const TextStyle(
                                                  color: Color(0xff181414),
                                                  fontFamily: 'opensans'),
                                            ),
                                            Text(
                                              'Type : ${(animal.animalType).toString()}',
                                              style: const TextStyle(
                                                  color: Color(0xff181414),
                                                  fontFamily: 'opensans'),
                                            ),
                                            Text(
                                              'Breed : ${(animal.breed).toString()}',
                                              style: const TextStyle(
                                                  color: Color(0xff181414),
                                                  fontFamily: 'opensans'),
                                            ),
                                            Text(
                                              'Gender : ${(animal.animalGender).toString()}',
                                              style: const TextStyle(
                                                  color: Color(0xff181414),
                                                  fontFamily: 'opensans'),
                                            ),
                                            Text(
                                              'Weight : ${(animal.weight).toString()} kgs',
                                              style: const TextStyle(
                                                  color: Color(0xff181414),
                                                  fontFamily: 'opensans'),
                                            ),
                                            Text(
                                              'Milk Given : $totalMilkQuantity L',
                                              style: const TextStyle(
                                                color: Color(0xff181414),
                                                fontFamily: 'opensans',
                                              ),
                                            ),
                                            SizedBox(
                                              height: 16,
                                            ),
                                            Column(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.center,
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.center,
                                              children: [
                                                SizedBox(
                                                  width: MediaQuery.of(context)
                                                          .size
                                                          .width *
                                                      0.4,
                                                  child: ElevatedButton(
                                                    style: ElevatedButton
                                                        .styleFrom(
                                                      backgroundColor:
                                                          MyColors.col3,
                                                    ),
                                                    onPressed: () {
                                                      setState(() {
                                                        switch (
                                                            _selectedLanguage) {
                                                          case Language.Hindi:
                                                            _selectedLanguage =
                                                                Language
                                                                    .English;
                                                            break;
                                                          case Language.English:
                                                            _selectedLanguage =
                                                                Language.Telugu;
                                                            break;
                                                          case Language.Telugu:
                                                            _selectedLanguage =
                                                                Language.Hindi;
                                                            break;
                                                        }
                                                      });
                                                    },
                                                    child: Text(
                                                      _selectedLanguage ==
                                                              Language.Hindi
                                                          ? 'हिंदी'
                                                          : _selectedLanguage ==
                                                                  Language
                                                                      .English
                                                              ? 'English'
                                                              : 'తెలుగులో',
                                                      style: TextStyle(
                                                          fontSize: 20),
                                                    ),
                                                  ),
                                                ),
                                                // SizedBox(height: 20),
                                                SizedBox(
                                                  width: MediaQuery.of(context)
                                                          .size
                                                          .width *
                                                      0.4,
                                                  child: ElevatedButton(
                                                    style: ElevatedButton
                                                        .styleFrom(
                                                      backgroundColor:
                                                          MyColors.col3,
                                                    ),
                                                    onPressed: () {
                                                      String textToSpeak = '';
                                                      switch (
                                                          _selectedLanguage) {
                                                        case Language.Hindi:
                                                          textToSpeak =
                                                              'पशु ${animal.animalId}, पशु ${animal.age} वर्ष का है, पशु का प्रकार ${animal.animalType} है, प्रजाति ${animal.breed} है, लिंग ${animal.animalGender} है, पशु का वजन ${animal.weight} है, इस समय तक पशु द्वारा कुल दूध दिया गया है ${totalMilkQuantity} लीटर।';
                                                          break;
                                                        case Language.English:
                                                          textToSpeak =
                                                              'For Cattle ${animal.animalId}, The Cattle is ${animal.age} years old, The Cattle Type is ${animal.animalType}, The Breed is ${animal.breed}, The Gender is ${animal.animalGender}, Weight of the cattle is ${animal.weight}, The total Milk given by the cattle till date is ${totalMilkQuantity} litres.';
                                                          break;
                                                        case Language.Telugu:
                                                          textToSpeak =
                                                              'పశు ${animal.animalId}, పశు ${animal.age} సంవత్సరాల పశు, పశు రకం ${animal.animalType}, పెద ${animal.breed}, జెండర్ ${animal.animalGender}, పశు బరువు ${animal.weight}, పేరు కులంలో పశు అందించిన మొత్తం పాలు ${totalMilkQuantity} లీటర్లు.';
                                                          break;
                                                      }
                                                      _speakText(
                                                          textToSpeak,
                                                          _selectedLanguage
                                                              .toString()
                                                              .split('.')[1]);
                                                    },
                                                    child: Text(
                                                      'Listen',
                                                      style: TextStyle(
                                                          fontSize: 20),
                                                    ),
                                                  ),
                                                ),
                                              ],
                                            )
                                          ],
                                        );
                                      }
                                    },
                                  ),
                                ],
                              ),
                            ),
                          ),
                          actions: <Widget>[
                            TextButton(
                              onPressed: () {
                                Navigator.of(context).pop(); // Close the dialog
                              },
                              child: Text(
                                'Go Back',
                                style: TextStyle(color: MyColors.col2),
                              ),
                            ),
                          ],
                        );
                      },
                    );
                  },
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}
