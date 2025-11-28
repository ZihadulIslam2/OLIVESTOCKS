import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:olive_stocks_flutter/portfolio_smart_score/presentation/screens/see_transaction_history.dart';
import '../../../features/portfolio/controller/portfolio_controller.dart';
import '../../../features/portfolio/domains/get_portfolio_by_id_response_model.dart' as getPortfolioByIdResponseModel;
import '../../../features/portfolio/domains/overall_balance_response_model.dart';

class PortfolioSmartScoreScreen extends StatelessWidget {
  final String id;
  final String symbol;
  final String name;

  PortfolioSmartScoreScreen({
    super.key,
    this.id = '',
    required this.symbol,
    required this.name,
  });

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: Colors.grey[50],
      appBar: AppBar(
        title: const Text('Portfolio Smart Score'),
        elevation: 0,
        actions: [
          IconButton(icon: const Icon(Icons.more_vert), onPressed: () {}),
        ],
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: GetBuilder<PortfolioController>(
            builder: (portfolioController) {
              final stocks = portfolioController.overallBalanceResponseModel;
              return portfolioController.isPortfolioLoading
                  ? Center(child: CircularProgressIndicator())
                  : Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Header Section
                  _buildHeaderSection(context, stocks),
                  const SizedBox(height: 10),

                  // Stock Title Section
                  buildStockTitleSection(context),
                  const SizedBox(height: 14),

                  // Portfolio Details Section
                  buildPortfolioDetailsSection(context, stocks),
                  const SizedBox(height: 14),

                  // Transactions Section
                  buildTransactionsSection(context, symbol, portfolioId: '',),
                  SizedBox(height: 24),
                  Container(
                    height: size.height * .05,
                    child: ElevatedButton(
                      onPressed: () {},
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.green,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8),
                        ),
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(Icons.add, color: Colors.white, size: 25),
                          Text(
                            'Add Transaction',
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              color: Colors.white,
                              fontSize: 18,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              );
            },
          ),
        ),
      ),
    );
  }

  Widget _buildHeaderSection(BuildContext context, OverallBalanceResponseModel? stocks) {
    Size size = MediaQuery.of(context).size;

    // Find the current holding for this symbol
    Holding? currentHolding;
    if (stocks?.holdings != null) {
      try {
        currentHolding = stocks!.holdings!.firstWhere(
              (holding) => holding.symbol?.toLowerCase() == symbol.toLowerCase(),
        );
      } catch (e) {
        currentHolding = null;
      }
    }

    // Calculate portfolio percentage
    String portfolioPercentage = "0.00%";
    if (currentHolding != null && stocks?.totalValueWithCash != null) {
      try {
        double holdingValue = double.tryParse(currentHolding.value ?? "0") ?? 0;
        double totalValue = double.tryParse(stocks!.totalValueWithCash ?? "0") ?? 0;
        if (totalValue > 0) {
          double percentage = (holdingValue / totalValue) * 100;
          portfolioPercentage = "${percentage.toStringAsFixed(2)}%";
        }
      } catch (e) {
        portfolioPercentage = "0.00%";
      }
    }

    return Column(
      crossAxisAlignment: CrossAxisAlignment.end,
      children: [
        Container(
          height: size.height * .170,
          width: size.width,
          decoration: BoxDecoration(
            color: Color(0xffBCE4C5),
            borderRadius: BorderRadius.circular(8),
            boxShadow: [
              BoxShadow(
                color: Colors.grey.withOpacity(0.2),
                spreadRadius: 1,
                blurRadius: 1,
                offset: const Offset(0, 1),
              ),
            ],
          ),
          child: Column(
            children: [
              Container(
                height: 100,
                width: size.width * .9,
                child: Row(
                  children: [
                    Container(
                      width: (size.width * .9) - 25,
                      child: Center(
                        child: CircleAvatar(
                          radius: 45,
                          backgroundImage: NetworkImage(
                            currentHolding?.logo ??
                                'https://www.freepik.com/vectors/crypto-avatar',
                          ),
                        ),
                      ),
                    ),
                    Align(
                      alignment: Alignment.topRight,
                      child: Container(
                        height: 25,
                        width: 25,
                        child: Align(
                          alignment: Alignment.topRight,
                          child: IconButton(
                            onPressed: () {},
                            icon: Icon(Icons.delete_outline_outlined),
                            color: Colors.red,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              Spacer(),
              Text(
                '$portfolioPercentage of New Portfolio Mar 2025',
                style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold),
              ),
              SizedBox(height: 5),
            ],
          ),
        ),
        TextButton(
          onPressed: () {
            Get.to(() => TransactionHistoryScreen(id: id));
          },
          child: Text(
            'See Transaction History',
            style: TextStyle(color: Colors.green),
          ),
        ),
      ],
    );
  }

  Widget buildStockTitleSection(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return GetBuilder<PortfolioController>(builder: (portfolioController) {
      return Container(
        height: size.height * .07,
        // width: size.width * .25,
        decoration: BoxDecoration(
          color: Color(0xffDFF2E3),
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
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                symbol,
                style: const TextStyle(fontSize: 14, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 2),
              Text(
                name,
                style: TextStyle(fontSize: 12, color: Colors.grey[600]),
              ),
            ],
          ),
        ),
      );
    });
  }

  Widget buildPortfolioDetailsSection(BuildContext context, OverallBalanceResponseModel? stocks) {
    Size size = MediaQuery.of(context).size;

    // Find the current holding for this symbol
    Holding? currentHolding;
    if (stocks?.holdings != null) {
      try {
        currentHolding = stocks!.holdings!.firstWhere(
              (holding) => holding.symbol?.toLowerCase() == symbol.toLowerCase(),
        );
      } catch (e) {
        currentHolding = null;
      }
    }

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          height: size.height * .05,
          width: size.width,
          decoration: BoxDecoration(
            color: Color(0xffBCE4C5),
            borderRadius: BorderRadius.circular(4),
          ),
          child: Center(
            child: const Text(
              'New Portfolio Mar 2025',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
          ),
        ),
        const SizedBox(height: 16),

        // Details Rows
        Container(
          padding: const EdgeInsets.all(8),
          height: size.height * .29,
          width: size.width,
          decoration: BoxDecoration(
            color: Color(0xffEAF6EC),
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
          child: Column(
            children: [
              Row(
                children: [
                  Text(
                    'Number of Shares:',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      color: Colors.black,
                      fontSize: 16,
                    ),
                  ),
                  Spacer(),
                  Container(
                    height: size.height * .03,
                    width: size.width * .15,
                    child: TextFormField(
                      textAlign: TextAlign.center,
                      initialValue: currentHolding?.shares?.toString() ?? '0',
                      decoration: InputDecoration(
                        contentPadding: const EdgeInsets.only(bottom: 2),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(6),
                          borderSide: const BorderSide(
                            color: Color(0xff737373),
                            width: 1,
                          ),
                        ),
                      ),
                    ),
                  ),
                  IconButton(
                    onPressed: () {},
                    icon: Icon(
                      Icons.mode_edit_outline_outlined,
                      color: Colors.green,
                    ),
                  ),
                ],
              ),
              Divider(thickness: 1, color: Color(0xffDFF2E3)),
              Row(
                children: [
                  Text(
                    'Average Purchase Price:',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      color: Colors.black,
                      fontSize: 16,
                    ),
                  ),
                  Spacer(),
                  Container(
                    height: size.height * .03,
                    width: size.width * .18,
                    child: TextFormField(
                      textAlign: TextAlign.center,
                      initialValue: '\$${currentHolding?.avgBuyPrice?.toStringAsFixed(2) ??'0.00'}',
                      decoration: InputDecoration(
                        contentPadding: const EdgeInsets.only(bottom: 2),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(6),
                          borderSide: const BorderSide(
                            color: Color(0xff737373),
                            width: 1,
                          ),
                        ),
                      ),
                    ),
                  ),
                  IconButton(
                    onPressed: () {},
                    icon: Icon(
                      Icons.mode_edit_outline_outlined,
                      color: Colors.green,
                    ),
                  ),
                ],
              ),
              Divider(thickness: 1, color: Color(0xffDFF2E3)),
              Row(
                children: [
                  Text(
                    'Added Date',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      color: Colors.black,
                      fontSize: 16,
                    ),
                  ),
                  Spacer(),
                  Text(
                    'Mar 25, 2025', // You might want to add this field to your model
                    style: TextStyle(
                      fontWeight: FontWeight.w400,
                      color: Color(0xff4E4E4E),
                      fontSize: 12,
                    ),
                  ),
                ],
              ),
              Divider(thickness: 1, color: Color(0xffDFF2E3)),
              Row(
                children: [
                  Text(
                    'Holding Value',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      color: Colors.black,
                      fontSize: 16,
                    ),
                  ),
                  Spacer(),
                  Text(
                    '\$${currentHolding?.value?? '\$0.00'}',
                    style: TextStyle(
                      fontWeight: FontWeight.w400,
                      color: Color(0xff4E4E4E),
                      fontSize: 14,
                    ),
                  ),
                ],
              ),
              Divider(thickness: 1, color: Color(0xffDFF2E3)),
              Row(
                children: [
                  Text(
                    'Gain Since Added',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      color: Colors.black,
                      fontSize: 16,
                    ),
                  ),
                  Spacer(),
                  Text(
                    currentHolding?.percent != null
                        ? '${currentHolding!.percent! >= 0 ? '+' : ''}${currentHolding.percent!.toStringAsFixed(2)}%'
                        : '+0.00%',
                    style: TextStyle(
                      fontWeight: FontWeight.w400,
                      color: (currentHolding?.percent ?? 0) >= 0 ? Colors.green : Colors.red,
                      fontSize: 14,
                    ),
                  ),
                ],
              ),
              Divider(thickness: 1, color: Color(0xffDFF2E3)),
            ],
          ),
        ),
      ],
    );
  }


  Widget buildTransactionsSection(BuildContext context, String symbol, {required String portfolioId,}) {
    Size size = MediaQuery.of(context).size;

    return GetBuilder<PortfolioController>(

      initState: (_) {
        final portfolioController = Get.find<PortfolioController>();
        portfolioController.getPortfolioById(portfolioId);
      },

      builder: (portfolioController) {
        if (portfolioController.isPortfolioByLoading) {
          return const Center(child: CircularProgressIndicator());
        }

        final stocks = portfolioController.getPortfolioByIdResponseModel.stocks ?? [];

        final selectedStock = stocks.firstWhere(
              (s) => s.symbol == symbol,
          orElse: () => getPortfolioByIdResponseModel.Stocks(
            symbol: symbol,
            transection: [],
            date: 'date', // fallback
          ),
        );

        final transactions = selectedStock.transection ?? [];
        final stockDate = selectedStock.date ?? 'N/A';

        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              height: size.height * .05,
              width: size.width,
              decoration: BoxDecoration(
                color: const Color(0xffBCE4C5),
                borderRadius: BorderRadius.circular(4),
              ),
              child: Center(
                child: Text(
                  '$symbol Transactions',
                  style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                ),
              ),
            ),
            const SizedBox(height: 10),
            Container(
              decoration: BoxDecoration(
                color: const Color(0xffe5f4ea),
                border: Border.all(color: Colors.grey),
                borderRadius: BorderRadius.circular(8),
              ),
              child: Column(
                children: [
                  Container(
                    height: size.height * .05,
                    width: size.width,
                    color: const Color(0xffBCE4C5),
                    child: const Padding(
                      padding: EdgeInsets.all(8.0),
                      child: Row(
                        children: [
                          Expanded(flex: 2, child: Text('Action', style: TextStyle(fontWeight: FontWeight.bold))),
                          Expanded(flex: 2, child: Text('Shares', style: TextStyle(fontWeight: FontWeight.bold))),
                          Expanded(flex: 3, child: Text('Price', style: TextStyle(fontWeight: FontWeight.bold))),
                          Expanded(flex: 3, child: Text('Date', style: TextStyle(fontWeight: FontWeight.bold))),
                          Expanded(flex: 1, child: Text('Edit', style: TextStyle(fontWeight: FontWeight.bold))),
                        ],
                      ),
                    ),
                  ),

                  if (transactions.isNotEmpty)
                    ...transactions.asMap().entries.map((entry) {
                      final t = entry.value;
                      return Column(
                        children: [
                          buildTransactionRow(
                            t.event ?? '-',
                            '${t.quantity ?? 0}',
                            '\$${t.price?.toStringAsFixed(2) ?? '0.00'}',
                            stockDate, // use stock date
                          ),
                          if (entry.key < transactions.length - 1) buildDivider(),
                        ],
                      );
                    }).toList()
                  else
                    const Padding(
                      padding: EdgeInsets.all(16.0),
                      child: Text("No transactions available."),
                    ),
                ],
              ),
            ),
          ],
        );
      },
    );
  }

  Widget buildTransactionRow(String action, String shares, String price, String date) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Row(
        children: [
          Expanded(flex: 2, child: Text(action)),
          Expanded(flex: 2, child: Text(shares)),
          Expanded(flex: 3, child: Text(price)),
          Expanded(flex: 3, child: Text(date)),
          const Expanded(flex: 1, child: Icon(Icons.edit, size: 18)),
        ],
      ),
    );
  }

  Widget buildDivider() {
    return Divider(height: 1, color: Colors.grey[300]);
  }




}

