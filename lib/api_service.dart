// api_service.dart
import 'dart:convert';
import 'package:http/http.dart' as http;

class ApiService {
  static final String baseUrl = 'http://10.0.0.22:3000';

  static Future<bool> login(String email, String password) async {
    try {
      final response = await http.post(
        Uri.parse('$baseUrl/sign-in'),
        headers: {
          'Content-Type': 'application/json',
          'Accept': 'application/json',
        },
        body: jsonEncode({
          'email': email,
          'password': password,
        }),
      );

      if (response.statusCode == 200) {
        // Parse response if needed
        // You may want to handle successful login
        return true;
      } else {
        // Handle error
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
          'Accept': 'application/json',
        },
        body: jsonEncode(
            {'fullname': name, 'email': email, 'password': password}),
      );

      if (response.statusCode == 200) {
        // Parse response if needed
        // You may want to log in the user after successful registration
        return true;
      } else {
        // Handle error
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
