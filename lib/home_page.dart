// home_page.dart
import 'package:flutter/material.dart';

class HomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Hospital Dashboard'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              'Welcome to the Hospital Dashboard!',
              style: TextStyle(fontSize: 20),
            ),
            // Add more UI components as needed
          ],
        ),
      ),
    );
  }
}
