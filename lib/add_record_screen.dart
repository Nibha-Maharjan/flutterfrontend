import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class AddRecordScreen extends StatefulWidget {
  @override
  _AddRecordScreenState createState() => _AddRecordScreenState();
}

class _AddRecordScreenState extends State<AddRecordScreen> {
  final TextEditingController _dateTimeController = TextEditingController();
  final TextEditingController _bloodPressureController =
      TextEditingController();
  final TextEditingController _respiratoryRateController =
      TextEditingController();
  final TextEditingController _bloodOxygenLevelController =
      TextEditingController();
  final TextEditingController _heartBeatRateController =
      TextEditingController();

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  late List<Map<String, dynamic>> _patients = [];
  late String _selectedPatient = '';

  @override
  void initState() {
    super.initState();
    fetchPatients();
  }

  Future<void> fetchPatients() async {
    final response = await http.get(Uri.parse('http://localhost:3000/patient'));
    if (response.statusCode == 200) {
      setState(() {
        _patients = List<Map<String, dynamic>>.from(json.decode(response.body));
        if (_patients.isNotEmpty) {
          _selectedPatient = _patients.first['_id'];
        }
      });
    } else {
      throw Exception('Failed to load patients');
    }
  }

  void _saveRecord() {
    if (_formKey.currentState!.validate()) {
      // All fields are valid, proceed to save record
      final recordData = {
        'dateTime': _dateTimeController.text,
        'vitalSigns': {
          'bloodPressure': _bloodPressureController.text,
          'respiratoryRate': _respiratoryRateController.text,
          'bloodOxygenLevel': _bloodOxygenLevelController.text,
          'heartBeatRate': _heartBeatRateController.text,
        },
      };

      // Send the recordData to your server
      http.post(
        Uri.parse('http://localhost:3000/patient/$_selectedPatient/records'),
        body: json.encode(recordData),
        headers: {'Content-Type': 'application/json'},
      ).then((response) {
        // Display confirmation message
        showDialog(
          context: context,
          builder: (BuildContext context) {
            return AlertDialog(
              title: Text('Record Added'),
              content: Text('The record has been successfully added.'),
              actions: [
                TextButton(
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                  child: Text('OK'),
                ),
              ],
            );
          },
        );
      }).catchError((error) {
        // Display error message if request fails
        showDialog(
          context: context,
          builder: (BuildContext context) {
            return AlertDialog(
              title: Text('Error'),
              content: Text('Failed to add record: $error'),
              actions: [
                TextButton(
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                  child: Text('OK'),
                ),
              ],
            );
          },
        );
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Add Record'),
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              if (_patients.isEmpty)
                Center(child: CircularProgressIndicator())
              else
                DropdownButtonFormField<String>(
                  value: _selectedPatient,
                  onChanged: (value) {
                    setState(() {
                      _selectedPatient = value!;
                    });
                  },
                  items: _patients.map<DropdownMenuItem<String>>((patient) {
                    return DropdownMenuItem<String>(
                      value: patient['_id'],
                      child: Text(patient['name']),
                    );
                  }).toList(),
                  decoration: InputDecoration(
                    labelText: 'Select Patient',
                    border: OutlineInputBorder(),
                  ),
                  validator: (value) {
                    if (value == null) {
                      return 'Please select a patient';
                    }
                    return null;
                  },
                ),
              SizedBox(height: 16.0),
              TextFormField(
                controller: _dateTimeController,
                decoration: InputDecoration(
                  labelText: 'Date Time',
                  border: OutlineInputBorder(),
                ),
                validator: (value) {
                  if (value!.isEmpty) {
                    return 'Please enter a date time';
                  }
                  return null;
                },
              ),
              SizedBox(height: 16.0),
              TextFormField(
                controller: _bloodPressureController,
                decoration: InputDecoration(
                  labelText: 'Blood Pressure',
                  border: OutlineInputBorder(),
                ),
                keyboardType: TextInputType.number,
                validator: (value) {
                  if (value!.isEmpty) {
                    return 'Please enter a blood pressure';
                  }
                  // Add additional validation if needed
                  return null;
                },
              ),
              SizedBox(height: 16.0),
              TextFormField(
                controller: _respiratoryRateController,
                decoration: InputDecoration(
                  labelText: 'Respiratory Rate',
                  border: OutlineInputBorder(),
                ),
                keyboardType: TextInputType.number,
                validator: (value) {
                  if (value!.isEmpty) {
                    return 'Please enter a respiratory rate';
                  }
                  // Add additional validation if needed
                  return null;
                },
              ),
              SizedBox(height: 16.0),
              TextFormField(
                controller: _bloodOxygenLevelController,
                decoration: InputDecoration(
                  labelText: 'Blood Oxygen Level',
                  border: OutlineInputBorder(),
                ),
                keyboardType: TextInputType.number,
                validator: (value) {
                  if (value!.isEmpty) {
                    return 'Please enter a blood oxygen level';
                  }
                  // Add additional validation if needed
                  return null;
                },
              ),
              SizedBox(height: 16.0),
              TextFormField(
                controller: _heartBeatRateController,
                decoration: InputDecoration(
                  labelText: 'Heart Beat Rate',
                  border: OutlineInputBorder(),
                ),
                keyboardType: TextInputType.number,
                validator: (value) {
                  if (value!.isEmpty) {
                    return 'Please enter a heart beat rate';
                  }
                  // Add additional validation if needed
                  return null;
                },
              ),
              SizedBox(height: 16.0),
              ElevatedButton(
                onPressed: _saveRecord,
                child: Text('Save Record'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
