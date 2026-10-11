import 'package:flutter/material.dart';
import 'package:late_start/utils/constants.dart';

class AboutPage extends StatelessWidget {
  const AboutPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('About', style: TextStyle(color: primaryTitleGrayColor),),
      ),
      body: const SingleChildScrollView(
        padding: EdgeInsets.all(27.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(height: 16),
            Text(
              'LateStart is a solution designed to assist students who struggle to keep up with their school\'s Cycle Days. It seamlessly integrates with your school\'s unique schedule to operate alarms on repeated cycle days that don\'t match with the ordinary week, such as Day 3 out of Day 1 to Day 6. This way, you can easily schedule those precious "late start" mornings, ensuring that you can wake up refreshed, organized, and ready to take on the day ahead.',
              textAlign: TextAlign.left,
              style: TextStyle(
                fontSize: 16,
                height: 1.5,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
