import 'package:flutter/material.dart';
import 'package:crypto_price/functions/crypto_pairs.dart';

class CryptoCard extends StatelessWidget {
  final String name;

  const CryptoCard({
    Key? key,
    required this.name,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    String pairDescription = cryptoPairs[name] ?? ''; // Get the description from cryptoPairs

    return GestureDetector(
      onTap: () {
        Navigator.pushNamed(
          context,
          '/crypto_detail',
          arguments: {'name': name}, // Pass arguments here
        );
      },
      child: Padding(
        padding: const EdgeInsets.all(8.0), // Adding padding around the card
        child: Container(
          height: 120, // Increasing the height of the card
          decoration: BoxDecoration(
            color: Colors.grey,
            borderRadius: BorderRadius.circular(20),
          ),
          child: Column(
            mainAxisSize: MainAxisSize.max,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.all(8.0), // Adding padding around the text
                child: FittedBox(
                  fit: BoxFit.scaleDown,
                  child: Text(
                    name,
                    style: TextStyle(
                      color: Colors.grey[900],
                      fontSize: 25,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 8.0), // Adding horizontal padding around the text
                child: Text(
                  pairDescription,
                  style: TextStyle(
                    color: Colors.grey[900],
                    fontSize: 20,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
