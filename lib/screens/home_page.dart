import 'package:appathon/utils/colors.dart';
import 'package:appathon/utils/routes.dart';
import 'package:flutter/material.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: MyColors.background,
      body: SafeArea(
        child: Container(
          child: Column(
            children: <Widget>[
              SizedBox(
                height: 110,
              ),
              Padding(
                padding: EdgeInsets.only(
                  left: 16,
                  right: 16,
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text('Hello'),
                        Text('Good Morning'),
                        SizedBox(
                          height: 4,
                        ),
                        Text('Home'),
                      ],
                    ),
                    IconButton(
                      onPressed: () {
                        // Navigator.of(context).pushNamedAndRemoveUntil(
                        //     MyRoutes.CattleRegisterRoute);
                      },
                      icon: Image.asset('assets/images/cow0.png'),
                    )
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
