import 'package:flutter/material.dart';
import 'package:late_start/utils/constants.dart';
import 'configurations.dart';
import 'faq_page.dart';
import 'about.dart';

class SettingsPage extends StatelessWidget {
  const SettingsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Settings', style: TextStyle(color: primaryTitleGrayColor),),
      ),
      body: ListView(
        children: <Widget>[
          ListTile(
            leading: const Icon(
              Icons.info,
              color: primaryColor,
            ),
            title: const Text('About'),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => const AboutPage()),
              );
            },
          ),
          ListTile(
            leading: const Icon(Icons.settings, color: primaryColor),
            title: const Text('Configurations'),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => const ConfigurationsPage()),
              );
            },
          ),
          ListTile(
            leading: const Icon(Icons.question_answer, color: primaryColor),
            title: const Text('FAQ'),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => const FaqPage()),
              );
            },
          ),
          // ListTile(
          //   leading: const Icon(Icons.login),
          //   title: const Text('Sign In'),
          //   onTap: () {
          //     Navigator.push(
          //       context,
          //       MaterialPageRoute(builder: (context) => const SignInPage()),
          //     );
          //   },
          // ),
        ],
      ),
    );
  }
}
