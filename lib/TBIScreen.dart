import 'package:flutter/material.dart';

class TBIScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'TBI',
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
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 8.0),
              child: Text(
                'Cost Of TBI',
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            Text(
              'According To The CDC, The Economic Cost Of TBI In The United States In 2010, Including Direct And Indirect Medical Costs, Was Estimated At \$76.5 Billion.\n\n'
                  'In Australia, Limited Population Data Are Available, But One Report Estimated The Direct Hospital Costs For All TBI In The 2004–05 Financial Year At \$184 Million. Furthermore, The Total Cost Of TBI* Was Estimated To Be \$8.6 Billion, Comprising:',
              style: TextStyle(fontSize: 16),
            ),
            SizedBox(height: 10),
            Padding(
              padding: const EdgeInsets.only(left: 8.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('1. Costs Attributable To Moderate TBI (\$3.7 Billion) And Severe TBI (\$4.8 Billion);', style: TextStyle(fontSize: 16)),
                  Text('2. Financial Costs (\$3.7 Billion) And Burden Of Disease Costs (\$4.9 Billion); And', style: TextStyle(fontSize: 16)),
                  Text('3. The Greatest Portions Borne By Individuals (64.9%), The State Government (19.1%) And Federal Government (11.2%).', style: TextStyle(fontSize: 16)),
                ],
              ),
            ),
            SizedBox(height: 10),
            Image.asset('assets/line_graph.png'), // Line graph image
            SizedBox(height: 10),
            Text(
              'The Lifetime Costs Per Incident Case Of TBI Were Estimated To Be \$2.5 And \$4.8 Million For Moderate TBI And Severe TBI Respectively, Across Australia.\n\n'
                  '*This Data Fails To Include Costings For MTBI, Which As Noted Above Accounts For 80-90% Of Presentations. There Were 4745 Hospitalisations Of People Aged ≥15 Years For Sport-Related Concussion, With A Total Hospital Treatment Cost Of \$17.9M. The Frequency Of Hospitalisation Increased By 60.5% Over The 9 Years, But Could Only Partially Be Explained By Increases In Sports Participation. (Most Likely',
              style: TextStyle(fontSize: 16),
            ),
          ],
        ),
      ),
    );
  }
}
