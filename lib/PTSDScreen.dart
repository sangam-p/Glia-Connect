import 'package:flutter/material.dart';

class PTSDScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'PTSD',
          style: TextStyle(
            color: Colors.blue,
            fontWeight: FontWeight.bold,
          ),
        ),
        backgroundColor: Colors.white,
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: Colors.blue),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Image.asset('assets/napoleonic_wars_image.png'), // Image 1
            Image.asset('assets/brain_image.png'), // Image 2
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(
                'Diagnosis',
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              child: Text(
                'The Diagnosis Of TBI, Associated Post-Concussive Symptoms And Other Comorbidities Such As PTSD, Presents Unique Challenges For Diagnosticians. No Screening Instruments Available Can Reliably Make The Diagnosis; The ‘gold Standard’ Remains An Interview By A Skilled Clinician. The Current Military, Veterans’ And Non-Military Screening Tools Are Intended To Initiate The Evaluation Process, Not To Definitively Make The Diagnosis.',
                style: TextStyle(fontSize: 16),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
