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
          title: Text('Post Answer'),
          content: TextFormField(
            onChanged: (value) {
              answer = value;
            },
            decoration: InputDecoration(
              hintText: 'Your Answer Here',
            ),
          ),
          actions: <Widget>[
            ElevatedButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: Text('Cancel'),
            ),
            ElevatedButton(
              onPressed: () async {
                await postAnswer(questionId, answer);
                Navigator.of(context).pop();
                fetchQnAData(); // Refresh after posting an answer
              },
              child: Text('Post Answer'),
            ),
          ],
        );
      },
    );
  }

  Future<void> fetchQnAData() async {
    final apiUrl = 'https://smiling-garment-deer.cyclic.app/getallqna';

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
    final apiUrl = 'https://smiling-garment-deer.cyclic.app/postAnswer';
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
    final apiUrl = 'https://smiling-garment-deer.cyclic.app/questionpost';
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
          title: Text('Post Question'),
          content: TextFormField(
            controller: newQuestionController,
            decoration: InputDecoration(
              hintText: 'Your Question Here',
            ),
          ),
          actions: <Widget>[
            ElevatedButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: Text('Cancel'),
            ),
            ElevatedButton(
              onPressed: () async {
                await postQuestion(newQuestionController.text.toString());
                Navigator.of(context).pop();
                fetchQnAData();
              },
              child: Text('Post Question'),
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
        child: Image.asset('assets/images/chatbot0.png'),
      ),
      body: ListView.builder(
        itemCount: qnaList.length,
        itemBuilder: (context, index) {
          final qna = qnaList[index];
          final question = qna['question'];
          final qasker = qna['qasker'];
          final answer = qna['answer'];

          return Card(
            margin: EdgeInsets.all(8),
            child: Padding(
              padding: EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('Question: $question'),
                  SizedBox(height: 8),
                  Text('Asked by: $qasker'),
                  SizedBox(height: 8),
                  if (answer != "")
                    Text('Answer: $answer')
                  else
                    Column(
                      children: [
                        ElevatedButton(
                          onPressed: () {
                            showAnswerDialog(qna['_id']);
                          },
                          child: Text('Post Answer'),
                        ),
                        SizedBox(height: 8),
                        // Space to enter the answer
                      ],
                    ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
