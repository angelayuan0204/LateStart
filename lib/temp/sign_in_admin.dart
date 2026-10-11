import 'package:flutter/material.dart';
import 'package:late_start/utils/constants.dart';

class SignInAdminPage extends StatelessWidget {
  const SignInAdminPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Sign In as Admin'),
      ),
      body: const Center(
        child: Text('Sign In as Admin Page'),
      ),
    );
  }
}