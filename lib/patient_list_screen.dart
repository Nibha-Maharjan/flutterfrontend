import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class PatientListScreen extends StatefulWidget {
  @override
  _PatientListScreenState createState() => _PatientListScreenState();
}

class _PatientListScreenState extends State<PatientListScreen> {
  List<dynamic> patients = [];
  List<dynamic> filteredPatients = [];
  TextEditingController searchController = TextEditingController();

  @override
  void initState() {
    super.initState();
    fetchPatients();
  }

  Future<void> fetchPatients() async {
    final response =
        await http.get(Uri.parse('http://localhost:3000/patient/'));
    if (response.statusCode == 200) {
      setState(() {
        patients = json.decode(response.body);
        filteredPatients = List.from(patients);
      });
    } else {
      throw Exception('Failed to load patients');
    }
  }

  void filterPatients(String query) {
    setState(() {
      filteredPatients = patients
          .where((patient) =>
              patient['name'].toLowerCase().contains(query.toLowerCase()))
          .toList();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Patient List'),
        actions: [
          IconButton(
            icon: Icon(Icons.search),
            onPressed: () {
              showSearch(
                  context: context,
                  delegate: _PatientSearchDelegate(filterPatients));
            },
          ),
        ],
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: TextField(
              controller: searchController,
              onChanged: (value) {
                filterPatients(value);
              },
              decoration: InputDecoration(
                labelText: 'Search by name',
                border: OutlineInputBorder(),
              ),
            ),
          ),
          Expanded(
            child: ListView.builder(
              itemCount: filteredPatients.length,
              itemBuilder: (BuildContext context, int index) {
                final patient = filteredPatients[index];
                return ListTile(
                  title: Text(patient['name']),
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) =>
                            PatientDetailsScreen(patient: patient),
                      ),
                    );
                  },
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}

class PatientDetailsScreen extends StatelessWidget {
  final dynamic patient;

  const PatientDetailsScreen({Key? key, required this.patient})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Patient Details'),
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Name: ${patient['name']}',
              style: TextStyle(fontSize: 18.0),
            ),
            Text(
              'Age: ${patient['age']}',
              style: TextStyle(fontSize: 18.0),
            ),
            Text(
              'Address: ${patient['address']}',
              style: TextStyle(fontSize: 18.0),
            ),
            Text(
              'Phone: ${patient['phone']}',
              style: TextStyle(fontSize: 18.0),
            ),
            Text(
              'Email: ${patient['email']}',
              style: TextStyle(fontSize: 18.0),
            ),
            Text(
              'Description: ${patient['description']}',
              style: TextStyle(fontSize: 18.0),
            ),
            Text(
              'Date: ${patient['date']}',
              style: TextStyle(fontSize: 18.0),
            ),
          ],
        ),
      ),
    );
  }
}

class _PatientSearchDelegate extends SearchDelegate<String> {
  final Function(String) filterPatients;

  _PatientSearchDelegate(this.filterPatients);

  @override
  List<Widget> buildActions(BuildContext context) {
    return [
      IconButton(
        icon: Icon(Icons.clear),
        onPressed: () {
          query = '';
        },
      ),
    ];
  }

  @override
  Widget buildLeading(BuildContext context) {
    return IconButton(
      icon: Icon(Icons.arrow_back),
      onPressed: () {
        close(context, '');
      },
    );
  }

  @override
  Widget buildResults(BuildContext context) {
    return Container(); // No need to implement for this example
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    return Container(); // No need to implement for this example
  }
}
