import 'package:flutter/material.dart';

import '../utils/colors.dart';

class Product {
  final String name;
  final String description;
  final double price;
  final String imageUrl;

  Product({
    required this.name,
    required this.description,
    required this.price,
    required this.imageUrl,
  });
}

class MarketplaceScreen extends StatelessWidget {
  final List<Product> products = [
    Product(
      name: "Hay",
      description: "High-quality fodder for cattle feed",
      price: 2500,
      imageUrl: "assets/images/hay0.jpg",
    ),
    Product(
      name: "Vaccine",
      description: "Immunization shots for disease prevention in cattle",
      price: 500,
      imageUrl: "assets/images/vaccine.jpg",
    ),
    Product(
      name: "Dewormers",
      description: "Medication to control internal parasites in cattle",
      price: 399,
      imageUrl: "assets/images/dewormer.jpg",
    ),
    Product(
      name: "Milking Machines",
      description: "Automated equipment for efficient milking process",
      price: 79000,
      imageUrl: "assets/images/milkingmachine.webp",
    ),
    Product(
      name: "Artificial Insemination Kits",
      description:
          "Tools and supplies for breeding cattle through artificial insemination",
      price: 4999,
      imageUrl: "assets/images/aikit.jpg",
    ),
    Product(
      name: "Tractor",
      description: "Farm vehicle for various agricultural tasks",
      price: 499999,
      imageUrl: "assets/images/tractor.jpeg",
    ),
  ];

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
                child: Image.asset('assets/images/marketplace0.png')),
            SizedBox(
              width: 10,
            ),
            Text(
              'Marketplace',
              style: TextStyle(
                  fontFamily: 'Europa', fontSize: 28, color: MyColors.col3),
            ),
          ],
        ),
        backgroundColor: MyColors.background,
      ),
      body: Padding(
        padding: const EdgeInsets.only(top: 8.0),
        child: ListView.builder(
          itemCount: products.length,
          itemBuilder: (context, index) {
            final product = products[index];
            return Padding(
              padding: const EdgeInsets.only(left: 8.0, right: 8.0),
              child: Card(
                elevation: 4.0,
                child: ListTile(
                  leading: Container(
                      height: 60,
                      width: 60,
                      child: Image.asset(product.imageUrl)),
                  title: Text(product.name),
                  subtitle: Text(
                    product.description,
                    style: TextStyle(fontFamily: 'OpenSans', fontSize: 12),
                  ),
                  trailing: Text('\₹ ${product.price.toStringAsFixed(2)}'),
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}
