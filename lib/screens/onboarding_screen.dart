import 'package:flutter/material.dart';

// A welcome screen using a Scaffold with the title
// 'Welcome to the app' and a button to navigate to the home page
class OnboardingScreen extends StatelessWidget {
  const OnboardingScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          const Text('Welcome to this app'),
          ElevatedButton(
            onPressed: () {
              Navigator.pushNamed(context, '/home');
            },
            child: const Text('Go to Home'),
          ),
        ],
      ),
    );
  }
}
