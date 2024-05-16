import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../utils/colors.dart';

class QnAPage extends StatefulWidget {
  const QnAPage({super.key});

  @override
  State<QnAPage> createState() => _QnAPageState();
}

class _QnAPageState extends State<QnAPage> {
  TextEditingController newQuestionController = TextEditingController();
  List<dynamic> qnaList = [];
  @override
  void initState() {
    super.initState();
    fetchQnAData();
  }

  Future<void> showAnswerDialog(String questionId) async {
    String answer = '';

    await showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          backgroundColor: MyColors.background,
          title: Text(
            'Post Answer',
            style: TextStyle(fontFamily: 'Couture'),
          ),
          content: TextFormField(
            onChanged: (value) {
              answer = value;
            },
            decoration: InputDecoration(
              hintText: 'Write your answer here.',
            ),
          ),
          actions: <Widget>[
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: Text(
                'Cancel',
                style: TextStyle(fontFamily: 'opensans', color: MyColors.col2),
              ),
            ),
            SizedBox(
              width: MediaQuery.of(context).size.width * 0.4,
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: MyColors.col3,
                ),
                onPressed: () async {
                  await postAnswer(questionId, answer);
                  Navigator.of(context).pop();
                  fetchQnAData(); // Refresh after posting an answer
                },
                child: const Text(
                  'Post Answer',
                  style: TextStyle(
                    fontFamily: 'OpenSans',
                    fontWeight: FontWeight.bold,
                    fontSize: 16,
                  ),
                ),
              ),
            ),
          ],
        );
      },
    );
  }

  Future<void> fetchQnAData() async {
    final apiUrl = 'https://appathon.onrender.com/getallqna';

    try {
      final response = await http.get(Uri.parse(apiUrl));

      if (response.statusCode == 200) {
        final dynamic responseData = jsonDecode(response.body);
        setState(() {
          qnaList = responseData['qna'];
        });
        print(qnaList);
      } else {
        throw Exception(
            'Failed to fetch QnA. Status code: ${response.statusCode}');
      }
    } catch (e) {
      print('Error: $e');
    }
  }

  Future<void> postAnswer(String questionId, String answer) async {
    final apiUrl = 'https://appathon.onrender.com/postAnswer';
    final prefs = await SharedPreferences.getInstance();
    String number = prefs.getString('phoneNo').toString();
    try {
      final response = await http.post(
        Uri.parse(apiUrl),
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode({
          'questionId': questionId,
          'answer': answer,
          'answerer': '$number',
        }),
      );

      if (response.statusCode == 200) {
        final dynamic responseData = json.decode(response.body);
        print('Answer posted successfully: $responseData');
      } else {
        throw Exception(
            'Failed to post answer. Status code: ${response.statusCode}');
      }
    } catch (e) {
      print('Error: $e');
    }
  }

  Future<void> postQuestion(String question) async {
    final apiUrl = 'https://appathon.onrender.com/questionpost';
    final prefs = await SharedPreferences.getInstance();
    String number = prefs.getString('phoneNo').toString();
    try {
      final response = await http.post(
        Uri.parse(apiUrl),
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode({'question': question, 'qasker': '$number'}),
      );

      if (response.statusCode == 200 || response.statusCode == 201) {
        final dynamic responseData = json.decode(response.body);
        print('Question posted successfully: $responseData');
      } else {
        throw Exception(
            'Failed to post question. Status code: ${response.statusCode}');
      }
    } catch (e) {
      print('Error: $e');
    }
  }

  Future<void> showQuestionDialog() async {
    await showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          backgroundColor: MyColors.background,
          title: Text(
            'Post Question',
            style: TextStyle(fontFamily: 'Couture'),
          ),
          content: TextFormField(
            controller: newQuestionController,
            decoration: InputDecoration(
              hintText: 'Write your question here.',
            ),
          ),
          actions: <Widget>[
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: Text(
                'Cancel',
                style: TextStyle(fontFamily: 'opensans', color: MyColors.col2),
              ),
            ),
            SizedBox(
              width: MediaQuery.of(context).size.width * 0.4,
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: MyColors.col3,
                ),
                onPressed: () async {
                  await postQuestion(newQuestionController.text.toString());
                  Navigator.of(context).pop();
                  fetchQnAData();
                },
                child: const Text(
                  'Post Question',
                  style: TextStyle(
                    fontFamily: 'OpenSans',
                    fontWeight: FontWeight.bold,
                    fontSize: 16,
                  ),
                ),
              ),
            ),
          ],
        );
      },
    );
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
                child: Image.asset('assets/images/qna0.png')),
            SizedBox(
              width: 10,
            ),
            Text(
              'Community',
              style: TextStyle(
                  fontFamily: 'Europa', fontSize: 28, color: MyColors.col3),
            ),
          ],
        ),
        backgroundColor: MyColors.background,
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          showQuestionDialog();
        },
        backgroundColor: MyColors.col3,
        child: Container(
            height: 40,
            width: 40,
            child: Image.asset('assets/images/qna1.png')),
      ),
      body: Padding(
        padding: const EdgeInsets.only(top: 8.0),
        child: ListView.builder(
          itemCount: qnaList.length,
          itemBuilder: (context, index) {
            final qna = qnaList[index];
            final question = qna['question'];
            final qasker = qna['qasker'];
            final answer = qna['answer'];

            return InkWell(
              onTap: () {
                showDialog(
                  context: context,
                  builder: (context) {
                    return AlertDialog(
                      backgroundColor: MyColors.background,
                      title: Text(
                        'Details',
                        style: const TextStyle(
                            color: Color(0xff181414), fontFamily: 'couture'),
                      ),
                      content: SingleChildScrollView(
                        child: Container(
                          // height: MediaQuery.of(context).size.height * 0.2,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              Text(
                                question,
                                style: const TextStyle(
                                    color: Color(0xff181414),
                                    fontFamily: 'opensans'),
                              ),
                              if (answer != "")
                                Text(
                                  'Answer: $answer',
                                  style: TextStyle(
                                    fontFamily: 'OpenSans',
                                    fontWeight: FontWeight.w600,
                                  ),
                                )
                              else
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  children: [
                                    SizedBox(
                                      width: MediaQuery.of(context).size.width *
                                          0.4,
                                      child: ElevatedButton(
                                        style: ElevatedButton.styleFrom(
                                          backgroundColor: MyColors.col3,
                                        ),
                                        onPressed: () {
                                          showAnswerDialog(qna['_id']);
                                        },
                                        child: const Text(
                                          'Post Answer',
                                          style: TextStyle(
                                            fontFamily: 'OpenSans',
                                            fontWeight: FontWeight.bold,
                                            fontSize: 16,
                                          ),
                                        ),
                                      ),
                                    ),
                                  ],
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
              child: Card(
                margin: EdgeInsets.all(8),
                child: Padding(
                  padding: EdgeInsets.all(16),
                  child: Row(
                    children: [
                      Container(
                        height: 50,
                        width: MediaQuery.of(context).size.width * 0.1,
                        child: Image.asset('assets/images/user0.png'),
                      ),
                      SizedBox(
                        width: MediaQuery.of(context).size.width * 0.02,
                      ),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            ClipRect(
                              child: Text(
                                'Question: $question',
                                style: TextStyle(
                                    fontFamily: 'OpenSans',
                                    fontWeight: FontWeight.bold),
                                overflow: TextOverflow.ellipsis,
                              ),
                            ),
                            // SizedBox(height: 8),
                            ClipRRect(
                              child: Text(
                                'Asked by: $qasker',
                                style: TextStyle(
                                  fontFamily: 'OpenSans',
                                  color: Colors.grey,
                                ),
                                overflow: TextOverflow.ellipsis,
                              ),
                            ),
                            Divider(),
                            if (answer != "")
                              Text(
                                'Answer: $answer',
                                style: TextStyle(fontFamily: 'OpenSans'),
                              )
                            else
                              Column(
                                children: [
                                  SizedBox(
                                    width:
                                        MediaQuery.of(context).size.width * 0.4,
                                    child: ElevatedButton(
                                      style: ElevatedButton.styleFrom(
                                        backgroundColor: MyColors.col3,
                                      ),
                                      onPressed: () {
                                        showAnswerDialog(qna['_id']);
                                      },
                                      child: const Text(
                                        'Post Answer',
                                        style: TextStyle(
                                          fontFamily: 'OpenSans',
                                          fontWeight: FontWeight.bold,
                                          fontSize: 16,
                                        ),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}
