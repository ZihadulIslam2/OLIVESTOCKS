
import 'package:flutter/material.dart';

import '../widgets/daily_list_widget.dart';

class SellRatingScreen extends StatefulWidget {
  final ScrollController verticalScrollController;

  const SellRatingScreen({super.key, required this.verticalScrollController});

  @override
  State<SellRatingScreen> createState() => _SellRatingScreenState();
}

class _SellRatingScreenState extends State<SellRatingScreen> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return SingleChildScrollView(child: DailyListWidget(context: context),
    );
  }
}
