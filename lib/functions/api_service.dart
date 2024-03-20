import 'package:http/http.dart' as http;
import 'crypto_tracker.dart';

Future<List<CryptoTracker>?> trackerData() async {
  String apiEndpoint =
      "https://api.coingecko.com/api/v3/coins/markets?vs_currency=usd&order=market_cap_desc&per_page=100&page=1&sparkline=false";
  var url = Uri.parse(apiEndpoint);
  var response = await http.get(url);
  if (response.statusCode == 200) {
    var res = response.body;
    List<CryptoTracker> cryptoList = cryptoTrackerFromJson(res);
  
    return cryptoList;
  } else {
    return null;
  }
}
