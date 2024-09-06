import 'package:flutter/material.dart';
import 'LoginActivity.dart';
import 'Signup.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'GLIA Diagnostics',
      home: SplashScreen(),
      debugShowCheckedModeBanner: false,
    );
  }
}

class SplashScreen extends StatefulWidget {
  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    Future.delayed(Duration(seconds: 3), () {
      Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => RegisterScreen()));
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.blue,
      body: Center(
        child: Image.asset('assets/full_logo.png', width: 200),
      ),
    );
  }
}

class RegisterScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Image.asset('assets/full_logo.png', width: MediaQuery.of(context).size.width * 0.5),
            SizedBox(height: 30),
            Text('Welcome To GLIA Connect!', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
            SizedBox(height: 8),
            Text('Helping you through every step!', style: TextStyle(fontSize: 16)),
            SizedBox(height: 30),
            customButton(context, 'Log In', 'assets/login_button.png', Colors.white, true),
            SizedBox(height: 15),
            customButton(context, 'Sign Up', 'assets/signup_button.png', Colors.blue, false), // Adjusted color for visibility
            SizedBox(height: 20),
          ],
        ),
      ),
    );
  }

  Widget customButton(BuildContext context, String text, String imagePath, Color textColor, bool isLogin) {
    return GestureDetector(
      onTap: () {
        if (isLogin) {
          Navigator.push(context, MaterialPageRoute(builder: (context) => LoginActivity()));
        } else {
          Navigator.push(context, MaterialPageRoute(builder: (context) => SignupScreen())); // Navigate to SignupScreen on Sign Up
        }
      },
      child: Stack(
        alignment: Alignment.center,
        children: <Widget>[
          Image.asset(imagePath, width: MediaQuery.of(context).size.width * 0.5),
          Text(text, style: TextStyle(color: textColor, fontWeight: FontWeight.bold, fontSize: 16))
        ],
      ),
    );
  }
}
