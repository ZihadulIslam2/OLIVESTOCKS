import 'package:flutter/material.dart';

import '../../../../../common/widgets/tab_selector_row.dart';
import '../../../../stock_data_serving/presentations/widgets/expert_card.dart';
import '../../../../stock_data_serving/presentations/widgets/filter_chips_row.dart';
import '../../../../stock_data_serving/presentations/widgets/upgrade_pro_card.dart';

class WallStreetTab extends StatefulWidget {
  final String title;
  const WallStreetTab({super.key, required this.title});

  @override
  State<WallStreetTab> createState() => _WallStreetTabState();
}

class _WallStreetTabState extends State<WallStreetTab> {
  int selectedSortTab = 0;
  final sortTabs = ["Analyst", "Average Return", "Success Rate"];

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        children: [
          // Description
          const Padding(
            padding: EdgeInsets.symmetric(horizontal: 16),
            child: Align(
              alignment: Alignment.centerLeft,
              child: Text(
                "Follow Wall Street’s top performing analysts & never miss stock recommendations.",
                style: TextStyle(color: Colors.black54),
              ),
            ),
          ),

          const SizedBox(height: 8),

          const FiltersWidget(),

          TabSelectorRow(
            tabs: sortTabs,
            selectedIndex: selectedSortTab,
            onSelected: (index) {
              setState(() => selectedSortTab = index);
            },
          ),

          const SizedBox(height: 16),
          
          UpgradeProCard(title: widget.title),



          const SizedBox(height: 16),

          // Expert list with dividers
          Column(
            children: [
              const Divider(height: 1),
              ListView.separated(
                physics: const NeverScrollableScrollPhysics(),
                shrinkWrap: true,
                itemCount: 10,
                itemBuilder: (context, index) {
                  return  ExpertCard(selectedSortTab: selectedSortTab,);
                },
                separatorBuilder: (context, index) => const Divider(height: 1),
              ),
              const Divider(height: 1),
            ],
          ),
        ],
      ),
    );
  }
}
