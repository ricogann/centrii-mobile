import 'package:centrii_user/screens/login_page.dart';
import 'package:flutter/material.dart';

import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:centrii_user/screens/main_page.dart';

class LandingPage extends StatefulWidget {
  const LandingPage({super.key});

  @override
  State<LandingPage> createState() => _LandingPageState();
}

class _LandingPageState extends State<LandingPage>
    with TickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _slideAnimation;

  @override
  void initState() {
    super.initState();
    CheckToken();
    _controller = AnimationController(
      vsync: this,
      duration: Duration(seconds: 1),
    )..repeat(reverse: true); // Repeat the animation in both directions

    _slideAnimation = Tween<double>(begin: 0, end: 20).animate(_controller);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFFFFB800), // Set the background color to #FFB800
      body: Padding(
        padding: const EdgeInsets.fromLTRB(20.0, 40.0, 20.0, 20.0),
        child: Stack(
          children: [
            // Logo at the top left
            Align(
              alignment: Alignment.topLeft,
              child: Padding(
                padding: const EdgeInsets.fromLTRB(10.0, 50.0, 10.0, 10.0),
                child: Image.asset(
                  'lib/assets/logo.png',
                  width: 100,
                  height: 100,
                ),
              ),
            ),
            // Text in the middle
            Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Text(
                    'WELCOME TO OUR CENTRII.ID',
                    style: TextStyle(
                      color: Color(0xFF3DB9FF), // Set text color to white
                      fontSize: 32.0,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.fromLTRB(0.0, 5.0, 0.0, 0.0),
                    child: Text(
                      'TRACKING SEPATU, TANPA BATASAN WAKTU DAN TEMPAT',
                      style: TextStyle(
                        color: Colors.white, // Set text color to white
                        fontSize: 16.0,
                        fontWeight: FontWeight.normal,
                      ),
                    ),
                  ),
                ],
              ),
            ),
            // Next icon at the bottom right
            Align(
              alignment: Alignment.bottomRight,
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: AnimatedBuilder(
                  animation: _controller,
                  builder: (context, child) {
                    return Transform.translate(
                      offset: Offset(_slideAnimation.value, 0),
                      child: IconButton(
                        icon: Icon(Icons.arrow_forward,
                            color: Colors.white, size: 40.0),
                        onPressed: navigateToLoginPage,
                      ),
                    );
                  },
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  void navigateToLoginPage() async {
    final route = MaterialPageRoute(builder: (context) => LoginPage());

    await Navigator.push(context, route);
  }

  void CheckToken() async {
    // Create storage
    final storage = new FlutterSecureStorage();

    String? value = await storage.read(key: "CERT");
    if (value != null) {
      navigateToMainPage();
    }
  }

  Future<void> navigateToMainPage() async {
    final route = MaterialPageRoute(builder: (context) => MainPage());

    await Navigator.push(context, route);
  }
}
