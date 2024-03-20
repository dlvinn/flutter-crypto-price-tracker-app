import 'dart:convert';
List<CryptoTracker> cryptoTrackerFromJson(String str) => List<CryptoTracker>.from(
    json.decode(str).map((x) => CryptoTracker.fromJson(x)));
var cryptoList = [];
class CryptoTracker {
  CryptoTracker({
    required this.id,
    required this.symbol,
    required this.name,
    required this.image,
    required this.currentPrice,
    required this.marketCap,
  });
  String id;
  String symbol;
  String name;
  String image;
  num currentPrice;
  num marketCap;
  factory CryptoTracker.fromJson(Map<String, dynamic> json) => CryptoTracker(
        id: json["id"],
        symbol: json["symbol"],
        name: json["name"],
        image: json["image"],
        currentPrice: json["current_price"],
        marketCap: json["market_cap"],
      );
}