import 'package:centrii_user/screens/login_page.dart';
import 'package:flutter/material.dart';

import 'package:centrii_user/services/auth_service.dart';

class RegistrationPage extends StatefulWidget {
  const RegistrationPage({super.key});

  @override
  State<RegistrationPage> createState() => _RegistrationPageState();
}

class _RegistrationPageState extends State<RegistrationPage> {
  TextEditingController nameController = TextEditingController();
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
                  controller: nameController,
                  decoration: const InputDecoration(
                    hintText: 'Name',
                    icon: Icon(
                      Icons.account_circle_rounded,
                    ),
                  ),
                ),
                const SizedBox(height: 20),
                TextField(
                  controller: emailController,
                  decoration: InputDecoration(
                    hintText: 'Email',
                    icon: Icon(
                      Icons.email,
                    ),
                    // Underline extends under the email icon
                    prefixIconConstraints: BoxConstraints(
                      minWidth: 40,
                    ),
                  ),
                ),
                const SizedBox(height: 20),
                TextField(
                  controller: passwordController,
                  decoration: InputDecoration(
                    hintText: 'Password',
                    icon: Icon(
                      Icons.lock,
                    ),
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
                    // Underline extends under the password icon
                    prefixIconConstraints: BoxConstraints(
                      minWidth: 40,
                    ),
                  ),
                  obscureText: !showPassword,
                ),
                const SizedBox(height: 20),
                ElevatedButton(
                  onPressed: submitData,
                  child: const Text('REGISTER'),
                  style: ButtonStyle(
                    fixedSize: MaterialStateProperty.all<Size>(
                      const Size(200.0, 50.0),
                    ),
                    shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                      RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10.0),
                      ),
                    ),
                    backgroundColor: MaterialStateProperty.all<Color>(
                      Color(0xFFFFB800),
                    ),
                  ),
                ),
                const SizedBox(height: 20),
                Align(
                  alignment: Alignment.center,
                  child: GestureDetector(
                    onTap: () async {
                      await navigateToLoginPage();
                    },
                    child: Text(
                      'Already have account? Sign In Now!',
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
    final name = nameController.text;
    final email = emailController.text;
    final password = passwordController.text;
    final route = MaterialPageRoute(builder: (context) => LoginPage());

    final isSuccess = await AuthService.register(name, email, password);
    if (isSuccess) {
      await Navigator.push(context, route);
    } else {
      print("failed");
    }
  }

  Future<void> navigateToLoginPage() async {
    final route = MaterialPageRoute(builder: (context) => LoginPage());

    await Navigator.push(context, route);
  }
}
