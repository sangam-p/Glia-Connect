import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Concussion Info',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: ConcussionScreen(userType: 'admin'), // Change to 'user' for user role
    );
  }
}

class ConcussionScreen extends StatefulWidget {
  final String userType;

  ConcussionScreen({required this.userType});

  @override
  _ConcussionScreenState createState() => _ConcussionScreenState();
}

class _ConcussionScreenState extends State<ConcussionScreen> {
  bool _isEditing = false;
  final TextEditingController _fussController = TextEditingController();
  final TextEditingController _problemController = TextEditingController();
  final TextEditingController _costController = TextEditingController();

  @override
  void initState() {
    super.initState();
    // Initialize controllers with default text
    _fussController.text = "Concussion And Traumatic Brain Injury (TBI) Affect Millions Worldwide, With A Significant Impact In Emergency Departments. Current Diagnosis Relies On Subjective Interpretation Of Symptoms And Clinical Assessments Like The Glasgow Coma Scale, But Accuracy Is Low. Research Is Exploring Biomarkers For More Precise Diagnosis, With Glia Focusing On Nucleic Acid Markers Showing Promise For Prognosis. The Medical Field's Increasing Focus On Brain Health, Including Psychological And Pathological Conditions, Sets A Solid Foundation For TBI Diagnostics. There's A Pressing Need For Blood-Based Pathology Tests And Point Of Care (PoC) Tests To Improve Diagnosis And Triage, Minimizing Long-Term Effects And Maximizing Recovery.";
    _problemController.text = "Traumatic Brain Injury (TBI) Is A Leading Cause Of Death And Disability Globally, With A High Incidence In Countries Like Australia, Europe, And The United States, Where It Affects Millions Annually. The Majority Of Cases Are Classified As Mild TBI (MTBI). In The US Alone, Over 3.5 Million People Are Impacted Each Year. Sport-Related Concussions, Particularly Among Individuals Aged 0-19, Contribute Significantly To TBI Cases, With Up To 15% Experiencing Prolonged Performance Decline Post-Concussion. TBI Also Poses A Risk For Neurodegenerative Disorders Like Alzheimer's Disease. The Personal And Economic Burdens Of TBI Are Substantial. Utilizing Biomarkers Is Advocated As A Valuable Tool For Comprehensive Brain Function Assessment Post-Concussion.";
    _costController.text = "Globally, Traumatic Brain Injury (TBI) Is The Leading Cause Of Death And Disability Globally, With A High Incidence In Countries Like Australia, Europe, And The United States, Where It Affects Millions Annually. The Majority Of Cases Are Classified As Mild TBI (MTBI). In The US Alone, Over 3.5 Million People Are Impacted Each Year. Sport-Related Concussions, Particularly Among Individuals Aged 0-19, Contribute Significantly To TBI Cases, With Up To 15% Experiencing Prolonged Performance Decline Post-Concussion. TBI Also Poses A Risk For Neurodegenerative Disorders Like Alzheimer's Disease. The Personal And Economic Burdens Of TBI Are Substantial. Utilizing Biomarkers Is Advocated As A Valuable Tool For Comprehensive Brain Function Assessment Post-Concussion.";
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        iconTheme: IconThemeData(color: Colors.blue),
        title: Text(
          'Concussion',
          style: TextStyle(color: Colors.blue, fontSize: 24, fontWeight: FontWeight.bold),
        ),
        actions: widget.userType == 'admin'
            ? [
          IconButton(
            icon: Icon(_isEditing ? Icons.save : Icons.edit, color: Colors.blue),
            onPressed: () {
              setState(() {
                if (_isEditing) {
                  // Save changes
                  // Handle saving logic here
                }
                _isEditing = !_isEditing;
              });
            },
          ),
        ]
            : [],
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SectionTitle(title: "What's All The Fuss?"),
            SizedBox(height: 10),
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Expanded(
                  flex: 3,
                  child: _isEditing
                      ? TextField(
                    controller: _fussController,
                    maxLines: null,
                    decoration: InputDecoration(border: OutlineInputBorder()),
                  )
                      : Text(
                    _fussController.text,
                    style: TextStyle(fontSize: 16),
                  ),
                ),
                SizedBox(width: 10),
                Expanded(
                  flex: 1,
                  child: Image.asset('assets/concussion.png'), // Make sure to add this image to your assets
                ),
              ],
            ),
            SizedBox(height: 20),
            SectionTitle(title: "The Problem"),
            SizedBox(height: 10),
            _isEditing
                ? TextField(
              controller: _problemController,
              maxLines: null,
              decoration: InputDecoration(border: OutlineInputBorder()),
            )
                : Text(
              _problemController.text,
              style: TextStyle(fontSize: 16),
            ),
            SizedBox(height: 20),
            SectionTitle(title: "The Cost"),
            SizedBox(height: 10),
            _isEditing
                ? TextField(
              controller: _costController,
              maxLines: null,
              decoration: InputDecoration(border: OutlineInputBorder()),
            )
                : Text(
              _costController.text,
              style: TextStyle(fontSize: 16),
            ),
          ],
        ),
      ),
    );
  }
}

class SectionTitle extends StatelessWidget {
  final String title;

  SectionTitle({required this.title});

  @override
  Widget build(BuildContext context) {
    return Text(
      title,
      style: TextStyle(color: Colors.black, fontSize: 18, fontWeight: FontWeight.bold),
    );
  }
}
