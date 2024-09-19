import 'package:flutter/material.dart';

class SecondScreen extends StatelessWidget {
  const SecondScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      appBar: AppBar(
        foregroundColor: Colors.white,
        backgroundColor: Colors.redAccent,
        title: const Text('Second Screen',),
      ),
      body: const Center(
        child: SingleChildScrollView(
          child: Column(
            children: [
              Text('Navigated from Notification')
            ],
          ),
        ),
      ),
    );
  }
}
