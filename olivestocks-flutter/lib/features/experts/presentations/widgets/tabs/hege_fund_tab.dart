import 'package:flutter/material.dart';

import '../../../../../common/widgets/tab_selector_row.dart';
import '../../../../stock_data_serving/presentations/widgets/expert_card.dart';
import '../../../../stock_data_serving/presentations/widgets/filter_chips_row.dart';
import '../../../../stock_data_serving/presentations/widgets/upgrade_pro_card.dart';

class HedgeFundTab extends StatefulWidget {
  final String title;
  const HedgeFundTab({super.key, required this.title});

  @override
  State<HedgeFundTab> createState() => _HedgeFundTabState();
}

class _HedgeFundTabState extends State<HedgeFundTab> {
  int selectedSortTab = 1;
  final sortTabs = ["Hedge Fund", "Average Return", "Portfolio Gain"];
  
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        children: [
          // Subtitle
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: Align(
              alignment: Alignment.centerLeft,
              child: Text(
                "Follow ${widget.title}'s top performing analysts & never miss stock recommendations.",
                style: const TextStyle(color: Colors.black54),
              ),
            ),
          ),

          const SizedBox(height: 8),

          // Filters
          const FiltersWidget(),

          // Sort Tabs
          TabSelectorRow(
            tabs: sortTabs,
            selectedIndex: selectedSortTab,
            onSelected: (index) {
              setState(() => selectedSortTab = index);
            },
          ),

          const SizedBox(height: 16),

          // Upgrade to PRO
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

          const SizedBox(height: 16),
        ],
      ),
    );
  }
}
