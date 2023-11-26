import 'dart:convert';

import 'package:centrii_user/services/promo_service.dart';
import 'package:centrii_user/services/service_service.dart';
import 'package:flutter/material.dart';

import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class DashboardPage extends StatefulWidget {
  const DashboardPage({Key? key}) : super(key: key);

  @override
  State<DashboardPage> createState() => _DashboardPageState();
}

class _DashboardPageState extends State<DashboardPage> {
  List promo = [];
  List service = [];

  @override
  void initState() {
    super.initState();
    fetchPromo();
    fetchService();
    CheckToken();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFFFFFFFF),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.fromLTRB(25.0, 60.0, 25.0, 20.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Container(
                    width: 250.0,
                    child: Padding(
                      padding: const EdgeInsets.fromLTRB(0.0, 10.0, 0.0, 0.0),
                      child: Text(
                        'Selamat Datang di Centri.id, Qalbi',
                        style: TextStyle(
                          fontSize: 18.0,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.fromLTRB(0.0, 25.0, 0.0, 0.0),
                    child: IconButton(
                      icon: Icon(Icons.notifications),
                      onPressed: () {
                        // Handle notification icon tap
                      },
                    ),
                  ),
                ],
              ),
              SizedBox(height: 20.0),
              Container(
                width: double.infinity,
                padding: EdgeInsets.all(16.0),
                decoration: BoxDecoration(
                  color: Color(0xFF06D6A0),
                  borderRadius: BorderRadius.circular(10.0),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Container(
                      width: 30.0,
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
                      width: 30.0,
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
              SizedBox(height: 20.0),
              Padding(
                padding: const EdgeInsets.fromLTRB(0.0, 0.0, 0.0, 10.0),
                child: Text(
                  'Promo',
                  style: TextStyle(
                    fontSize: 20.0,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              SizedBox(
                height: 150.0,
                child: ListView.builder(
                  scrollDirection: Axis.horizontal,
                  itemCount: promo.length,
                  itemExtent:
                      300.0, // Adjust this value based on the spacing you want
                  itemBuilder: (context, index) {
                    final item = promo[index] as Map;
                    return Padding(
                      padding: EdgeInsets.only(
                          right: 16.0), // Adjust right padding for spacing
                      child: buildCardPromo(item),
                    );
                  },
                ),
              ),
              SizedBox(height: 20.0),
              Padding(
                padding: const EdgeInsets.fromLTRB(0.0, 0.0, 0.0, 0.0),
                child: Text(
                  'Layanan Kami',
                  style: TextStyle(
                    fontSize: 20.0,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              SizedBox(
                child: GridView.builder(
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 3,
                      mainAxisSpacing: 10.0,
                      crossAxisSpacing: 10.0),
                  itemCount: service.length,
                  shrinkWrap: true,
                  physics: NeverScrollableScrollPhysics(),
                  itemBuilder: (context, index) {
                    final item = service[index] as Map;
                    return buildCard(item['name']);
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget buildCardPromo(Map<dynamic, dynamic> item) {
    final String photoUrl = "https://api.centrii.com/assets/${item['photo']}";

    return Container(
      width: 280.0,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10.0),
        image: DecorationImage(
          alignment: Alignment.bottomLeft,
          opacity: 30.0,
          image: NetworkImage(photoUrl),
          fit: BoxFit.cover,
        ),
      ),
      child: Padding(
        padding: EdgeInsets.all(16.0),
        child: Container(
          width: double.infinity,
          margin: EdgeInsets.fromLTRB(0.0, 50.0, 130.0, 0.0),
          decoration: BoxDecoration(
            color: Color(0xFFFFB800),
            borderRadius: BorderRadius.circular(10.0),
          ),
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Text(
                  item['code'],
                  style: TextStyle(
                    fontSize: 15.0,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
                SizedBox(height: 4.0),
                Text(
                  "${item['percent']}% Off",
                  style: TextStyle(
                    fontSize: 12.0,
                    color: Colors.white,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget buildCard(String title) {
    return Container(
      width: 280.0,
      decoration: BoxDecoration(
        color: Color(0xFF06D6A0),
        borderRadius: BorderRadius.circular(10.0),
      ),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              Icons.shopping_cart_checkout,
              size: 30.0,
              color: Colors.white,
            ),
            SizedBox(height: 8.0),
            Text(
              title,
              style: TextStyle(
                fontSize: 13.0,
                fontWeight: FontWeight.bold,
                color: Colors.white,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Future<void> fetchPromo() async {
    final response = await PromoService.get();
    final Map<String, dynamic> responseData = jsonDecode(response);

    setState(() {
      promo = responseData['data'];
    });
  }

  Future<void> fetchService() async {
    final response = await ServiceService.getFiltered();
    final Map<String, dynamic> responseData = jsonDecode(response);

    setState(() {
      service = responseData['data'];
    });
  }

  void CheckToken() async {
    // Create storage
    final storage = new FlutterSecureStorage();

    String? value = await storage.read(key: "CERT");
    print(value);
  }
}
