import 'package:appathon/screens/home_page.dart';
import 'package:appathon/screens/login_page.dart';
import 'package:appathon/screens/signup_page.dart';
import 'package:flutter/material.dart';


import 'utils/routes.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  static const Color backgroundColor = Color(0xfff5fffa);
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        // fontFamily: GoogleFonts.roboto().fontFamily,
        brightness: Brightness.light,
        backgroundColor: backgroundColor,
        // textTheme: GoogleFonts.robotoTextTheme(
        //   Theme.of(context).textTheme.apply(
        //         bodyColor: Colors.black.withOpacity(0.8),
        //       ),
        // ),
      ),
      initialRoute: '/signup',
      routes: {
        MyRoutes.HomeRoute: (context) => HomeScreen(),
        MyRoutes.SignUpRoute: (context) => SignUpScreen(),
        MyRoutes.LoginRoute: (context) => LoginScreen(),
      },
    );
  }
}
