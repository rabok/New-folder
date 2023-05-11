import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

class DrinksScreen extends StatefulWidget {
  const DrinksScreen({Key? key}) : super(key: key);

  @override
  _DrinksScreenState createState() => _DrinksScreenState();
}

class _DrinksScreenState extends State<DrinksScreen> {
  List<Dish> drinks = [
    Dish(name: 'soda 350 ml', price: 60, orderCount: 0),
    Dish(name: 'lemonade ', price: 55, orderCount: 0),
    Dish(name: 'Afia 500ml', price: 100, orderCount: 0),
    Dish(name: 'water', price: 50, orderCount: 0),
    Dish(name: 'mango juice', price: 100, orderCount: 0),
    Dish(name: 'black coffe', price: 50, orderCount: 0),
    Dish(name: 'white coffee', price: 50, orderCount: 0),
    Dish(name: 'lemmon coffe', price: 50, orderCount: 0),
    Dish(name: 'all juice', price: 100, orderCount: 0),
    // Add more drinks here
  ];

  void sendOrder() async {
    String orderSummary = "I'm interested in ordering:\n";
    for (Dish drink in drinks) {
      if (drink.orderCount > 0) {
        orderSummary += "${drink.orderCount} of ${drink.name}\n";
      }
    }

    var whatsappUrl =
        "whatsapp://send?phone=+254716205797&text=$orderSummary"; // replace XXXXXXXXX with the rest of the number
    if (await canLaunch(whatsappUrl)) {
      await launch(whatsappUrl);
    } else {
      throw 'Could not launch $whatsappUrl';
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('DRINKS'),
        backgroundColor: Colors.transparent,
        elevation: 0,
      ),
      extendBodyBehindAppBar: true,
      body: Stack(
        children: [
          Image.asset(
            'assets/drinks2.jpg', // Add your asset image path here
            fit: BoxFit.cover,
            height: double.infinity,
            width: double.infinity,
            alignment: Alignment.center,
          ),
          BackdropFilter(
            filter: ImageFilter.blur(sigmaX: 5, sigmaY: 5),
            child: Container(color: Colors.black.withOpacity(0.3)),
          ),
          ListView.builder(
            itemCount: drinks.length,
            itemBuilder: (BuildContext context, int index) {
              return Container(
                margin: EdgeInsets.all(8.0),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10.0),
                  color: Colors.white.withOpacity(0.1),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.white.withOpacity(0.1),
                      spreadRadius: 5,
                      blurRadius: 7,
                      offset: Offset(0, 3),
                    ),
                  ],
                ),
                child: ListTile(
                  leading: Icon(Icons.fastfood, color: Colors.white),
                  title: Text(
                      '${drinks[index].name} - KSH ${drinks[index].price}',
                      style: TextStyle(color: Colors.white)),
                  subtitle: Text('Orders: ${drinks[index].orderCount}',
                      style: TextStyle(color: Colors.white)),
                  trailing: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      IconButton(
                        icon: Icon(Icons.remove, color: Colors.white),
                        onPressed: () {
                          setState(() {
                            if (drinks[index].orderCount > 0) {
                              drinks[index].orderCount--;
                            }
                          });
                        },
                      ),
                      IconButton(
                        icon: Icon(Icons.add, color: Colors.white),
                        onPressed: () {
                          setState(() {
                            drinks[index].orderCount++;
                          });
                        },
                      ),
                    ],
                  ),
                ),
              );
            },
          ),
          Positioned(
            bottom: 20,
            left: 20,
            right: 20,
            child: Container(
              padding: EdgeInsets.all(10),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10.0),
                color: Colors.white.withOpacity(0.3),
                boxShadow: [
                  BoxShadow(
                    color: Colors.white.withOpacity(0.1),
                    spreadRadius: 5,
                    blurRadius: 7,
                    offset: Offset(0, 3),
                  ),
                ],
              ),
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  primary: Colors.transparent,
                  shadowColor: Colors.transparent,
                ),
                onPressed: sendOrder,
                child:
                    Text('Submit Order', style: TextStyle(color: Colors.white)),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class Dish {
  String name;
  int price;
  int orderCount;

  Dish({required this.name, required this.price, required this.orderCount});
}
