import 'package:flutter/material.dart';
import 'patient_list_screen.dart'; // Import the patient list screen
import 'add_patient_screen.dart'; // Import the add patient screen

class HomePage extends StatelessWidget {
  final String token;

  HomePage({required this.token});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Centen Hospital App'),
      ),
      body: Container(
        padding: EdgeInsets.all(20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text(
              'Welcome to Centen Hospital App',
              style: TextStyle(
                fontSize: 24.0,
                fontWeight: FontWeight.bold,
                color: Colors.blueAccent,
              ),
            ),
            SizedBox(height: 10.0),
            Text(
              'Your trusted healthcare companion',
              style: TextStyle(
                fontSize: 16.0,
                fontStyle: FontStyle.italic,
                color: Colors.grey[600],
              ),
            ),
            // Add more widgets here...
          ],
        ),
      ),
      drawer: Drawer(
        child: ListView(
          padding: EdgeInsets.zero,
          children: <Widget>[
            DrawerHeader(
              decoration: BoxDecoration(
                color: Colors.blue,
              ),
              child: Text(
                'Menu',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 24,
                ),
              ),
            ),
            ListTile(
              title: Text('Patient List'),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => PatientListScreen(),
                  ),
                );
              },
            ),
            ListTile(
              title: Text('Add Patient'), // New ListTile for Add Patient
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) =>
                        AddPatientScreen(), // Navigate to Add Patient screen
                  ),
                );
              },
            ),
            // Add more ListTile items for other options in the drawer
          ],
        ),
      ),
    );
  }
}
