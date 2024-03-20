
import 'package:flutter/material.dart';

import 'package:crypto_price/pages/home.dart';
import "package:crypto_price/routes/routes_app.dart";

void main() {
  runApp(const MaterialApp(
      debugShowCheckedModeBanner: false,
      home: HomePage(),
      initialRoute: '/',
      onGenerateRoute: RouteGenerator.onGenerateRoute,
      ));
}
