import 'package:flutter/material.dart';

class DetailLayananPage extends StatefulWidget {
  const DetailLayananPage({super.key});

  @override
  State<DetailLayananPage> createState() => _DetailLayananPageState();
}

class _DetailLayananPageState extends State<DetailLayananPage> {
  List<String> options = ['Option 1', 'Option 2', 'Option 3'];
  String selectedOption = 'Option 1';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFFFFFFFF),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.fromLTRB(40.0, 50.0, 40.0, 20.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.fromLTRB(0.0, 10.0, 0.0, 10.0),
                child: Text(
                  'Mitra yang bekerja sama',
                  style: TextStyle(
                    fontSize: 20.0,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              SizedBox(height: 10.0),
              buildCardContainer(),
              // Add the rest of your widgets or content here
            ],
          ),
        ),
      ),
      floatingActionButton: Container(
        width: double
            .infinity, // Make the container take full width// Add margin as needed
        child: FloatingActionButton.extended(
          onPressed: navigateToPayPage,
          label: const Text('BAYAR!'),
          backgroundColor: Color(0xFFFFB800),
        ),
      ),
    );
  }

  Widget buildCardContainer() {
    return GestureDetector(
      // onTap: navigateToDetailMitraPage,
      child: Container(
        height: 250,
        width: double.infinity,
        padding: EdgeInsets.symmetric(horizontal: 10.0),
        decoration: BoxDecoration(
          color: Color(0xFFFFB800),
          borderRadius: BorderRadius.circular(20.0),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start, // Align left
          children: [
            Padding(
              padding: const EdgeInsets.fromLTRB(0.0, 10.0, 0.0, 0.0),
              child: Container(
                height: 160.0,
                decoration: BoxDecoration(
                  color: Colors.blue, // Change color or use an image
                  borderRadius: BorderRadius.circular(20.0),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Title',
                    style: TextStyle(
                      fontSize: 16.0,
                      fontWeight: FontWeight.bold,
                      color: Colors.black,
                    ),
                  ),
                  SizedBox(height: 4.0),
                  Text(
                    'Description goes here',
                    style: TextStyle(
                      fontSize: 14.0,
                      color: Colors.black,
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

  void navigateToPayPage() {}
}
