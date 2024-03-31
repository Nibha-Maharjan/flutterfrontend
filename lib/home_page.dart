import 'package:flutter/material.dart';
import 'patient_list_screen.dart'; // Import the patient list screen
import 'add_patient_screen.dart'; // Import the add patient screen
import 'PatientRecordScreen.dart';
import 'add_record_screen.dart'; // Import the patient record screen
import 'CriticalPatientScreen.dart';

class HomePage extends StatelessWidget {
  final String token;
  final String userEmail; // New field to accept user email

  HomePage(
      {required this.token, required this.userEmail}); // Updated constructor

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
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  CircleAvatar(
                    radius: 30,
                    backgroundColor: Colors.white,
                    // Placeholder image, you can replace this with the user's actual profile picture
                  ),
                  SizedBox(height: 10),
                  Text(
                    userEmail, // Use the userEmail passed from LoginPage
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 18,
                    ),
                  ),
                ],
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
              title: Text('Add Patient'),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => AddPatientScreen(),
                  ),
                );
              },
            ),
            ListTile(
              title: Text('Patient Records'),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => PatientRecordsScreen(),
                  ),
                );
              },
            ),
            ListTile(
              title: Text('Add Records'),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => AddRecordScreen(),
                  ),
                );
              },
            ),
            ListTile(
              title: Text('Critical Patients'),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => CriticalPatientScreen(),
                  ),
                );
              },
            ),
            ListTile(
              title: Text('Logout'),
              onTap: () {
                // Perform logout action here, such as clearing the token or any user data
                // Then navigate to the login screen
                Navigator.pushReplacementNamed(context, '/login');
              },
            ),
            // Add more ListTile items for other options in the drawer
          ],
        ),
      ),
    );
  }
}
