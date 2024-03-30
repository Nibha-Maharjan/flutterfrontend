import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class PatientRecordsScreen extends StatefulWidget {
  @override
  _PatientRecordsScreenState createState() => _PatientRecordsScreenState();
}

class _PatientRecordsScreenState extends State<PatientRecordsScreen> {
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
        title: Text('Patient Records'),
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
        title: Text('Patient Records'),
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

            SizedBox(height: 20),
            Text(
              'Patient Records:',
              style: TextStyle(fontSize: 20.0, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 10),
            renderItem(patient[
                'records']), // assuming 'records' is the field containing patient records
          ],
        ),
      ),
    );
  }

  Widget renderItem(List<dynamic> records) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: records.map((record) {
        return Container(
          margin: EdgeInsets.symmetric(vertical: 5),
          padding: EdgeInsets.all(10),
          decoration: BoxDecoration(
            border: Border.all(color: Colors.grey),
            borderRadius: BorderRadius.circular(5),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text('Date: ${record['dateTime']}'),
              Text('Blood Pressure: ${record['vitalSigns']['bloodPressure']}'),
              Text(
                  'Respiratory Rate: ${record['vitalSigns']['respiratoryRate']}'),
              Text(
                  'Blood Oxygen Level: ${record['vitalSigns']['bloodOxygenLevel']}'),
              Text('Heart Beat Rate: ${record['vitalSigns']['heartBeatRate']}'),
            ],
          ),
        );
      }).toList(),
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
