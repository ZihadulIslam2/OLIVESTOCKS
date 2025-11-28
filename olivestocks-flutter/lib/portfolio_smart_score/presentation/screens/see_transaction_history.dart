import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../features/portfolio/controller/portfolio_controller.dart';
import '../../../features/portfolio/domains/performance_response_model.dart';

class TransactionHistoryScreen extends StatefulWidget {
  final String id;


  final List<TransactionHistory>? transactionHistory;

  const TransactionHistoryScreen({super.key, required this.id, this.transactionHistory});
  //const TransactionHistoryScreen({super.key, this.transactionHistory});

  @override
  State<TransactionHistoryScreen> createState() =>
      _TransactionHistoryScreenState();
}

class _TransactionHistoryScreenState extends State<TransactionHistoryScreen> {
  final TextEditingController dateController = TextEditingController();

  @override
  void initState() {
    super.initState();
    dateController.text = DateTime.now().toString().split(' ')[0];
    PortfolioController controller = Get.find<PortfolioController>();
    controller.getAllPerformance(widget.id);

  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return GetBuilder<PortfolioController>(
      builder: (portfolioController) {
        final transactions =
            portfolioController.performanceResponseModel.transactionHistory ?? [];

        return Scaffold(
          appBar: AppBar(
            backgroundColor: Colors.white,
            title: Text(
              'See Transaction History',
              style: TextStyle(
                color: Colors.black,
                fontSize: size.width * 0.05,
              ),
            ),
            centerTitle: true,
          ),
          body: Padding(
            padding: EdgeInsets.symmetric(horizontal: size.width * 0.05),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(height: size.height * 0.02),
                TextField(
                  decoration: InputDecoration(
                    labelText: 'Stock',
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(8),
                      borderSide: const BorderSide(color: Colors.green),
                    ),
                  ),
                ),
                SizedBox(height: size.height * 0.02),
                Row(
                  children: [
                    Expanded(
                      child: DropdownButtonFormField<String>(
                        items: ['Buy', 'Sell']
                            .map(
                              (type) => DropdownMenuItem<String>(
                            value: type,
                            child: Text(type),
                          ),
                        )
                            .toList(),
                        onChanged: (value) {},
                        decoration: InputDecoration(
                          labelText: 'Type',
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(8),
                            borderSide: const BorderSide(color: Colors.green),
                          ),
                        ),
                      ),
                    ),
                    SizedBox(width: size.width * 0.03),
                    Expanded(
                      child: TextField(
                        controller: dateController,
                        decoration: const InputDecoration(
                          border: OutlineInputBorder(),
                          contentPadding:
                          EdgeInsets.symmetric(horizontal: 10, vertical: 8),
                          suffixIcon: Icon(Icons.calendar_today),
                        ),
                        readOnly: true,
                        onTap: () async {
                          DateTime? pickedDate = await showDatePicker(
                            context: context,
                            initialDate: DateTime.now(),
                            firstDate: DateTime(2000),
                            lastDate: DateTime(2101),
                          );
                          if (pickedDate != null) {
                            dateController.text =
                            pickedDate.toString().split(' ')[0];
                          }
                        },
                      ),
                    ),
                  ],
                ),
                SizedBox(height: size.height * 0.02),
                Container(
                  decoration: BoxDecoration(
                    color: const Color(0xffBCE4C5),
                    borderRadius: BorderRadius.circular(8),
                  ),
                  padding: const EdgeInsets.all(6),
                  child: const Row(
                    children: [
                      Expanded(child: Text('Type', style: TextStyle(color: Colors.black))),
                      Expanded(child: Text('Stock', style: TextStyle(color: Colors.black))),
                      Expanded(child: Text('Price', style: TextStyle(color: Colors.black))),
                      Expanded(child: Text('Quantity', style: TextStyle(color: Colors.black))),
                      Expanded(
                        child: Center(
                          child: Text('Date&\nTime', style: TextStyle(color: Colors.black)),
                        ),
                      ),

                    ],
                  ),
                ),
                Container(
                  height: size.height * 0.35,
                  decoration: BoxDecoration(
                    color: Colors.green.shade50,
                    borderRadius: BorderRadius.circular(8),
                  ),
                  padding: const EdgeInsets.only(left: 6),
                  child: Builder(
                    builder: (context) {
                      // Show loader while API is fetching
                      if (portfolioController.isLoading) {
                        return const Center(child: CircularProgressIndicator());
                      }

                      // Show empty state if no transactions
                      if (transactions.isEmpty) {
                        return const Center(
                          child: Text('No transactions found'),
                        );
                      }

                      // Show transaction list
                      return ListView.builder(
                        itemCount: portfolioController.performanceResponseModel.transactionHistory?.length ?? 0,
                        itemBuilder: (context, index) {
                          final tx = transactions[index];
                          return Padding(
                            padding: const EdgeInsets.symmetric(vertical: 4.0),
                            child: Row(
                              children: [
                                Expanded(
                                  child: Text(
                                    index % 2 == 0
                                        ? '${portfolioController.performanceResponseModel.transactionHistory?[index].lastTransaction ?? ''}'
                                        : '${portfolioController.performanceResponseModel.transactionHistory?[index].lastTransaction ?? ''}',
                                    style: TextStyle(
                                      color: index % 2 == 0
                                          ? Colors.green
                                          : Colors.red,
                                    ),
                                  ),
                                ),
                                Expanded(child: Text(portfolioController.performanceResponseModel.transactionHistory?[index].symbol ?? '')),
                                Expanded(child: Text('${tx.currentPrice ?? ''}')),
                                Expanded(
                                    child: Center(
                                        child: Text('${tx.quantity ?? ''}'))),
                                Expanded(
                                  child: Center(
                                      child: Text('${tx.date ?? ''}')),
                                ),

                              ],
                            ),
                          );
                        },
                      );
                    },
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
