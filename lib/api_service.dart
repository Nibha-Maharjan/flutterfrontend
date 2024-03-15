// api_service.dart
// **** NOT IN USE ****
import 'dart:convert';
import 'package:http/http.dart' as http;

class ApiService {
  static final String baseUrl = 'http://localhost:3000';

  static Future<bool> login(String email, String password) async {
    try {
      final response = await http.post(
        Uri.parse('$baseUrl/sign-in'),
        headers: {
          'Content-Type': 'application/json',
        },
        body: jsonEncode({
          'email': email,
          'password': password,
        }),
      );

      if (response.statusCode == 200) {
        // Handle successful login here
        return true;
      } else {
        // Handle login failure
        print('Login failed. Status code: ${response.statusCode}');
        print('Response body: ${response.body}');
        return false;
      }
    } catch (e) {
      // Handle exception
      print('Error during login: $e');
      return false;
    }
  }

  static Future<bool> register(
    String name,
    String email,
    String password,
  ) async {
    try {
      final response = await http.post(
        Uri.parse('$baseUrl/create-user'),
        headers: {
          'Content-Type': 'application/json',
        },
        body: jsonEncode({
          'fullname': name,
          'email': email,
          'password': password,
        }),
      );

      if (response.statusCode == 200) {
        // Handle successful registration here
        return true;
      } else {
        // Handle registration failure
        print('Registration failed. Status code: ${response.statusCode}');
        print('Response body: ${response.body}');
        return false;
      }
    } catch (e) {
      // Handle exception
      print('Error during registration: $e');
      return false;
    }
  }
}
