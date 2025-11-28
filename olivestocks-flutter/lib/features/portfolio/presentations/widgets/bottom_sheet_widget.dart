import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:olive_stocks_flutter/features/portfolio/controller/portfolio_controller.dart';
import '../screens/create_portfolio_screen.dart';
import '../screens/olive_stocks_protfolio_new.dart';
import '../screens/olive_stocks_protfolio_under_radar_new.dart';

void _showRenameDialog(BuildContext context, String id, String currentName) {
  final TextEditingController nameController = TextEditingController(text: currentName);
  final PortfolioController controller = Get.find<PortfolioController>();

  showDialog(
    context: context,
    builder: (_) => GetBuilder<PortfolioController>(
      builder: (_) => AlertDialog(
        title: const Text('Rename Portfolio'),
        content: TextField(
          controller: nameController,
          decoration: const InputDecoration(hintText: 'Enter new name'),
        ),
        actions: [
          TextButton(onPressed: () => Navigator.pop(context), child: const Text('Cancel')),
          ElevatedButton(
            onPressed: controller.isRenamePortfolioLoading
                ? null
                : () async {
              final newName = nameController.text.trim();
              if (newName.isNotEmpty) {
                await controller.patchRenamePortfolio(id, newName);
                if (controller.updatePortfolioNameResponseModel?.portfolio?.id != null) {
                  Navigator.pop(context); // close dialog
                  Navigator.pop(context); // close bottom sheet
                  Future.delayed(const Duration(milliseconds: 300), () {
                    showBottomSheetCustom(context);
                  });
                }
              }
            },
            child: controller.isRenamePortfolioLoading
                ? const CircularProgressIndicator(strokeWidth: 2)
                : const Text('Save'),
          ),
        ],
      ),
    ),
  );
}




void showBottomSheetCustom(BuildContext context) {
  showModalBottomSheet(
    context: context,
    isScrollControlled: true,
    shape: const RoundedRectangleBorder(
      borderRadius: BorderRadius.vertical(top: Radius.circular(16)),
    ),
    builder: (context) {
      return _BottomSheetContent();
    },
  );
}

class _BottomSheetContent extends StatefulWidget {
  @override
  State<_BottomSheetContent> createState() => _BottomSheetContentState();
}

class _BottomSheetContentState extends State<_BottomSheetContent> {
  void checkWatchList() async {
    await Get.find<PortfolioController>().isWatchListSelected()
        ? Get.find<PortfolioController>().watchlistSelected = true
        : Get.find<PortfolioController>().watchlistSelected = false;
  }

  @override
  void initState() {
    checkWatchList();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return DraggableScrollableSheet(
      expand: false,
      maxChildSize: 0.9,
      initialChildSize: 0.7,
      minChildSize: 0.5,
      builder: (context, scrollController) {
        return GetBuilder<PortfolioController>(builder: (portfolioController) {
          return SingleChildScrollView(
            controller: scrollController,
            child: Padding(
              padding: const EdgeInsets.all(8),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Center(
                    child: Container(
                      width: 40,
                      height: 4,
                      margin: const EdgeInsets.only(top: 8, bottom: 16),
                      decoration: BoxDecoration(
                        color: Colors.grey[400],
                        borderRadius: BorderRadius.circular(4),
                      ),
                    ),
                  ),
                  Container(
                    width: double.infinity,
                    padding: const EdgeInsets.all(16),
                    decoration: const BoxDecoration(color: Color(0xffF3F4F6)),
                    child: Row(
                      children: [
                        const Text(
                          'Choose Portfolio ',
                          style: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        const Spacer(),
                        IconButton(
                          icon: const Icon(Icons.refresh, size: 28, color: Colors.green),
                          onPressed: () {
                            portfolioController.refreshPortfolios();
                            portfolioController.update();

                            Get.snackbar(
                              'Updated',
                              '',
                              backgroundColor: Colors.white,
                              snackPosition: SnackPosition.BOTTOM,
                              margin: const EdgeInsets.symmetric(horizontal: 40, vertical: 20),
                              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
                              borderRadius: 8,
                              duration: const Duration(seconds: 2),
                              boxShadows: [
                                BoxShadow(
                                  color: Colors.black12,
                                  blurRadius: 4,
                                  offset: Offset(0, 2),
                                ),
                              ],
                              titleText: Row(
                                children: const [
                                  Icon(Icons.check_circle, color: Colors.green, size: 18),
                                  SizedBox(width: 8),
                                  Text(
                                    'Portfolios Updated',
                                    style: TextStyle(
                                      color: Colors.black87,
                                      fontWeight: FontWeight.w500,
                                      fontSize: 14,
                                    ),
                                  ),
                                ],
                              ),
                              messageText: const SizedBox(),
                            );
                          },
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 8),
                  const Text(
                    'Created Portfolios',
                    style: TextStyle(
                      fontSize: 16,
                      color: Color(0xff595959),
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                  const SizedBox(height: 8),
                  if (portfolioController.portfolios.isNotEmpty)
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 16.0),
                      child: Row(
                        children: [
                          Expanded(
                            child: DropdownButtonFormField<String>(
                              isExpanded: true,
                              decoration: const InputDecoration(
                                labelText: 'Select Portfolio',
                                border: OutlineInputBorder(),
                              ),
                              value: portfolioController.portfolios
                                  .any((e) => e.id == portfolioController.selectedPortfolioId)
                                  ? portfolioController.selectedPortfolioId
                                  : null,
                              onChanged: (newValue) {
                                if (newValue != null) {
                                  portfolioController.setPresentPortfolio(newValue);
                                  portfolioController.loadSinglePortfolioStocks(newValue);
                                  portfolioController.chooseNameFromPortfolios(newValue);
                                  Navigator.of(context).pop();
                                }
                              },
                              items: portfolioController.portfolios
                                  .where((e) => e.id != null)
                                  .map((item) {
                                return DropdownMenuItem<String>(
                                  value: item.id!,
                                  child: Row(
                                    children: [
                                      Image.asset(
                                        'assets/logos/bag.png',
                                        height: 20,
                                        width: 23,
                                        fit: BoxFit.cover,
                                      ),
                                      const SizedBox(width: 8),
                                      Text(item.name ?? ''),
                                      if (!portfolioController.watchlistSelected &&
                                          portfolioController.selectedPortfolioId == item.id)
                                        const Padding(
                                          padding: EdgeInsets.only(left: 8.0),
                                          child: Icon(Icons.check, color: Colors.green, size: 16),
                                        ),
                                    ],
                                  ),
                                );
                              }).toList(),
                            ),
                          ),
                          const SizedBox(width: 8),
                          PopupMenuButton<String>(
                            icon: const Icon(Icons.more_vert),
                            onSelected: (value) {
                              final selected = portfolioController.portfolios.firstWhereOrNull(
                                    (e) => e.id == portfolioController.selectedPortfolioId,
                              );
                              if (selected == null) return;

                              if (value == 'Edit') {
                                _showRenameDialog(context, selected.id!, selected.name ?? '');
                              } else if (value == 'Delete') {
                                showDialog(
                                  context: context,
                                  builder: (_) => AlertDialog(
                                    title: const Text('Delete Portfolio'),
                                    content: const Text('Are you sure you want to delete this portfolio?'),
                                    actions: [
                                      TextButton(
                                        onPressed: () => Navigator.pop(context),
                                        child: const Text('Cancel'),
                                      ),
                                      ElevatedButton(
                                        style: ElevatedButton.styleFrom(
                                          backgroundColor: Colors.red,
                                        ),
                                        onPressed: () async {
                                          final controller = Get.find<PortfolioController>();
                                          final deletedId = selected.id!;
                                          await controller.deletePortfolio(deletedId);

                                          // Auto-select next available portfolio
                                          if (controller.selectedPortfolioId == deletedId) {
                                            if (controller.portfolios.isNotEmpty) {
                                              final firstRemaining = controller.portfolios.first;
                                              controller.setPresentPortfolio(firstRemaining.name!);
                                              controller.loadSinglePortfolioStocks(firstRemaining.name!);
                                              controller.chooseNameFromPortfolios(firstRemaining.name!);
                                            } else {
                                              controller.selectedPortfolioId = null;
                                            }
                                          }
                                          Navigator.of(context).pop(); // Close confirmation
                                          Navigator.of(context).pop(); // Close bottom sheet

                                          // Reopen updated bottom sheet
                                          Future.delayed(Duration(milliseconds: 300), () {
                                            showBottomSheetCustom(context);
                                          });
                                        },
                                        child: const Text('Delete', style: TextStyle(color: Colors.white)),
                                      ),
                                    ],
                                  ),
                                );
                              }
                            },
                            itemBuilder: (context) => const [
                              PopupMenuItem(value: 'Edit', child: Text('Rename', style: TextStyle(color: Colors.green))),
                              PopupMenuItem(value: 'Delete', child: Text('Delete', style: TextStyle(color: Colors.red))),
                            ],
                          ),
                        ],
                      ),
                    ),

                  const Divider(),

                  const Text(
                    'Model Portfolio Ideas',
                    style: TextStyle(fontSize: 16, color: Color(0xff595959)),
                  ),
                  Divider(),

                  GestureDetector(
                    onTap: () => Get.to(OliveStocksPortfolioNew()),
                    child: Container(
                      color: const Color(0xffF3F4F6),
                      child: ListTile(
                        title: const Text(
                          'Copy Olive Stock Portfolio',
                          style: TextStyle(
                            fontSize: 19,
                            fontWeight: FontWeight.w500,
                            color: Color(0xff28A745),
                          ),
                        ),
                        trailing: Container(
                          padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                          decoration: BoxDecoration(
                            color: const Color(0xff28A745),
                            borderRadius: BorderRadius.circular(4),
                          ),
                          child: Image.asset('assets/logos/SI.png', height: 16, width: 25),
                        ),
                      ),
                    ),
                  ),

                  const Divider(),

                  GestureDetector(
                    onTap: () => Get.to(OliveStocksPortfolioUnderRadarNew()),
                    child: Container(
                      color: const Color(0xffF3F4F6),
                      child: ListTile(
                        title: const Text(
                          'Copy Olive Stock Under Radar',
                          style: TextStyle(
                            fontSize: 19,
                            fontWeight: FontWeight.w500,
                            color: Color(0xff28A745),
                          ),
                        ),
                        trailing: Container(
                          padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                          decoration: BoxDecoration(
                            color: Colors.blue,
                            borderRadius: BorderRadius.circular(4),
                          ),
                          child: Image.asset('assets/logos/SD.png', height: 16, width: 25),
                        ),
                      ),
                    ),
                  ),

                  Divider(),
                  const Text(
                    'More Options',
                    style: TextStyle(fontSize: 16, color: Color(0xff595959)),
                  ),
                  const Divider(),

                  Container(
                    color: const Color(0xffF3F4F6),
                    child: ListTile(
                      leading: const Icon(Icons.remove_red_eye_outlined, color: Color(0xff28A745)),
                      title: const Text(
                        'Watchlist',
                        style: TextStyle(fontSize: 19, color: Color(0xff28A745)),
                      ),
                      trailing: portfolioController.watchlistSelected
                          ? const Icon(Icons.check, color: Colors.green)
                          : null,
                      onTap: () {
                        if (!Get.find<PortfolioController>().watchlistSelected) {
                          Get.find<PortfolioController>().watchlistSelected = true;
                          portfolioController.setWatchListSelected();
                        }
                        Navigator.of(context).pop();
                      },
                    ),
                  ),

                  const Divider(),

                  Container(
                    color: const Color(0xffF3F4F6),
                    child: ListTile(
                      leading: const Icon(Icons.add, color: Color(0xff28A745)),
                      title: const Text(
                        'Create New Portfolio',
                        style: TextStyle(fontSize: 19, color: Color(0xff28A745)),
                      ),
                      onTap: () {
                        showCreatePortfolioDialog(context);
                      },
                    ),
                  ),
                ],
              ),
            ),
          );
        });
      },
    );
  }
}
