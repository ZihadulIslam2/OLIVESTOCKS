import 'package:flutter/material.dart';

import '../widgets/daily_list_widget.dart';

class HoldRatingsScreen extends StatefulWidget {
  final ScrollController verticalScrollController;

  const HoldRatingsScreen({super.key, required this.verticalScrollController});

  @override
  State<HoldRatingsScreen> createState() => _HoldRatingsScreenState();
}

class _HoldRatingsScreenState extends State<HoldRatingsScreen> {
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
