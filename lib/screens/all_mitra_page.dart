import 'dart:convert';

import 'package:centrii_user/screens/detail_mitra.dart';
import 'package:centrii_user/services/mitra_service.dart';
import 'package:flutter/material.dart';

class AllMitraPage extends StatefulWidget {
  const AllMitraPage({Key? key}) : super(key: key);

  @override
  State<AllMitraPage> createState() => _AllMitraPageState();
}

class _AllMitraPageState extends State<AllMitraPage> {
  List<String> options = [
    'Sidoarjo, Jawa Timur',
    'Surabaya, Jawa Timur',
    'Malang, Jawa Timur'
  ];
  String selectedOption = 'Sidoarjo, Jawa Timur';
  List<Map<String, dynamic>> mitra = [];

  @override
  void initState() {
    super.initState();
    fetchMitra();
  }

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
                padding: const EdgeInsets.fromLTRB(0.0, 30.0, 0.0, 10.0),
                child: Text(
                  'Mitra yang bekerja sama',
                  style: TextStyle(
                    fontSize: 20.0,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              SizedBox(height: 10.0),
              buildStyledDropdown(),
              SizedBox(height: 20.0),
              buildMitraCards(),
            ],
          ),
        ),
      ),
    );
  }

  Widget buildStyledDropdown() {
    return Container(
      width: double.infinity,
      padding: EdgeInsets.symmetric(horizontal: 10.0),
      decoration: BoxDecoration(
        color: Color(0xFFFFB800),
        borderRadius: BorderRadius.circular(10.0),
      ),
      child: DropdownButton<String>(
        value: selectedOption,
        items: options.map((String option) {
          return DropdownMenuItem<String>(
            value: option,
            child: Text(
              option,
              style: TextStyle(
                color: Colors.black,
                fontWeight: FontWeight.bold,
              ),
            ),
          );
        }).toList(),
        onChanged: (String? newValue) {
          setState(() {
            selectedOption = newValue!;
          });
        },
        style: TextStyle(
          color: Colors.black,
        ),
        icon: Icon(
          Icons.arrow_drop_down,
          color: Colors.black,
        ),
        underline: Container(),
      ),
    );
  }

  Widget buildMitraCards() {
    return Column(
      children: mitra.map((data) {
        return buildCardContainer(
          name: data['name'],
          address: data['address'],
          imageUrl: 'https://api.centrii.com/assets/${data['profile']}',
        );
      }).toList(),
    );
  }

  Widget buildCardContainer({
    required String name,
    required String address,
    required String imageUrl,
  }) {
    return GestureDetector(
      onTap: navigateToDetailMitraPage,
      child: Container(
        height: 250,
        width: double.infinity,
        padding: EdgeInsets.symmetric(horizontal: 10.0),
        margin: EdgeInsets.only(bottom: 20.0),
        decoration: BoxDecoration(
          color: Color(0xFFFFB800),
          borderRadius: BorderRadius.circular(20.0),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.fromLTRB(0.0, 10.0, 0.0, 0.0),
              child: Container(
                height: 160.0,
                decoration: BoxDecoration(
                  image: DecorationImage(
                    image: NetworkImage(imageUrl),
                    fit: BoxFit.cover,
                  ),
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
                    name,
                    style: TextStyle(
                      fontSize: 18.0,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                  SizedBox(height: 4.0),
                  Row(
                    children: [
                      Icon(
                        Icons.location_on,
                        color: Colors.white,
                        size: 16.0,
                      ),
                      SizedBox(width: 4.0),
                      Text(
                        address,
                        style: TextStyle(
                          fontSize: 14.0,
                          color: Colors.white,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Future<void> navigateToDetailMitraPage() async {
    final route = MaterialPageRoute(builder: (context) => DetailMitraPage());

    await Navigator.push(context, route);
  }

  Future<void> fetchMitra() async {
    final response = await MitraService.get();
    final List<Map<String, dynamic>> responseData =
        List<Map<String, dynamic>>.from(jsonDecode(response)['data']);

    setState(() {
      mitra = responseData;
    });
  }
}
