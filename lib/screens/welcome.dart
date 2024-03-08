import 'package:appathon/utils/colors.dart';
import 'package:flutter/material.dart';
import '../utils/routes.dart';

class WelcomeScreen extends StatelessWidget {
  const WelcomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: MyColors.background,
      body: SafeArea(
        child: Container(
          margin: const EdgeInsets.only(
            left: 10,
            top: 20,
            right: 10,
            bottom: 20,
          ),
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(
                  height: MediaQuery.of(context).size.height * 0.05,
                  child: const Text(
                    'MeriDairy',
                    style: TextStyle(
                      fontFamily: 'designer',
                      fontSize: 32,
                    ),
                  ),
                ),
                SizedBox(
                  height: MediaQuery.of(context).size.height * 0.52,
                  child: Image.asset('assets/images/farm0.png'),
                ),
                SizedBox(
                  height: MediaQuery.of(context).size.height * 0.15,
                  child: const Text(
                    'Let\'s Get \nStarted',
                    style: TextStyle(
                      fontSize: 42,
                      fontWeight: FontWeight.bold,
                      fontFamily: 'opensans',
                    ),
                  ),
                ),
                SizedBox(
                  height: MediaQuery.of(context).size.height * 0.05,
                  child: const Text(
                    'Unlock the Ultimate Dairy Management Experience!',
                    style: TextStyle(
                      color: Colors.black38,
                      fontFamily: 'europa',
                    ),
                  ),
                ),
                Center(
                  child: SizedBox(
                    width: MediaQuery.of(context).size.width * 0.8,
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: MyColors.col3,
                      ),
                      onPressed: () =>
                          Navigator.pushNamed(context, MyRoutes.SignUpRoute),
                      child: const Text(
                        'Register',
                        style: TextStyle(
                          fontFamily: 'OpenSans',
                          fontWeight: FontWeight.bold,
                          fontSize: 16,
                        ),
                      ),
                    ),
                  ),
                ),
                Center(
                  child: SizedBox(
                    width: MediaQuery.of(context).size.width * 0.8,
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: MyColors.col3,
                      ),
                      onPressed: () =>
                          Navigator.pushNamed(context, MyRoutes.LoginRoute),
                      child: const Text(
                        'Login',
                        style: TextStyle(
                          fontFamily: 'opensans',
                          fontWeight: FontWeight.bold,
                          fontSize: 16,
                        ),
                      ),
                    ),
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
