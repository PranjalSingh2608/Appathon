import 'package:flutter/material.dart';

import '../utils/http.dart';
import '../utils/colors.dart';

class OTPScreen extends StatefulWidget {
  final String username;
  final String phone;
  const OTPScreen({Key? key, required this.username, required this.phone});

  @override
  State<OTPScreen> createState() => _OTPScreenState();
}

class _OTPScreenState extends State<OTPScreen> {
  final AuthService authService = AuthService();
  final TextEditingController otpController = TextEditingController();
  bool isLoading = false;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).backgroundColor,
      appBar: AppBar(
        title: Text(
          'Register',
          style: TextStyle(
            fontFamily: 'Europa',
            fontSize: 32,
          ),
        ),
        backgroundColor: MyColors.col3,
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          SingleChildScrollView(
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
                    // Add some vertical spacing
                    TextField(
                      controller: otpController,
                      decoration: InputDecoration(
                        labelText: 'OTP',
                        border: OutlineInputBorder(
                          borderSide: BorderSide(
                            color: MyColors.col2,
                            width: 2,
                          ),
                          borderRadius: BorderRadius.circular(30.0),
                        ),
                      ),
                    ),
                    SizedBox(height: 16), // Add some vertical spacing
                    

                  ],
                ),
              ),
            ),
          ),
          SizedBox(height: 16),
          ElevatedButton(
            onPressed: isLoading
                ? null
                : () async {
                    setState(() {
                      isLoading = true;
                    });
                    final otp = otpController.text;
      
                    try {
                      await authService.registerUser(
                          widget.username, otp, widget.phone);
                      Navigator.of(context).pushReplacementNamed('/home');
                    } catch (e) {
                      print('Registration error: $e');
                    }
                  },
            child: Container(
              width: MediaQuery.of(context).size.width / 2,
              padding: EdgeInsets.symmetric(vertical: 16),
              child: Center(
                child: isLoading
                    ? Center(
                        child: CircularProgressIndicator(
                          color: MyColors.col2,
                        ),
                      )
                    : Text(
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
          SizedBox(height: 16),
          TextButton(
            onPressed: () {
              Navigator.of(context).pushReplacementNamed('/login');
            },
            child: Text(
              'Already a user? Log in here',
              style: TextStyle(
                color: MyColors.col2,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
