import 'package:flutter/material.dart';
import 'package:coffee_app/utils/auth_service.dart';
import 'package:coffee_app/components/input_field.dart';
import 'package:coffee_app/components/custom_button.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(
            seedColor: const Color.fromARGB(255, 247, 6, 243)),
        useMaterial3: true,
      ),
      home: const MainScreen(title: 'Login'),
    );
  }
}

class MainScreen extends StatefulWidget {
  const MainScreen({super.key, required this.title});

  final String title;

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  void _login(BuildContext context) {
    String email = emailController.text;
    String password = passwordController.text;

    AuthService.login(email, password).then((response) {
      if (response.jwt != '') {
        // Show snackbar with JWT token
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('JWT token: ${response.jwt}')),
        );
      } else {
        // Show snackbar with error message
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text(response.message ?? 'Login failed')),
        );
      }
    }).catchError((error) {
      // Show snackbar with error message
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Error occurred during login: $error')),
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(
          gradient: RadialGradient(
            colors: [Color.fromARGB(255, 252, 215, 175), Colors.white],
            center: Alignment.bottomCenter,
            radius: 1.5,
          ),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            const Padding(
              padding: EdgeInsets.only(left: 20.0, top: 80.0, right: 20.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Text(
                    'COFFE STAMP APP',
                    style: TextStyle(
                      color: Color.fromARGB(255, 0, 0, 0),
                      fontSize: 12.0,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  Text(
                    'appriciate',
                    style: TextStyle(
                      letterSpacing: -3,
                      color: Color.fromARGB(255, 0, 0, 0),
                      fontSize: 56.0,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ],
              ),
            ),
            Container(
              margin: const EdgeInsets.only(left: 20, top: 10, right: 20),
              decoration: const BoxDecoration(
                border: Border(
                  bottom: BorderSide(width: 1.0, color: Colors.black),
                ),
              ),
            ),
            const Expanded(
              child:
                  SizedBox(), // Empty SizedBox to push the following Column to the bottom
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Padding(
                  padding: const EdgeInsets.only(
                      left: 20.0, bottom: 80.0, right: 20.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      const Text(
                        '057c',
                        style: TextStyle(
                          letterSpacing: -10,
                          color: Color.fromARGB(255, 0, 0, 0),
                          fontSize: 156.0,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                      InputField(
                        labelText: 'Email',
                        controller: emailController, // Set the controller here
                      ),
                      InputField(
                        labelText: 'Password',
                        controller:
                            passwordController, // Set the controller here
                      ),
                      const SizedBox(height: 16.0),
                      CustomButton(
                        variant: ButtonVariant.outlined,
                        text: 'Login',
                        onClick: () => _login(context),
                      )
                    ],
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
