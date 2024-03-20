import 'package:crypto_price/pages/currency_prices.dart';
import 'package:crypto_price/pages/wrongpath/wrong_path_view.dart';
import 'package:crypto_price/pages/home.dart';

import 'package:flutter/material.dart';

class RouteGenerator {
  static Route<dynamic> onGenerateRoute(RouteSettings settings) {
    switch (settings.name) {
      case '/':
        return MaterialPageRoute(
          settings: settings,
          builder: (_) => const HomePage(),
        );
      
     
      case '/crypto_detail':
        return MaterialPageRoute(
          settings: settings,
          builder: (_) => const WebsocketDemo(),
        );

      default:
        return MaterialPageRoute(
          settings: settings,
          builder: (_) => const WrongPathView(),
        );
    }
  }
}
