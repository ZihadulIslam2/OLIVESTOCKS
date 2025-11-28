import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:olive_stocks_flutter/core/contants/subcription_utils.dart';
import 'package:olive_stocks_flutter/features/auth/controllers/auth_controller.dart';
import '../../../../markets/presentations/screens/single_stock_market.dart';
import '../../../../portfolio/domains/most_treded_stock_model.dart';

class MostTradedTable extends StatefulWidget {
  final List<TrendingStocks>? trendingStocks;
  final List<TrendingStocks>? topStocks;

  const MostTradedTable({
    super.key,
    this.trendingStocks,
    this.topStocks,
  }) : assert(trendingStocks != null || topStocks != null,
  'Either stocks or etfs must be provided');

  @override
  State<MostTradedTable> createState() => _MostTradedTableState();
}

class _MostTradedTableState extends State<MostTradedTable> {
  bool showGainers = true;

  @override
  Widget build(BuildContext context) {
    final title = showGainers ? 'Most-traded Stocks' : 'Most traded ETFs';

    return GetBuilder<AuthController>(builder: (authController) {
      final subscriptionStatus =
          authController.getSingleUserResponseModel?.payment ?? "Free";

      return Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 20),
        child: Container(
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(8),
            boxShadow: [
              BoxShadow(
                color: Colors.grey.withOpacity(0.2),
                spreadRadius: 1,
                blurRadius: 5,
                offset: const Offset(0, 3),
              ),
            ],
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: 16),
              Padding(
                padding: const EdgeInsets.only(left: 12),
                child: Text(
                  title,
                  style: const TextStyle(
                      fontSize: 16, fontWeight: FontWeight.bold),
                ),
              ),
              const SizedBox(height: 8),
              Container(
                padding:
                const EdgeInsets.symmetric(vertical: 8, horizontal: 12),
                color: const Color(0xffEAF6EC),
                child: const Row(
                  children: [
                    Expanded(
                      flex: 4,
                      child: Text('Company',
                          style: TextStyle(
                              fontSize: 16, fontWeight: FontWeight.bold)),
                    ),
                    Expanded(
                      flex: 2,
                      child: Text('Volume',
                          style: TextStyle(
                              fontSize: 16, fontWeight: FontWeight.bold)),
                    ),
                    Expanded(
                      flex: 3,
                      child: Text(
                        'Price \nChange',
                        textAlign: TextAlign.right,
                        style: TextStyle(
                            fontSize: 16, fontWeight: FontWeight.bold),
                      ),
                    ),
                  ],
                ),
              ),
              // ✅ Pass subscriptionStatus correctly
              ...widget.trendingStocks!
                  .map((stock) => _buildRow(stock, subscriptionStatus))
                  .toList(),
              const SizedBox(height: 12),
              Center(
                child: TextButton(
                  onPressed: () {},
                  child: const Text('See more',
                      style: TextStyle(color: Colors.green)),
                ),
              ),
            ],
          ),
        ),
      );
    });
  }

  Widget _buildRow(TrendingStocks trendingStocks, String subscriptionStatus) {
    final double percentChange = trendingStocks.percentChange ?? 0;
    final double priceChange = trendingStocks.priceChange ?? 0;

    final bool isPositive = percentChange > 0;
    final bool isNegative = percentChange < 0;
    final Color color =
    isPositive ? Colors.green : isNegative ? Colors.red : Colors.black;
    final IconData? icon = isPositive
        ? Icons.arrow_drop_up
        : isNegative
        ? Icons.arrow_drop_down
        : null;

    String formatChange(double value) {
      if (value > 0) return '+${value.toStringAsFixed(2)}';
      if (value < 0) return value.toStringAsFixed(2);
      return '0.00';
    }

    return GestureDetector(
      onTap: () {
        Get.to(SingleStockMarket(symbol: trendingStocks.symbol!));
      },
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 12),
        decoration: const BoxDecoration(
          border: Border(bottom: BorderSide(color: Colors.grey, width: 0.2)),
        ),
        child: Row(
          children: [
            Expanded(
              flex: 4,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    trendingStocks.symbol.toString(),
                    style: const TextStyle(
                        fontWeight: FontWeight.bold, fontSize: 14),
                  ),
                  Text(
                    trendingStocks.symbol.toString(),
                    style: const TextStyle(fontSize: 12),
                  ),
                ],
              ),
            ),
            Expanded(
              flex: 2,
              child: Text(
                '\$${trendingStocks.currentPrice?.toStringAsFixed(2) ?? "0.00"}M',
                style: const TextStyle(fontSize: 16),
              ),
            ),
            Expanded(
              flex: 3,
              child: buildSubscriptionContent(
                subscriptionStatus: subscriptionStatus,
                context: context,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        if (icon != null) Icon(icon, color: color, size: 30),
                        Text(
                          '${formatChange(percentChange)}%',
                          style: TextStyle(
                            color: color,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),
                    Text(
                      '${formatChange(priceChange)}%',
                      textAlign: TextAlign.right,
                      style: TextStyle(
                        color: color,
                        fontSize: 12,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
