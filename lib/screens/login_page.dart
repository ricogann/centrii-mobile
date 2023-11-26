import 'dart:convert';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

import 'package:centrii_user/screens/main_page.dart';
import 'package:centrii_user/screens/registration_page.dart';
import 'package:centrii_user/services/auth_service.dart';
import 'package:flutter/material.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  bool showPassword = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFFFFFFFF),
      body: Padding(
        padding: const EdgeInsets.fromLTRB(20.0, 20.0, 20.0, 20.0),
        child: Center(
          child: Padding(
            padding: const EdgeInsets.fromLTRB(20.0, 0.0, 20.0, 0.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Padding(
                  padding: const EdgeInsets.fromLTRB(10.0, 0.0, 10.0, 10.0),
                  child: Image.asset(
                    'lib/assets/logo.png',
                    width: 150,
                    height: 150,
                  ),
                ),
                const SizedBox(height: 20),
                TextField(
                  controller: emailController,
                  decoration: const InputDecoration(hintText: 'Email'),
                ),
                const SizedBox(height: 20),
                TextField(
                  controller: passwordController,
                  decoration: InputDecoration(
                    hintText: 'Password',
                    suffixIcon: IconButton(
                      icon: Icon(
                        showPassword ? Icons.visibility : Icons.visibility_off,
                      ),
                      onPressed: () {
                        setState(() {
                          showPassword = !showPassword;
                        });
                      },
                    ),
                  ),
                  obscureText: !showPassword,
                ),
                const SizedBox(height: 20),
                Align(
                  alignment: Alignment.centerLeft,
                  child: GestureDetector(
                    onTap: () {
                      // Implement your logic for "Lupa password?" here
                    },
                    child: Text(
                      'Lupa password?',
                    ),
                  ),
                ),
                const SizedBox(height: 20),
                ElevatedButton(
                  onPressed: submitData,
                  child: const Text('LOGIN'),
                  style: ButtonStyle(
                    fixedSize: MaterialStateProperty.all<Size>(
                      const Size(200.0, 50.0), // Set the width and height
                    ),
                    shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                      RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(
                            10.0), // Set the border radius
                      ),
                    ),
                    backgroundColor: MaterialStateProperty.all<Color>(
                      Color(0xFFFFB800), // Set the button color
                    ),
                  ),
                ),
                const SizedBox(height: 20),
                Align(
                  alignment: Alignment.center,
                  child: GestureDetector(
                    onTap: () async {
                      await navigateToRegistrationPage();
                    },
                    child: Text(
                      'Don\'t have account? Sign Up Now!',
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Future<void> submitData() async {
    final email = emailController.text;
    final password = passwordController.text;
    final storage = new FlutterSecureStorage();

    final response = await AuthService.login(email, password);
    final Map<String, dynamic> responseData = json.decode(response);

    final bool isSuccess = responseData['status'];
    if (isSuccess) {
      await storage.write(key: 'CERT', value: responseData['token']);
      showResultDialog(context, "Login Successful", "Welcome back!");
      navigateToMainPage();
    } else {
      final String error = responseData['error'];
      showResultDialog(context, "Login Failed", error);
    }
  }

  Future<void> navigateToRegistrationPage() async {
    final route = MaterialPageRoute(builder: (context) => RegistrationPage());

    await Navigator.push(context, route);
  }

  Future<void> navigateToMainPage() async {
    final route = MaterialPageRoute(builder: (context) => MainPage());

    await Navigator.push(context, route);
  }

  void showResultDialog(BuildContext context, String title, String message) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text(title),
          content: Text(message),
          backgroundColor: Color(0xFFFFB800), // Set the background color
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10.0),
          ),
          titleTextStyle: TextStyle(
            color: Colors.white, // Set the title text color
            fontWeight: FontWeight.bold,
          ),
          contentTextStyle: TextStyle(
            color: Colors.white, // Set the content text color
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop(); // Close the dialog
              },
              child: Text(
                'OK',
                style: TextStyle(
                  color: Colors.white, // Set the button text color
                ),
              ),
            ),
          ],
        );
      },
    );
  }
}
