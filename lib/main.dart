import 'package:appathon/screens/animal_schema_page.dart';
import 'package:appathon/screens/cattle_register_page.dart';
import 'package:appathon/screens/home_page.dart';
import 'package:appathon/screens/learn_page.dart';
import 'package:appathon/screens/login_page.dart';
import 'package:appathon/screens/marketplacescreen.dart';
import 'package:appathon/screens/milk_record_page.dart';
import 'package:appathon/screens/qna_page.dart';
import 'package:appathon/screens/register_page.dart';
import 'package:appathon/screens/stock_page.dart';
import 'package:appathon/screens/welcome.dart';
import 'package:appathon/utils/colors.dart';
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
        fontFamily: 'Europa',
        brightness: Brightness.light,
        backgroundColor: MyColors.background,

        // textTheme: GoogleFonts.robotoTextTheme(
        //   Theme.of(context).textTheme.apply(
        //         bodyColor: Colors.black.withOpacity(0.8),
        //       ),
        // ),
      ),
      initialRoute: '/welcome',
      routes: {
        MyRoutes.WelcomeRoute: (context) => WelcomeScreen(),
        MyRoutes.HomeRoute: (context) => HomeScreen(),
        MyRoutes.SignUpRoute: (context) => RegisterScreen(),
        MyRoutes.LoginRoute: (context) => LoginScreen(),
        MyRoutes.CattleRegisterRoute: (context) => CattleRegister(),
        MyRoutes.MilkRecordRoute: (context) => MilkRecordScreen(),
        MyRoutes.AnimalSchemaRoute: (context) => AnimalSchemaScreen(),
        MyRoutes.StockRoute: (context) => StockScreen(),
        MyRoutes.QnARoute: (context) => QnAPage(),
        MyRoutes.MarketplaceRoute: (context) => MarketplaceScreen(),
        MyRoutes.LearnPageRoute: (context) => LearnPage(),
      },
    );
  }
}
