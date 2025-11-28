import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../../portfolio_smart_score/presentation/screens/portfolio_smart_score_screen.dart';
import '../../../markets/presentations/screens/single_stock_market.dart';
import '../../controller/portfolio_controller.dart';

class StockListScreen extends StatefulWidget {
  const StockListScreen({super.key});

  @override
  State<StockListScreen> createState() => _StockListScreenState();
}

class _StockListScreenState extends State<StockListScreen>
    with SingleTickerProviderStateMixin {
  late AnimationController _animationController;
  late Animation<double> _rotationAnimation;

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      duration: const Duration(milliseconds: 1000),
      vsync: this,
    );
    _rotationAnimation = Tween<double>(
      begin: 0.0,
      end: 1.0,
    ).animate(CurvedAnimation(
      parent: _animationController,
      curve: Curves.linear,
    ));
    Get.find<PortfolioController>().getWatchList();
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
    print("Rotate or click action");
  }

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
            children: const [
              Icon(Icons.warning_amber_rounded, color: Colors.orange, size: 24),
              SizedBox(width: 8),
              Text(
                'Delete Stock',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
            ],
          ),
          content: Text(
            'Are you sure you want to delete $symbol from your watchlist?',
            style: const TextStyle(fontSize: 16),
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.of(context).pop(),
              child: Text(
                'Cancel',
                style: TextStyle(color: Colors.grey[600], fontSize: 16),
              ),
            ),
            ElevatedButton(
              onPressed: () {
                Navigator.of(context).pop();
                _deleteStock(symbol);
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.red,
                foregroundColor: Colors.white,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8),
                ),
              ),
              child: const Text('Delete', style: TextStyle(fontSize: 16)),
            ),
          ],
        );
      },
    );
  }

  void _deleteStock(String symbol) async {
    try {
      // Show loading dialog
      Get.dialog(
        Center(
          child: Container(
            padding: const EdgeInsets.all(20),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(12),
            ),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                const CircularProgressIndicator(),
                const SizedBox(height: 16),
                Text('Deleting $symbol', style: const TextStyle(fontSize: 14,color: Colors.green)),
              ],
            ),
          ),
        ),
        barrierDismissible: false,
      );

      // Call delete API
      await Get.find<PortfolioController>().postDeleteStockWatchList(symbol);

      // Close loading
      Get.back();

      // Success snackbar
      Get.snackbar(
        'Success',
        '$symbol removed from Watchlist',
        backgroundColor: Colors.green,
        colorText: Colors.white,
        duration: const Duration(seconds: 2),
        snackPosition: SnackPosition.BOTTOM,
      );

      // ✅ Refresh Watchlist
      Get.find<PortfolioController>().getWatchList();
    } catch (e) {
      if (Get.isDialogOpen ?? false) Get.back();

      Get.snackbar(
        'Error',
        'Failed to delete $symbol',
        backgroundColor: Colors.red,
        colorText: Colors.white,
        duration: const Duration(seconds: 2),
        snackPosition: SnackPosition.BOTTOM,
      );
      print('Error deleting stock from watchlist: $e');
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
              SizedBox(
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
              const SizedBox(width: 8),
              const Text(
                'Rotate or Click for full details',
                style: TextStyle(fontSize: 12, color: Color(0xff595959)),
              ),
              const Spacer(),
            ],
          ),
          Container(
            height: size.height * 0.36,
            width: size.width * 0.9,
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(4),
              boxShadow: [
                BoxShadow(
                  color: Colors.grey.withOpacity(0.2),
                  spreadRadius: 1,
                  blurRadius: 1,
                  offset: const Offset(0, 1),
                ),
              ],
            ),
            padding: const EdgeInsets.only(left: 16, right: 16, top: 8),
            child: GetBuilder<PortfolioController>(
              builder: (controller) {
                if (controller.isWatchListLoading) {
                  return const Center(child: CircularProgressIndicator());
                }

                if (controller.getWatchListResponseModel == null ||
                    controller.getWatchListResponseModel!.data == null ||
                    controller.getWatchListResponseModel!.data!.isEmpty) {
                  return const Center(child: Text('No WatchList Found'));
                }

                return ListView.separated(
                  itemCount: controller.getWatchListResponseModel!.data!.length,
                  separatorBuilder: (context, index) =>
                      Divider(height: 1, color: Colors.grey.shade300),
                  itemBuilder: (context, index) {
                    var item = controller.getWatchListResponseModel!.data![index];
                    return GestureDetector(
                      onTap: () => Get.to(SingleStockMarket(symbol: item.symbol!)),
                      onLongPress: () {
                        if (item.symbol != null) {
                          _showDeleteDialog(item.symbol!);
                        }
                      },
                      child: Padding(
                        padding: const EdgeInsets.symmetric(vertical: 6),
                        child: Row(
                          children: [
                            GestureDetector(
                              onTap: () => Get.to(
                                PortfolioSmartScoreScreen(
                                  symbol: item.symbol!,
                                  name: item.name!,
                                ),
                              ),
                              child: const Icon(Icons.edit,
                                  color: Colors.green, size: 20),
                            ),
                            const SizedBox(width: 5),
                            CircleAvatar(
                              radius: 20,
                              backgroundImage: NetworkImage(item.logo!),
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
                              children: [
                                Text(
                                  '\$${item.currentPrice}',
                                  style: const TextStyle(
                                    fontSize: 16,
                                    fontWeight: FontWeight.bold,
                                  ),
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
                                              color: (item.change ?? 0) >= 0 ? Colors.green : Colors.red,
                                              size: 20,
                                            ),
                                            SizedBox(width: 3),
                                            Text(
                                              '${item.change ?? 0}%',
                                              style: TextStyle(
                                                fontSize: 11,
                                                fontWeight: FontWeight.bold,
                                                color: (item.change ?? 0) >= 0 ? Colors.green : Colors.red,
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
                          ],
                        ),
                      ),
                    );
                  },
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
