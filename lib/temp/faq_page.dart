import 'package:flutter/material.dart';
import 'package:late_start/utils/constants.dart';

class FaqPage extends StatelessWidget {
  const FaqPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('FAQ', style: TextStyle(color: primaryTitleGrayColor),),
      ),
      body: ListView(
        padding: const EdgeInsets.all(16.0),
        children: const <Widget>[
          ExpansionTile(
            title: Text('How do I set an alarm?'),
            children: <Widget>[
              Padding(
                padding: EdgeInsets.all(8.0),
                child: Text(
                  'To set an alarm, go to the Alarms section and select the "+" icon. You can then choose the time and day/cycle day for the alarm. Don’t forget to save your alarm.',
                ),
              ),
            ],
          ),
          ExpansionTile(
            title: Text('Why isn\'t my alarm ringing?'),
            children: <Widget>[
              Padding(
                padding: EdgeInsets.all(8.0),
                child: Text(
                  'Ensure that your alarm is set for the correct cycle day and that your phone\'s volume is not muted. Also, check if the alarm is active and hasn’t been accidentally turned off.',
                ),
              ),
            ],
          ),
          ExpansionTile(
            title: Text('Can I set multiple alarms for different cycle days?'),
            children: <Widget>[
              Padding(
                padding: EdgeInsets.all(8.0),
                child: Text(
                  'Yes, you can set multiple alarms for different cycle days. Simply repeat the process for setting an alarm and customize each alarm according to the specific cycle day and time you need.',
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
