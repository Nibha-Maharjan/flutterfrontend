import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class CriticalPatientScreen extends StatefulWidget {
  @override
  _CriticalPatientScreenState createState() => _CriticalPatientScreenState();
}

class _CriticalPatientScreenState extends State<CriticalPatientScreen> {
  List<dynamic> criticalPatients = [];

  @override
  void initState() {
    super.initState();
    fetchCriticalPatients();
  }

  Future<void> fetchCriticalPatients() async {
    final response = await http
        .get(Uri.parse('http://localhost:3000/patient/critical-patients'));
    if (response.statusCode == 200) {
      setState(() {
        criticalPatients = json.decode(response.body);
      });
    } else {
      throw Exception('Failed to load critical patients');
    }
  }

  void handlePatientPress(dynamic patient) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => CriticalRecordScreen(patient: patient),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Critical Patients'),
      ),
      body: ListView.builder(
        itemCount: criticalPatients.length,
        itemBuilder: (BuildContext context, int index) {
          final patient = criticalPatients[index];
          return ListTile(
            title: Text(patient['name']),
            onTap: () {
              handlePatientPress(patient);
            },
          );
        },
      ),
    );
  }
}

class CriticalRecordScreen extends StatelessWidget {
  final dynamic patient;

  const CriticalRecordScreen({Key? key, required this.patient})
      : super(key: key);

  bool isCritical(String label, dynamic value) {
    switch (label) {
      case 'Blood Pressure':
        return value.contains('/') || value == 'High';
      case 'Respiratory Rate':
        return value < 12 || value > 25;
      case 'Blood Oxygen Level':
        return value < 90;
      case 'Heart Beat Rate':
        return value < 60 || value > 100;
      default:
        return false;
    }
  }

  Widget renderItemText(String label, dynamic value) {
    return Text(
      '$label: $value',
      style: TextStyle(
        fontSize: 18,
        color: isCritical(label, value) ? Colors.red : Colors.black,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    List<dynamic> records = patient['records'];

    return Scaffold(
      appBar: AppBar(
        title: Text('Critical Patient Records'),
      ),
      body: Column(
        children: [
          Padding(
            padding: EdgeInsets.symmetric(vertical: 20),
            child: Text(
              'Critical Patient Records',
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
          ),
          Expanded(
            child: ListView.builder(
              itemCount: records.length,
              itemBuilder: (BuildContext context, int index) {
                final record = records[index];
                return ListTile(
                  title: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      renderItemText('Date', record['dateTime']),
                      renderItemText('Blood Pressure',
                          record['vitalSigns']['bloodPressure']),
                      renderItemText('Respiratory Rate',
                          record['vitalSigns']['respiratoryRate']),
                      renderItemText('Blood Oxygen Level',
                          record['vitalSigns']['bloodOxygenLevel']),
                      renderItemText('Heart Beat Rate',
                          record['vitalSigns']['heartBeatRate']),
                    ],
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
