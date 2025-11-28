import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:olive_stocks_flutter/features/portfolio/controller/portfolio_controller.dart';

import '../../../../common/widgets/custom_button.dart';
import '../../../auth/controllers/auth_controller.dart';
import '../../../portfolio/presentations/widgets/asset_allocation_widget.dart';
import '../../../portfolio/presentations/widgets/portfolio_stock_widget.dart';
import '../../../portfolio/presentations/widgets/stock_list_widget.dart';
import '../widgets/additional_info.dart';
import '../widgets/best_rating.dart';
import '../widgets/performance_section.dart';
import '../widgets/profile_header.dart';
import '../widgets/stock_coverage_table.dart';
import '../widgets/stock_rating_distribution.dart';

class UserProfileScreen extends StatefulWidget {
  const UserProfileScreen({super.key});

  @override
  State<UserProfileScreen> createState() => _UserProfileScreenState();
}

class _UserProfileScreenState extends State<UserProfileScreen> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        title: const Text("User Profile"),
        leading: const BackButton(),
      ),
      body: GetBuilder<AuthController>(builder: (authController){
        return GetBuilder<PortfolioController>(builder: (portfolioController){
          return SingleChildScrollView(
            child: Column(
              children: [

                HeaderSection(),
                const SizedBox(height: 16),
                PerformanceWidget(),
                const SizedBox(height: 16),
                CustomButton(
                  text: 'Follow',
                  textSize: 18,
                  hasIcon: true,
                  icon: Icons.person,
                  borderRadius: 8,
                  verticalPadding: 8,
                  onPressed: () {},
                ),
                const SizedBox(height: 16),
                const AssetAllocationWidget(),
                const SizedBox(height: 16),
                // AdditionalInfoSection(),
                const SizedBox(height: 16),
                // BestRatingSection(),
                const SizedBox(height: 16),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(left: 18),
                      child: Text('Portfolio Stocks', style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
                    ),
                    PortfolioStockWidget(),
                  ],
                ),
                const SizedBox(height: 16),

                // StockCoverageTable(stockData: stockData),
              ],
            ),
          );
        });
      })



    );
  }
}
