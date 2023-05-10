import 'package:flutter/material.dart';

import 'Homescreen.dart';
import 'checkout.dart';

import 'onboarding.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      initialRoute: '/',
      routes: {
        '/': (context) => OnboardingScreen(),
        '/home': (context) => HomeScreen(),
        '/checkout': (context) => CheckoutScreen(),
      },
    );
  }
}
