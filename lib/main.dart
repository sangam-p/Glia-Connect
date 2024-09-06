import 'package:flutter/material.dart';
import 'SplashScreen.dart';  // Make sure this import points to your entry widget file.

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'GLIA Diagnostics',
      home: SplashScreen(),  // Ensure this is your desired starting screen.
      debugShowCheckedModeBanner: false,
    );
  }
}
