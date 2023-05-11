import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

class FoodScreen extends StatefulWidget {
  const FoodScreen({Key? key}) : super(key: key);

  @override
  _FoodScreenState createState() => _FoodScreenState();
}

class _FoodScreenState extends State<FoodScreen> {
  List<Dish> dishes = [
    Dish(name: 'Pilau', price: 250, orderCount: 0),
    Dish(name: 'coconut Greek rice with beef', price: 250, orderCount: 0),
    Dish(name: 'chiken Biryani', price: 400, orderCount: 0),
    Dish(name: 'beef stew', price: 200, orderCount: 0),
    Dish(name: 'whole tilapia fish', price: 300, orderCount: 0),
    Dish(name: 'beef stew ', price: 200, orderCount: 0),
    Dish(name: 'chiken', price: 130, orderCount: 0),
    Dish(name: 'Malik Fries without sauce', price: 200, orderCount: 0),
    Dish(name: 'Masala fries', price: 200, orderCount: 0),
    Dish(name: 'Beef Fries', price: 230, orderCount: 0),
    Dish(name: 'spaghetti beef stew', price: 250, orderCount: 0),
    Dish(name: 'Drum sticks', price: 130, orderCount: 0),
    Dish(name: 'Greengram', price: 120, orderCount: 0),
    // Add more dishes here
  ];

  void sendOrder() async {
    String orderSummary = "I'm interested in ordering:\n";
    for (Dish dish in dishes) {
      if (dish.orderCount > 0) {
        orderSummary += "${dish.orderCount} of ${dish.name}\n";
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
        title: Text('Main menue'),
        backgroundColor: Colors.transparent,
        elevation: 0,
      ),
      extendBodyBehindAppBar: true,
      body: Stack(
        children: [
          Image.asset(
            'assets/BG2.jpg', // Add your asset image path here
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
            itemCount: dishes.length,
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
                      '${dishes[index].name} - KSH ${dishes[index].price}',
                      style: TextStyle(color: Colors.white)),
                  subtitle: Text('Orders: ${dishes[index].orderCount}',
                      style: TextStyle(color: Colors.white)),
                  trailing: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      IconButton(
                        icon: Icon(Icons.remove, color: Colors.white),
                        onPressed: () {
                          setState(() {
                            if (dishes[index].orderCount > 0) {
                              dishes[index].orderCount--;
                            }
                          });
                        },
                      ),
                      IconButton(
                        icon: Icon(Icons.add, color: Colors.white),
                        onPressed: () {
                          setState(() {
                            dishes[index].orderCount++;
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
