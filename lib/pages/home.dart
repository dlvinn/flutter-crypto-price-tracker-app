import 'dart:async';

import 'package:flutter/material.dart';
import '../functions/crypto_tracker.dart'; // Importing the CryptoTracker class
import 'package:crypto_price/functions/api_service.dart';
import 'crypto_card.dart';
import 'package:crypto_price/functions/crypto_pairs.dart';

class HomePage extends StatefulWidget {

  const HomePage({super.key});

  @override
  HomePageState createState() => HomePageState();
}

class HomePageState extends State<HomePage> {
  List<CryptoTracker>? cryptoList; // List to hold cryptocurrency data

  @override
  void initState() {

    super.initState();
    trackerData();
    Timer.periodic(const Duration(seconds: 4), (timer) => trackerData());

    super.initState();
    // Call the trackerData function when the widget is initialized
    trackerData().then((list) {
      setState(() {
        cryptoList = list;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('crypto price tracker'),
        centerTitle: true,
        backgroundColor: Color.fromARGB(255, 238, 233, 233),
        foregroundColor: Color.fromARGB(255, 36, 242, 0),
        elevation: 0.0,
        leading: GestureDetector(
          onTap: () {
            // Navigate to another route when the icon is clicked
            Navigator.pushNamed(context, '/setting');
          },
          child: const Icon(Icons.monetization_on_outlined),
        ),
      ),
      body: RefreshIndicator(
        onRefresh: trackerData,
        child:ListView.builder(
  itemCount: cryptoPairs.length, // Use the length of cryptoPairs
  itemBuilder: (context, index) {
    String pairKey = cryptoPairs.keys.elementAt(index); // Get the pair key
    return CryptoCard(
      name: pairKey, // Provide a default name
    );
  },
),
    )
    );
  }
}
