import 'package:flutter/material.dart';

class DashboardPage extends StatefulWidget {
  const DashboardPage({super.key});

  @override
  State<DashboardPage> createState() => _DashboardPageState();
}

class _DashboardPageState extends State<DashboardPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFFFFFFFF),
      body: Padding(
        padding: const EdgeInsets.fromLTRB(40.0, 40.0, 40.0, 20.0),
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Container(
                  width: 250.0,
                  child: Padding(
                    padding: const EdgeInsets.fromLTRB(0.0, 7.0, 0.0, 0.0),
                    child: Text(
                      'Selamat Datang di Centri.id, Qalbi',
                      style: TextStyle(
                        fontSize: 18.0,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),
                IconButton(
                  icon: Icon(Icons.notifications),
                  onPressed: () {
                    // Handle notification icon tap
                  },
                ),
              ],
            ),
            SizedBox(height: 20.0),
            Container(
              width: double.infinity,
              padding: EdgeInsets.all(16.0),
              decoration: BoxDecoration(
                color: Colors.green,
                borderRadius: BorderRadius.circular(10.0),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Container(
                    width: 50.0,
                    child: Padding(
                      padding: const EdgeInsets.fromLTRB(0.0, 7.0, 0.0, 0.0),
                      child: Icon(
                        Icons.check_circle,
                        color: Colors.white,
                        size: 30.0,
                      ),
                    ),
                  ),
                  Container(
                    width: 200.0,
                    child: Column(
                      children: [
                        Padding(
                          padding:
                              const EdgeInsets.fromLTRB(0.0, 7.0, 0.0, 0.0),
                          child: Text(
                            'Laundry kamu udah selesai!',
                            style: TextStyle(
                              fontSize: 15.0,
                              fontWeight: FontWeight.bold,
                              color: Colors.white,
                            ),
                          ),
                        ),
                        Padding(
                          padding:
                              const EdgeInsets.fromLTRB(0.0, 7.0, 0.0, 0.0),
                          child: Text(
                            'Lagi otw dianter nih!',
                            style: TextStyle(
                              fontSize: 14.0,
                              fontWeight: FontWeight.bold,
                              color: Colors.white,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  Container(
                    width: 50.0,
                    child: Padding(
                      padding: const EdgeInsets.fromLTRB(0.0, 7.0, 0.0, 0.0),
                      child: Icon(
                        Icons.cancel,
                        color: Colors.white,
                        size: 30.0,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
