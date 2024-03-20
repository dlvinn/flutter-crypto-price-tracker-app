import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:web_socket_channel/io.dart';

class WebsocketDemo extends StatefulWidget {
  
  const WebsocketDemo({super.key});

  @override
  State<WebsocketDemo> createState() => _WebsocketDemoState();
}

class _WebsocketDemoState extends State<WebsocketDemo> {
    String crypto = '';

  String pair = "";
   String askPrice= "0";
   String askVolume= "0";
   String bidPrice= "0";
   String bidVolume= "0";
   String lastPrice= "0";
   String lastVolume= "0";
   String volumeToday= "0";
   String volumeLast24Hours= "0";
   String weightedAvgPriceToday= "0";
   String weightedAvgPriceLast24Hours= "0";
   int tradesToday= 0;
   int tradesLast24Hours= 0;
   String lowToday= "0";
   String lowLast24Hours= "0";
   String highToday= "0";
   String highLast24Hours= "0";
   String openToday= "0";
   String openLast24Hours= "0";
  late IOWebSocketChannel channel;
  late String subscriptionMessage;

  


 @override
void initState() {
  super.initState();
  channel = IOWebSocketChannel.connect('wss://ws.kraken.com/');
  streamListener();
}
String convertToPairFormat(String pair) {
  return pair.replaceAll('to', '/');
}

@override
void didChangeDependencies() {
  super.didChangeDependencies();
  final args = ModalRoute.of(context)?.settings.arguments as Map<String, String>?;
  if (args != null) {
    crypto = convertToPairFormat(args['name'] ?? '');
    print('the crypto: $crypto');
    subscriptionMessage = jsonEncode({
      "event": "subscribe",
      "pair": [crypto], // Specify the trading pair you're interested in
      "subscription": {
        "name": "ticker", // Specify the type of data you want to receive (e.g., ticker updates)
      }
    });
    print('the subscription message: $subscriptionMessage');
    // Send the subscription message to the WebSocket server
    channel.sink.add(subscriptionMessage);
  }
}

  
  streamListener() {
    channel.stream.listen((message) {
      // channel.sink.add('received!');
      // channel.sink.close(status.goingAway);
    var data = jsonDecode(message);
    if(data[2]=='ticker'){

    print(data);

       print(data[2]);
        setState(() {

askPrice = data[1]['a'][0];
print('Ask Price: $askPrice');

askVolume = data[1]['a'][2];
print('Ask Volume: $askVolume');

bidPrice = data[1]['b'][0];
print('Bid Price: $bidPrice');

bidVolume = data[1]['b'][2];
print('Bid Volume: $bidVolume');

lastPrice = data[1]['c'][0];
print('Last Price: $lastPrice');

lastVolume = data[1]['c'][1];
print('Last Volume: $lastVolume');

volumeToday = data[1]['v'][0];
print('Volume Today: $volumeToday');

volumeLast24Hours = data[1]['v'][1];
print('Volume Last 24 Hours: $volumeLast24Hours');

weightedAvgPriceToday = data[1]['p'][0];
print('Weighted Average Price Today: $weightedAvgPriceToday');

weightedAvgPriceLast24Hours = data[1]['p'][1];
print('Weighted Average Price Last 24 Hours: $weightedAvgPriceLast24Hours');

tradesToday = data[1]['t'][0];
print('Trades Today: $tradesToday');

tradesLast24Hours = data[1]['t'][1];
print('Trades Last 24 Hours: $tradesLast24Hours');

lowToday = data[1]['l'][0];
print('Low Today: $lowToday');

lowLast24Hours = data[1]['l'][1];
print('Low Last 24 Hours: $lowLast24Hours');

highToday = data[1]['h'][0];
print('High Today: $highToday');

highLast24Hours = data[1]['h'][1];
print('High Last 24 Hours: $highLast24Hours');

openToday = data[1]['o'][0];
print('Open Today: $openToday');

openLast24Hours = data[1]['o'][1];
print('Open Last 24 Hours: $openLast24Hours');
pair = data[3];
print('symbol: $pair');

        // event = getData['e'];
        // symbol = getData['s'];
        // quantity = getData['q'];
      });
    }
    
      // Map getData = jsonDecode(message);
      // setState(() {
      //   btcUsdtPrice = getData[1]['o'][0];
      //   // event = getData['e'];
      //   // symbol = getData['s'];
      //   // quantity = getData['q'];
      // });
      // print(getData['p']);
    });
  }

  @override
  Widget build(BuildContext context) {

    

    return Scaffold(
      backgroundColor: Colors.blueAccent,
     body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.all(20.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Pair: $pair',
                style: TextStyle(fontSize: 20.0, fontWeight: FontWeight.bold),
              ),
              SizedBox(height: 20.0),
              _buildDataCard('Ask Price', askPrice),
              _buildDataCard('Ask Volume', askVolume),
              _buildDataCard('Bid Price', bidPrice),
              _buildDataCard('Bid Volume', bidVolume),
              _buildDataCard('Last Price', lastPrice),
              _buildDataCard('Last Volume', lastVolume),
              _buildDataCard('Volume Today', volumeToday),
              _buildDataCard('Volume Last 24 Hours', volumeLast24Hours),
              _buildDataCard('Weighted Avg Price Today', weightedAvgPriceToday),
              _buildDataCard(
                  'Weighted Avg Price Last 24 Hours', weightedAvgPriceLast24Hours),
              _buildDataCard('Trades Today', tradesToday.toString()),
              _buildDataCard('Trades Last 24 Hours', tradesLast24Hours.toString()),
              _buildDataCard('Low Today', lowToday),
              _buildDataCard('Low Last 24 Hours', lowLast24Hours),
              _buildDataCard('High Today', highToday),
              _buildDataCard('High Last 24 Hours', highLast24Hours),
              _buildDataCard('Open Today', openToday),
              _buildDataCard('Open Last 24 Hours', openLast24Hours),
            ],
          ),
        ),
      ),
        
          
      
    );
  }
}



  Widget _buildDataCard(String title, String data) {
  return Container( // Wrap Card with Container
    width: 300.0, // Set the desired height for each card
    height: 100.0, // Set the desired height for each card
    child: Card(
      elevation: 3.0,
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: 20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              title,
              style: TextStyle(
                fontSize: 18.0,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: 10.0),
            Text(
              data,
              style: TextStyle(fontSize: 16.0),
            ),
          ],
        ),
      ),
    ),
  );
}

