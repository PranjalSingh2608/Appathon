import 'package:flutter/material.dart';

import '../utils/colors.dart';

class PremiumPage extends StatelessWidget {
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
                child: Image.asset('assets/images/premium.png')),
            SizedBox(
              width: 10,
            ),
            Text(
              'Premium',
              style: TextStyle(
                  fontFamily: 'Europa', fontSize: 28, color: MyColors.col3),
            ),
          ],
        ),
        backgroundColor: MyColors.background,
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              '30 Days Free Trial !!!',
              style: TextStyle(
                color: Colors.red,
                fontFamily: 'OpenSans',
                fontSize: 32,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(
              height: 18,
            ),
            Text(
              'Upgrade to Premium',
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: 20),
            PricingCard(
              title: 'Monthly Subscription',
              price: '\₹ 99/month',
              onPressed: () {
                ScaffoldMessenger.of(context).hideCurrentSnackBar();
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    content: Text(
                      'This is a prototype feature',
                      style: TextStyle(fontSize: 22),
                    ),
                    backgroundColor: MyColors.col1,
                  ),
                );
              },
            ),
            SizedBox(height: 20),
            PricingCard(
              title: 'Yearly Subscription',
              price: '\₹ 999/year',
              onPressed: () {
                ScaffoldMessenger.of(context).hideCurrentSnackBar();
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    content: Text(
                      'This is a prototype feature',
                      style: TextStyle(fontSize: 22),
                    ),
                    backgroundColor: MyColors.col1,
                  ),
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}

class PricingCard extends StatelessWidget {
  final String title;
  final String price;
  final VoidCallback onPressed;

  PricingCard({
    required this.title,
    required this.price,
    required this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 4,
      margin: EdgeInsets.symmetric(horizontal: 20),
      child: InkWell(
        onTap: onPressed,
        child: Padding(
          padding: EdgeInsets.all(20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Text(
                title,
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(height: 10),
              Text(
                price,
                style: TextStyle(
                  fontSize: 16,
                  color: Colors.grey,
                ),
              ),
              SizedBox(height: 10),
              ElevatedButton(
                onPressed: onPressed,
                child: Text('Purchase'),
                style: ElevatedButton.styleFrom(
                  backgroundColor: MyColors.col3,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
