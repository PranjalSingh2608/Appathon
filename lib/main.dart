import 'package:appathon/screens/alertprod_page.dart';
import 'package:appathon/screens/animal_schema_page.dart';
import 'package:appathon/screens/cattle_register_page.dart';
import 'package:appathon/screens/home_page.dart';
import 'package:appathon/screens/learn_page.dart';
import 'package:appathon/screens/login_page.dart';
import 'package:appathon/screens/marketplacescreen.dart';
import 'package:appathon/screens/milk_record_page.dart';
import 'package:appathon/screens/otp_page_login.dart';
import 'package:appathon/screens/premium_page.dart';
import 'package:appathon/screens/profile_page.dart';
import 'package:appathon/screens/qna_page.dart';
import 'package:appathon/screens/register_page.dart';
import 'package:appathon/screens/stock_page.dart';
import 'package:appathon/screens/welcome.dart';
import 'package:appathon/utils/colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'utils/routes.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  static Future<void> setLocale(BuildContext context, Locale locale) async {
    _MyAppState? state = context.findAncestorStateOfType<_MyAppState>();
    if (state != null) {
      state.changeLanguage(locale);
    }
  }

  const MyApp({super.key});
  static const Color backgroundColor = Color(0xfff5fffa);

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  Locale _locale = const Locale('en', '');

  void changeLanguage(Locale locale) {
    setState(() {
      _locale = locale;
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      localizationsDelegates: [
        AppLocalizations.delegate,
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate
      ],
      supportedLocales: [
        const Locale('en', ''),
        const Locale('hi', ''),
        const Locale('te', ''),
      ],
      locale: _locale,
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
        MyRoutes.AlertProdRoute: (context) => AlertProdScreen(),
        MyRoutes.OTPLoginRoute: (context) => OTPLoginScreen(),
        MyRoutes.LearnPageRoute: (context) => LearnPage(),
        MyRoutes.ProfilePageRoute: (context) => ProfilePage(),
        MyRoutes.PremiumPageRoute: (context) => PremiumPage(),
      },
    );
  }
}
