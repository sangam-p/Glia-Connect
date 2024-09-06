import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'Signup.dart'; // Ensure the path is correct
import 'SetPasswordScreen.dart'; // Import SetPasswordScreen
import 'MainActivity.dart'; // Import MainActivity
import 'package:http/http.dart' as http; // Add http package
import 'dart:convert'; // For JSON encoding/decoding

class LoginActivity extends StatefulWidget {
  @override
  _LoginActivityState createState() => _LoginActivityState();
}

class _LoginActivityState extends State<LoginActivity> {
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  bool _obscureText = true;

  void _togglePasswordVisibility() {
    setState(() {
      _obscureText = !_obscureText;
    });
  }

  Future<void> _submitForm() async {
    if (_formKey.currentState!.validate()) {
      print('Email: ${emailController.text}');
      print('Password: ${passwordController.text}');

      if (emailController.text.isEmpty || passwordController.text.isEmpty) {
        print('Email or password is empty');
        return;
      }

      try {
        final response = await http.post(
          Uri.parse('http://192.168.1.105/flutter_backend/login_user.php'),
          body: {
            'email_or_mobile': emailController.text,
            'password': passwordController.text,
          },
        );

        print('Response status: ${response.statusCode}');
        print('Response body: ${response.body}');

        if (response.statusCode == 200) {
          final data = jsonDecode(response.body);
          print('Decoded data: $data');

          if (data['status'] == 'success') {
            String userName = data['user']['full_name'] ?? 'Unknown User';
            String email = data['user']['email'] ?? 'Unknown Email';
            String phone = data['user']['phone'] ?? 'Unknown Phone';


            // Navigate to MainActivity with the correct user details
            Navigator.pushReplacement(
              context,
              MaterialPageRoute(
                builder: (context) => MainActivity(
                  userName: userName,
                  email: email,
                  phone: phone,

                ),
              ),
            );
          } else {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(content: Text('Login failed: ${data['message']}')),
            );
          }
        } else {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text('Error: ${response.statusCode}, ${response.body}')),
          );
        }
      } catch (e) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Exception: $e')),
        );
      }
    } else {
      print('Form is not valid');
    }
  }



  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        iconTheme: IconThemeData(color: Colors.blue),
        title: Text('Log In', style: TextStyle(color: Colors.blue, fontSize: 24, fontWeight: FontWeight.bold)),
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(20),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(height: 10),
              Text('Welcome', style: TextStyle(color: Colors.blue, fontSize: 24, fontWeight: FontWeight.bold)),
              SizedBox(height: 20),
              Text('Email or Mobile Number', style: TextStyle(color: Colors.black, fontSize: 18)),
              SizedBox(height: 10),
              TextFormField(
                controller: emailController,
                decoration: InputDecoration(
                  hintText: 'example@example.com',
                  hintStyle: TextStyle(color: Colors.grey),
                  filled: true,
                  fillColor: Colors.lightBlue[50],
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                    borderSide: BorderSide.none,
                  ),
                ),
                validator: (value) => value!.isEmpty ? 'Please enter your email or mobile number' : null,
              ),
              SizedBox(height: 20),
              Text('Password', style: TextStyle(color: Colors.black, fontSize: 18)),
              SizedBox(height: 10),
              TextFormField(
                controller: passwordController,
                obscureText: _obscureText,
                decoration: InputDecoration(
                  hintText: '********',
                  hintStyle: TextStyle(color: Colors.grey),
                  filled: true,
                  fillColor: Colors.lightBlue[50],
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                    borderSide: BorderSide.none,
                  ),
                  suffixIcon: IconButton(
                    icon: Icon(_obscureText ? Icons.visibility_off : Icons.visibility, color: Colors.grey),
                    onPressed: _togglePasswordVisibility,
                  ),
                ),
                validator: (value) => value!.isEmpty ? 'Please enter your password' : null,
              ),
              Align(
                alignment: Alignment.centerRight,
                child: TextButton(
                  onPressed: () {
                    Navigator.push(context, MaterialPageRoute(builder: (context) => SetPasswordScreen()));
                  },
                  child: Text('Forgot Password?', style: TextStyle(color: Colors.blue)),
                ),
              ),
              SizedBox(height: 20),
              Center(
                child: ElevatedButton(
                  onPressed: _submitForm,
                  child: Text('Log In', style: TextStyle(fontSize: 18)),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.blue,
                    foregroundColor: Colors.white,
                    minimumSize: Size(double.infinity, 50),
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(30)),
                  ),
                ),
              ),
              SizedBox(height: 20),
              Center(child: Text('or sign up with', style: TextStyle(color: Colors.grey, fontSize: 16))),
              SizedBox(height: 20),
              Center(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    CircleAvatar(
                      backgroundColor: Colors.lightBlue[50],
                      radius: 30,
                      child: IconButton(
                        icon: Image.asset('assets/google_logo.png', width: 24, height: 24), // Replace with your logo path
                        onPressed: () {},
                      ),
                    ),
                    SizedBox(width: 20),
                    CircleAvatar(
                      backgroundColor: Colors.lightBlue[50],
                      radius: 30,
                      child: IconButton(
                        icon: Image.asset('assets/facebook_logo.png', width: 24, height: 24), // Replace with your logo path
                        onPressed: () {},
                      ),
                    ),
                    SizedBox(width: 20),
                    CircleAvatar(
                      backgroundColor: Colors.lightBlue[50],
                      radius: 30,
                      child: IconButton(
                        icon: Image.asset('assets/fingerprint_logo.png', width: 24, height: 24), // Replace with your logo path
                        onPressed: () {},
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(height: 20),
              Align(
                alignment: Alignment.center,
                child: RichText(
                  text: TextSpan(
                    text: 'Don’t have an account? ',
                    style: TextStyle(color: Colors.grey),
                    children: [
                      TextSpan(
                        text: 'Sign Up',
                        style: TextStyle(color: Colors.blue),
                        recognizer: TapGestureRecognizer()
                          ..onTap = () {
                            Navigator.push(context, MaterialPageRoute(builder: (context) => SignupScreen()));
                          },
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
