import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../portfolio_smart_score/presentation/screens/portfolio_smart_score_screen.dart';
import '../../../markets/presentations/screens/single_stock_market.dart';
import '../../controller/portfolio_controller.dart';

class PortfolioStockWidget extends StatefulWidget {
  const PortfolioStockWidget({super.key});

  @override
  State<PortfolioStockWidget> createState() => _PortfolioStockWidgetState();
}

class _PortfolioStockWidgetState extends State<PortfolioStockWidget>
    with SingleTickerProviderStateMixin {
  late AnimationController _animationController;
  late Animation<double> _rotationAnimation;
  String? id;

  @override
  void initState() {
    super.initState();

    _animationController = AnimationController(
      duration: Duration(milliseconds: 1000),
      vsync: this,
    );

    _rotationAnimation = Tween<double>(
      begin: 0.0,
      end: 1.0,
    ).animate(CurvedAnimation(
      parent: _animationController,
      curve: Curves.linear,
    ));
    helpGettingId();
  }

  void helpGettingId() async {
    id = await Get.find<PortfolioController>().getPresentPortfolio();
    print("Portfolio ID: $id");
    if (Get.find<PortfolioController>().portfolios.isNotEmpty) {
      Get.find<PortfolioController>().getAllOverallBalance(id!);
    }
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  void _handleRotateClick() {
    _animationController.forward().then((_) {
      _animationController.reset();
    });
  }

  void _handlePercentChangeClick() {}

  void _handleUpArrow() {}

  void _handleDownArrow() {}

  void _showDeleteDialog(String symbol) {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        return AlertDialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
          title: Row(
            children: [
              Icon(Icons.warning_amber_rounded, color: Colors.orange, size: 24),
              SizedBox(width: 8),
              Text('Delete Stock', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
            ],
          ),
          content: Text(
            'Are you sure you want to delete $symbol from your portfolio?',
            style: TextStyle(fontSize: 16),
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: Text(
                'Cancel',
                style: TextStyle(color: Colors.grey[600], fontSize: 16),
              ),
            ),
            ElevatedButton(
              onPressed: () {
                Navigator.of(context).pop();
                _deleteStock(symbol, id!);
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.red,
                foregroundColor: Colors.white,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8),
                ),
              ),
              child: Text('Delete', style: TextStyle(fontSize: 16)),
            ),
          ],
        );
      },
    );
  }

  void _deleteStock(String symbol, String portfolioId) async {
    if (id != null) {
      try {
        // Show loading indicator
        Get.dialog(
          Center(
            child: Container(
              padding: EdgeInsets.all(20),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(12),
              ),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  CircularProgressIndicator(),
                  SizedBox(height: 16),
                  Text('Deleting $symbol', style: TextStyle(fontSize: 14, color: Colors.green)),
                ],
              ),
            ),
          ),
          barrierDismissible: false,
        );

        // Call API with only symbol and portfolio id
        await Get.find<PortfolioController>().postDeleteStockPortfolio(symbol, portfolioId);

        // Close loading dialog
        Get.back();

        // Show success message
        Get.snackbar(
          'Success',
          '$symbol deleted successfully',
          backgroundColor: Colors.green,
          colorText: Colors.white,
          duration: Duration(seconds: 2),
          snackPosition: SnackPosition.BOTTOM,
        );

        // Refresh the portfolio data
        Get.find<PortfolioController>().getAllOverallBalance(id!);

      } catch (e) {
        // Close loading dialog if open
        if (Get.isDialogOpen ?? false) {
          Get.back();
        }

        // Show error message
        Get.snackbar(
          'Error',
          'Failed to delete $symbol',
          backgroundColor: Colors.red,
          colorText: Colors.white,
          duration: Duration(seconds: 3),
          snackPosition: SnackPosition.BOTTOM,
        );
        print('Error deleting stock: $e');
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
      child: Column(
        children: [
          Row(
            children: [
              Container(
                height: 24,
                width: 24,
                child: GestureDetector(
                  onTap: _handleRotateClick,
                  child: AnimatedBuilder(
                    animation: _rotationAnimation,
                    builder: (context, child) {
                      return Transform.rotate(
                        angle: _rotationAnimation.value * 6.28318,
                        child: Image.asset(
                          'assets/logos/rotate phone.png',
                          fit: BoxFit.cover,
                        ),
                      );
                    },
                  ),
                ),
              ),
              SizedBox(width: 8),
              Text(
                'Rotate or Click for full details',
                style: TextStyle(fontSize: 12, color: Color(0xff595959)),
              ),
              Spacer(),
              Row(
                children: [
                  TextButton(
                    onPressed: _handlePercentChangeClick,
                    child: Text(
                      '% Change',
                      style: TextStyle(color: Color(0xff595959), fontSize: 11),
                    ),
                  ),
                  Column(
                    children: [
                      GestureDetector(
                        onTap: _handleUpArrow,
                        child: Icon(Icons.keyboard_arrow_up, size: 14),
                      ),
                      GestureDetector(
                        onTap: _handleDownArrow,
                        child: Icon(Icons.keyboard_arrow_down, size: 14),
                      ),
                    ],
                  ),
                ],
              ),
            ],
          ),
          Container(
            height: size.height * 0.36,
            width: size.width * 0.9,
            padding: const EdgeInsets.only(left: 16, right: 16, top: 8),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(4),
              boxShadow: [
                BoxShadow(
                  color: Colors.grey.withOpacity(0.2),
                  spreadRadius: 1,
                  blurRadius: 1,
                  offset: Offset(0, 1),
                ),
              ],
            ),
            child: GetBuilder<PortfolioController>(builder: (controller) {
              final model = controller.overallBalanceResponseModel;

              if (model == null) {
                return const Center(child: Text('Model is null'));
              }
              if (model.holdings == null) {
                return const Center(child: Text('Holdings is null'));
              }
              if (model.holdings!.isEmpty) {
                return const Center(child: Text('No Stocks Found in your Portfolio'));
              }

              print('Building stock list with ${model.holdings!.length} items');

              return ListView.separated(
                itemCount: model.holdings!.length,
                separatorBuilder: (context, index) =>
                    Divider(height: 1, color: Colors.grey.shade300),
                itemBuilder: (context, index) {
                  final item = model.holdings![index];

                  return GestureDetector(
                    onTap: () {
                      if (item.symbol != null) {
                        Get.to(SingleStockMarket(symbol: item.symbol!));
                      }
                    },
                    onLongPress: () {
                      if (item.symbol != null) {
                        _showDeleteDialog(item.symbol!);
                      }
                    },
                    child: Container(
                      padding: const EdgeInsets.symmetric(vertical: 5),
                      child: Row(
                        children: [
                          GestureDetector(
                            onTap: () {
                              if (item.symbol != null && item.name != null) {
                                Get.to(PortfolioSmartScoreScreen(
                                  symbol: item.symbol!,
                                  name: item.name!,
                                ));
                              }
                            },
                            child: Icon(
                              Icons.edit,
                              color: Colors.green,
                              size: 20,
                            ),
                          ),
                          SizedBox(width: 5),
                          CircleAvatar(
                            radius: 20,
                            backgroundColor: Colors.grey.shade100,
                            backgroundImage: item.logo != null && item.logo!.isNotEmpty
                                ? NetworkImage(item.logo!)
                                : const AssetImage('assets/logos/placeholder.png')
                            as ImageProvider,
                          ),
                          const SizedBox(width: 20),
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  item.symbol ?? '',
                                  style: const TextStyle(
                                    fontSize: 14,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                const SizedBox(height: 3),
                                Text(
                                  item.name ?? '',
                                  style: const TextStyle(
                                    fontSize: 12,
                                    color: Colors.grey,
                                  ),
                                ),
                              ],
                            ),
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(
                                item.price != null
                                    ? '\$${item.price!.toStringAsFixed(2)}'
                                    : '',
                                style: const TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(width: 16),
                          Padding(
                            padding: const EdgeInsets.only(top: 10),
                            child: Column(
                              children: [
                                Container(
                                  height: size.height * 0.03,
                                  width: size.width * 0.22,
                                  decoration: BoxDecoration(
                                    boxShadow: <BoxShadow>[
                                      BoxShadow(
                                        color: Colors.grey.withOpacity(0.2),
                                        spreadRadius: 1,
                                        blurRadius: 1,
                                        offset: Offset(0, 1),
                                      ),
                                    ],
                                    color: (item.change ?? 0) >= 0
                                        ? Colors.green.withOpacity(0.1)
                                        : Colors.red.withOpacity(0.1),
                                    borderRadius: BorderRadius.circular(8),
                                  ),
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Icon(
                                        (item.change ?? 0) >= 0
                                            ? Icons.arrow_drop_up
                                            : Icons.arrow_drop_down,
                                        size: 20,
                                        color: (item.change ?? 0) >= 0
                                            ? Colors.green
                                            : Colors.red,
                                      ),
                                      SizedBox(width: 3),
                                      Text(
                                        '${(item.change ?? 0).toStringAsFixed(2)}%',
                                        style: TextStyle(
                                          fontSize: 14,
                                          fontWeight: FontWeight.bold,
                                          color: (item.change ?? 0) >= 0
                                              ? Colors.green
                                              : Colors.red,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),

                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  );
                },
              );
            }),
          ),
        ],
      ),
    );
  }
}