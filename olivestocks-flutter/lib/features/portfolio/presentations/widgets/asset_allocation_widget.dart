import 'package:flutter/material.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:get/get.dart';
import 'package:olive_stocks_flutter/features/portfolio/controller/portfolio_controller.dart';

import '../../../../portfolio_allocation/presentation/screens/protfolio_allocations.dart';
import '../../domains/asset_allocation_response_model.dart';

class AssetAllocationWidget extends StatefulWidget {
  const AssetAllocationWidget({super.key});




  @override
  State<AssetAllocationWidget> createState() => _AssetAllocationWidgetState();
}

class _AssetAllocationWidgetState extends State<AssetAllocationWidget> {
  final List<Color> pieColors = [
    Color(0xFF00C853),
    Color(0xFF64DD17),
    Color(0xFFEF5350),
    Color(0xFFD32F2F),
    Color(0xFFFFA000),
    Color(0xFFBDBDBD),
    Color(0xFF1976D2),
    Color(0xFF0097A7),
  ];

  @override
  void initState() {
    Get.find<PortfolioController>().postAssetAllocation('685d0bb75b7e52d1eb002064');
    super.initState();
  }

  String name = '';

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return GetBuilder<PortfolioController>(builder: (portfolioController){

      for(int i = 0; i < portfolioController.portfolios.length; i++){
        if(portfolioController.portfolios[i].id == portfolioController.selectedPortfolioId){
          name = portfolioController.portfolios[i].name!;
          print(name);
        }
      }

      return !portfolioController.isAssetAllocationLoading ? Container(
        width: size.width * .9,
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(4),
          color: Colors.white,
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.2),
              spreadRadius: 1,
              blurRadius: 1,
              offset: Offset(0, 1),
            ),
          ],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            /// Header
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                 Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Asset Allocation",
                      style: TextStyle(
                        color: Colors.black,
                        fontWeight: FontWeight.bold,
                        fontSize: 20,
                      ),
                    ),
                    SizedBox(height: 4),
                    Text(
                      name,
                      style: TextStyle(color: Color(0xff595959), fontSize: 14),
                    ),
                  ],
                ),
                GestureDetector(
                  onTap: () {
                    Get.to(PortfolioAllocationsScreen());
                  },
                  child: const Row(
                    children: [
                      Text(
                        "See More",
                        style: TextStyle(color: Colors.green, fontSize: 14),
                      ),
                      Icon(Icons.chevron_right_outlined, color: Colors.green),
                    ],
                  ),
                ),
              ],
            ),
            const SizedBox(height: 20),

            /// Pie Chart & Legend
            Row(
              children: [
                // Pie Chart
                SizedBox(
                  width: 100,
                  height: 100,
                  child: PieChart(
                    PieChartData(
                      sectionsSpace: 0,
                      centerSpaceRadius: 40,
                      sections: List.generate(
                        portfolioController.assetAllocationResponseModel!.holdingsBySector!.length,
                            (index) {
                          final asset = portfolioController.assetAllocationResponseModel!.holdingsBySector![index];
                          // final percent = asset.percentage ?? 0;
                          //
                          return PieChartSectionData(
                            color: pieColors[index % pieColors.length],
                            // value: percent > 0 ? percent : 0.01, // show small slice if 0
                            radius: 12,
                            showTitle: false,
                          );
                        },
                      ),
                    ),
                  ),
                ),
                const SizedBox(width: 24),

                // Legend
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: List.generate(portfolioController.assetAllocationResponseModel!.holdingsBySector!.length, (index) {
                      final asset = portfolioController.assetAllocationResponseModel!.holdingsBySector![index];
                      return Padding(
                        padding: const EdgeInsets.symmetric(vertical: 4),
                        child: Row(
                          children: [
                            Container(
                              width: 10,
                              height: 10,
                              decoration: BoxDecoration(
                                color: pieColors[index % pieColors.length],
                                shape: BoxShape.rectangle,
                              ),
                            ),
                            const SizedBox(width: 8),
                            Text(
                              portfolioController.assetAllocationResponseModel!.holdingsBySector![index].sector!,
                              style: const TextStyle(
                                color: Colors.black,
                                fontSize: 10,
                              ),
                            ),
                          ],
                        ),
                      );
                    }),
                  ),
                ),
              ],
            ),
          ],
        ),
      ) : Container(
        height: size.height * .38,
        width: size.width * .9,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(4),
          boxShadow: [
            BoxShadow(color: Colors.black26, spreadRadius: 2, blurRadius: 2),
          ],
        ),
        child: Center(
          child: Text('NO DATA'),
        ),
      );
    });
  }
}
