import 'package:flutter/material.dart';
import 'package:late_start/utils/constants.dart';

class SignInProPage extends StatelessWidget {
  const SignInProPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Sign In as Pro'),
      ),
      body: const Center(
        child: Text('Sign In as Pro Page'),
      ),
    );
  }
}
