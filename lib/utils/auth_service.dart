import 'dart:async';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:flutter_dotenv/flutter_dotenv.dart';

class User {
  final int id;
  final String username;
  final String email;
  final String provider;
  final bool confirmed;
  final bool blocked;
  final String createdAt;
  final String updatedAt;

  User(this.id, this.username, this.email, this.provider, this.confirmed,
      this.blocked, this.createdAt, this.updatedAt);
}

class LoginResponse {
  final String? jwt;
  final User? user;
  final String? message;

  LoginResponse({this.jwt, this.user, this.message});
}

class AuthService {
  static late String _backendUrl;
  static bool _initialized = false;

  static Future<void> initialize() async {
    if (!_initialized) {
      await dotenv.load(fileName: ".env");
      _backendUrl = dotenv.env['BACKEND_URL'] ?? '';
      _initialized = true;
    }
  }

  static Future<LoginResponse> login(String email, String password) async {
    if (!_initialized) {
      await initialize(); // Ensure initialization before proceeding
    }

    // Define the login endpoint
    String loginEndpoint = '$_backendUrl/auth/local';
    print(loginEndpoint);

    // Prepare the request body
    Map<String, String> requestBody = {
      'identifier': email,
      'password': password,
    };

    try {
      // Make the POST request to the login endpoint
      http.Response response = await http.post(
        Uri.parse(loginEndpoint),
        body: requestBody,
      );

      // Parse the response JSON
      Map<String, dynamic> responseBody = json.decode(response.body);

      // Check if the response contains a JWT token
      if (response.statusCode == 200 && responseBody.containsKey('jwt')) {
        // Extract user data from the response
        Map<String, dynamic> userData = responseBody['user'];

        int id = userData['id'];
        String username = userData['username'];
        String email = userData['email'];
        String provider = userData['provider'];
        bool confirmed = userData['confirmed'];
        bool blocked = userData['blocked'];
        String createdAt = userData['createdAt'];
        String updatedAt = userData['updatedAt'];
        String jwt = responseBody['jwt'];

        // Create a User object
        User loggedInUser = User(id, username, email, provider, confirmed,
            blocked, createdAt, updatedAt);

        // Return a successful login response with user data and JWT token
        return LoginResponse(jwt: jwt, user: loggedInUser);
      } else {
        // Extract error message from the response
        String? errorMessage = responseBody['message'];

        // Return a failed login response with the error message
        return LoginResponse(message: errorMessage);
      }
    } catch (error) {
      // Return a failed login response with the error message
      return LoginResponse(message: 'Error occurred during login: $error');
    }
  }
}
