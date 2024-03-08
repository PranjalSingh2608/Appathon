import 'package:appathon/utils/colors.dart';
import 'package:appathon/utils/routes.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../utils/http.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final AuthService authService = AuthService();
  final TextEditingController phoneController = TextEditingController();
  bool isLoading = false;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).backgroundColor,
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Text(
                  'Phone Authentication',
                  style: TextStyle(
                    fontSize: 22,
                    fontWeight: FontWeight.bold,
                    fontFamily: 'europa',
                  ),
                  textAlign: TextAlign.center,
                ),
                const SizedBox(
                  height: 10,
                ),
                const Text(
                  'You need to authenticate before getting started!',
                  style: TextStyle(
                    fontSize: 14,
                    fontFamily: 'opensans',
                  ),
                  textAlign: TextAlign.center,
                ),
                const SizedBox(
                  height: 10,
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 16, right: 16),
                  child: Container(
                    margin: EdgeInsets.only(
                      left: 16,
                      right: 16,
                    ),
                    decoration: BoxDecoration(
                        border: Border.all(
                          width: 1,
                          color: Colors.grey,
                        ),
                        borderRadius: BorderRadius.circular(20)),
                    child: Padding(
                      padding: const EdgeInsets.only(left: 16.0, right: 16),
                      child: TextField(
                        controller: phoneController,
                        decoration: InputDecoration(
                          border: InputBorder.none,
                          hintText: 'Phone',
                          hintStyle: TextStyle(
                            fontFamily: 'opensans',
                            fontSize: 16,
                          ),
                        ),
                        style: TextStyle(
                          fontSize: 16,
                          fontFamily: 'opensans',
                          fontWeight: FontWeight.w400,
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
          SizedBox(height: 10),
          ElevatedButton(
            onPressed: isLoading
                ? null
                : () async {
                    setState(() {
                      isLoading = true;
                    });

                    final phoneNo = phoneController.text;

                    try {
                      final ans = await authService.loginUser(phoneNo);
                      if (ans == true) {
                        print("Login success");
                        Navigator.of(context).pushReplacementNamed('/home');
                      } else {
                        print("Login error");
                      }
                    } catch (e) {
                      print('Login error: $e');
                    } finally {
                      setState(() {
                        isLoading = false;
                      });

                      phoneController.clear();
                    }
                  },
            child: Container(
              width: MediaQuery.of(context).size.width * 0.4,
              child: Center(
                child: isLoading
                    ? Center(
                        child: CircularProgressIndicator(
                          color: MyColors.col3,
                        ),
                      )
                    : Text(
                        'Login',
                        style: TextStyle(
                          fontSize: 16,
                          color: Colors.white,
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
          TextButton(
            onPressed: () async{
              final prefs = await SharedPreferences.getInstance();
              prefs.setString('phoneNo', phoneController.text.toString());
              Navigator.of(context).pushReplacementNamed(MyRoutes.SignUpRoute);
            },
            child: Text(
              'Create free account !',
              style: TextStyle(
                color: MyColors.col3,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
