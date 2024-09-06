import 'package:flutter/material.dart';
import 'ConcussionScreen.dart'; // Ensure these paths are correct
import 'LoginActivity.dart';
import 'PTSDScreen.dart';
import 'TBIScreen.dart';
import 'QuizScreen.dart';
import 'Profile.dart'; // Import Profile.dart

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: MainActivity(
        userName: "John Doe", // Dummy name for testing
        email: "johndoe@example.com", // Dummy email for testing
        phone: "90485982",
      ),
    );
  }
}

class MainActivity extends StatelessWidget {
  final String userName;
  final String email;
  final String phone;

  // Accept the user's name and email in the constructor
  MainActivity({required this.userName, required this.email, required this.phone,});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        leading: Builder(
          builder: (BuildContext context) {
            return IconButton(
              icon: Icon(Icons.menu, color: Colors.blue),
              onPressed: () {
                Scaffold.of(context).openDrawer();
              },
            );
          },
        ),
        title: Text(
          'Home',
          style: TextStyle(color: Colors.blue, fontSize: 24, fontWeight: FontWeight.bold),
        ),
        actions: [
          IconButton(
            icon: Icon(Icons.notifications, color: Colors.blue),
            onPressed: () {
              // Handle notifications button press
            },
          ),
          IconButton(
            icon: Icon(Icons.more_vert, color: Colors.blue),
            onPressed: () {
              // Handle more options button press
            },
          ),
        ],
      ),
      drawer: CustomDrawer(userName: userName, email: email,  phone: phone,), // Call the CustomDrawer class here
      body: SingleChildScrollView(
        padding: EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            SizedBox(height: 10),
            Stack(
              alignment: Alignment.center,
              children: [
                Container(
                  width: double.infinity,
                  height: 200,
                  decoration: BoxDecoration(
                    color: Colors.teal[50],
                    borderRadius: BorderRadius.circular(15),
                  ),
                ),
                Icon(
                  Icons.play_arrow,
                  color: Colors.teal,
                  size: 100,
                ),
              ],
            ),
            SizedBox(height: 10),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                IconButton(
                  icon: Icon(Icons.arrow_back_ios, color: Colors.teal),
                  onPressed: () {
                    // Handle previous button press
                  },
                ),
                Spacer(),
                IconButton(
                  icon: Icon(Icons.arrow_forward_ios, color: Colors.teal),
                  onPressed: () {
                    // Handle next button press
                  },
                ),
              ],
            ),
            SizedBox(height: 10),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                CircleAvatar(
                  backgroundColor: Colors.teal,
                  radius: 5,
                ),
                SizedBox(width: 5),
                CircleAvatar(
                  backgroundColor: Colors.grey,
                  radius: 5,
                ),
                SizedBox(width: 5),
                CircleAvatar(
                  backgroundColor: Colors.grey,
                  radius: 5,
                ),
              ],
            ),
            SizedBox(height: 20),
            GridView.count(
              shrinkWrap: true,
              crossAxisCount: 2,
              crossAxisSpacing: 10,
              mainAxisSpacing: 10,
              children: [
                _buildGridItem(context, 'assets/concussion.png', 'Concussion'),
                _buildGridItem(context, 'assets/pcs.png', 'PCS'),
                _buildGridItem(context, 'assets/ptsd.png', 'PTSD'),
                _buildGridItem(context, 'assets/tbi.png', 'TBI'),
                _buildGridItem(context, 'assets/quiz.png', 'Quiz'),
                _buildGridItem(context, 'assets/sports.png', 'Sports'),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildGridItem(BuildContext context, String imagePath, String title) {
    return GestureDetector(
      onTap: () {
        if (title == 'Concussion') {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => ConcussionScreen(userType: 'user')), // Change userType accordingly
          );
        } else if (title == 'PTSD') {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => PTSDScreen()), // Navigate to PTSDScreen
          );
        } else if (title == 'TBI') {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => TBIScreen()), // Navigate to TBIScreen
          );
        } else if (title == 'Quiz') {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => QuizScreen()), // Navigate to QuizScreen
          );
        }
      },
      child: Column(
        children: [
          Container(
            width: 100,
            height: 100,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(15),
              image: DecorationImage(
                image: AssetImage(imagePath),
                fit: BoxFit.cover,
              ),
            ),
          ),
          SizedBox(height: 5),
          Text(
            title,
            style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
          ),
        ],
      ),
    );
  }
}

// This is the CustomDrawer class
class CustomDrawer extends StatelessWidget {
  final String userName;
  final String email;
  final String phone;

  // Accept userName and email in the constructor
  CustomDrawer({required this.userName, required this.email, required this.phone});

  void _logout(BuildContext context) {
    // Clear any session data or tokens if needed
    // For example, you can clear the SharedPreferences if you are using it for session management
    // SharedPreferences prefs = await SharedPreferences.getInstance();
    // await prefs.clear();

    // Navigate to the LoginActivity and remove all routes behind it
    Navigator.pushAndRemoveUntil(
      context,
      MaterialPageRoute(builder: (context) => LoginActivity()),
          (route) => false, // This will remove all previous routes
    );
  }
  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        padding: EdgeInsets.zero,
        children: <Widget>[
          UserAccountsDrawerHeader(
            accountName: Text(userName, style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
            accountEmail: Text(email),
            currentAccountPicture: CircleAvatar(
              backgroundImage: AssetImage('assets/profile_pic.png'), // Replace with your image asset
            ),
            decoration: BoxDecoration(
              color: Colors.blue,
            ),
          ),
          ListTile(
            leading: Icon(Icons.person, color: Colors.blue),
            title: Text('Profile'),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => ProfilePage(userName: userName,
                  email: email,
                  phone: phone,)), // Navigate to ProfilePage
              );
            },
          ),
          ListTile(
            leading: Icon(Icons.favorite, color: Colors.blue),
            title: Text('Favorite'),
            onTap: () {
              // Handle Favorite tap
            },
          ),
          ListTile(
            leading: Icon(Icons.credit_card, color: Colors.blue),
            title: Text('Payment Method'),
            onTap: () {
              // Handle Payment Method tap
            },
          ),
          ListTile(
            leading: Icon(Icons.lock, color: Colors.blue),
            title: Text('Privacy Policy'),
            onTap: () {
              // Handle Privacy Policy tap
            },
          ),
          ListTile(
            leading: Icon(Icons.settings, color: Colors.blue),
            title: Text('Settings'),
            onTap: () {
              // Handle Settings tap
            },
          ),
          ListTile(
            leading: Icon(Icons.help, color: Colors.blue),
            title: Text('Help'),
            onTap: () {
              // Handle Help tap
            },
          ),
          ListTile(
            leading: Icon(Icons.exit_to_app, color: Colors.blue),
            title: Text('Logout'),
            onTap: () {
              _logout(context); // Call the logout function
            },
          ),
        ],
      ),
    );
  }
}
