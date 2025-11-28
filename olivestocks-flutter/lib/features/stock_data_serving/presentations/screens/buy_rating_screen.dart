
import 'package:flutter/material.dart';

import '../widgets/daily_list_widget.dart';

class BuyRatingScreen extends StatefulWidget {
  final ScrollController verticalScrollController;

  const BuyRatingScreen({super.key, required this.verticalScrollController});

  @override
  State<BuyRatingScreen> createState() => _BuyRatingScreenState();
}

class _BuyRatingScreenState extends State<BuyRatingScreen> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return SingleChildScrollView(
      child: DailyListWidget(context: context),
    );
  }
}
