import 'package:flutter/material.dart';

import '../../../../common/widgets/bottom_nev_bar.dart';
import '../../../../common/widgets/custom_appbar.dart';
import '../../../../common/widgets/tab_switcher_screen.dart';
import '../widgets/tabs/corporate_insider_tab.dart';
import '../widgets/tabs/expert_category_page.dart';
import '../widgets/tabs/financial_bloggers_tab.dart';
import '../widgets/tabs/hege_fund_tab.dart';
import '../widgets/tabs/individual_investors_tab.dart';
import '../widgets/tabs/research_firms_tab.dart';
import '../widgets/tabs/wall_street_tab.dart';


class TopExpertsScreen extends StatefulWidget {
  const TopExpertsScreen({super.key});

  @override
  State<TopExpertsScreen> createState() => _TopExpertsScreenState();
}

class _TopExpertsScreenState extends State<TopExpertsScreen> {
  int selectedTopTab = 0;

  final topTabs = [
    "Wall Street Analysts",
    "Hedge Fund Managers",
    "Corporate Insiders",
    "Financial Bloggers",
    "Individual Investors",
    "Research Firms",
  ];

  Widget getSelectedTabView(int index) {
    switch (index) {
      case 0:
        return WallStreetTab(title: topTabs[index]);
      case 1:
        return HedgeFundTab(title: topTabs[index]);
      case 2:
        return CorporateInsiderTab(title: topTabs[index]);
      case 3:
        return FinancialBloggersTab(title: topTabs[index]); // Duplicate tab
      case 4:
        return IndividualInvestorsTab(title: topTabs[index]); // Duplicate tab
      case 5:
        return ResearchFirmsTab(title: topTabs[index]);
      default:
        return ExpertCategoryPage(title: topTabs[index]);
    }
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Column(
          children: [
            // Header
            CustomAppBar(appBarTitle: "Top Experts", isDefaultIcon: true),

            // Top Tab Switcher
            TabSwitcherScreen(
              tabs: topTabs,
              selectedIndex: selectedTopTab,
              onSelected: (index) {
                setState(() => selectedTopTab = index);
              },
            ),

            // Selected tab content
            Expanded(child: getSelectedTabView(selectedTopTab)),
          ],
        ),
      ),
    );
  }

}
