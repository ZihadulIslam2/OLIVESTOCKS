import 'package:flutter/material.dart';

class SingleEtfMarket extends StatefulWidget {
  const SingleEtfMarket({super.key});

  @override
  State<SingleEtfMarket> createState() => _SingleEtfMarketState();
}

class _SingleEtfMarketState extends State<SingleEtfMarket> {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Markets', style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600),),
        centerTitle: false,
        actions: [
          Image.asset('assets/logos/search.png')
        ],
      ),
    );
  }
}
