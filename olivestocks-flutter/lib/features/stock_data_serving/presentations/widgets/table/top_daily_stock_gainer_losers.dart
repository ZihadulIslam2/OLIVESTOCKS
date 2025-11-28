import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../markets/presentations/screens/single_stock_market.dart';
import '../../../../portfolio/controller/portfolio_controller.dart';
import '../../../../portfolio/domains/daily_gainer_and_looser_model.dart';

class TopGainersLosers extends StatefulWidget {
  final List<Gainers>? stocks;
  final List<Losers>? losers;

  const TopGainersLosers({super.key, this.stocks, this.losers});

  @override
  State<TopGainersLosers> createState() => _TopGainersLosersState();
}

class _TopGainersLosersState extends State<TopGainersLosers> {
  bool showGainers = true;

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final title = 'Top Daily Stock Gainers/Losers';

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
                style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
              ),
            ),
            const SizedBox(height: 8),
            Padding(
              padding: const EdgeInsets.only(left: 12),
              child: Row(
                children: [
                  Theme(
                    data: Theme.of(context).copyWith(
                      chipTheme: Theme.of(context).chipTheme.copyWith(
                        checkmarkColor: Colors.transparent,
                      ),
                    ),
                    child: ChoiceChip(
                      label: const Text('Gainers'),
                      selected: showGainers,
                      onSelected: (_) => setState(() => showGainers = true),
                      selectedColor: Colors.green.shade600,
                      labelStyle: TextStyle(
                        color: showGainers ? Colors.white : Colors.black,
                      ),
                    ),
                  ),
                  const SizedBox(width: 8),
                  Theme(
                    data: Theme.of(context).copyWith(
                      chipTheme: Theme.of(context).chipTheme.copyWith(
                        checkmarkColor: Colors.transparent,
                      ),
                    ),
                    child: ChoiceChip(
                      label: const Text('Losers'),
                      selected: !showGainers,
                      onSelected: (_) => setState(() => showGainers = false),
                      selectedColor: Colors.red.shade600,
                      labelStyle: TextStyle(
                        color: !showGainers ? Colors.white : Colors.black,
                      ),
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 16),
            Container(
              padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 12),
              color: const Color(0xffEAF6EC),
              child: const Row(
                children: [
                  Expanded(
                    flex: 4,
                    child: Text(
                      'Company',
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                        color: Color(0xff595959),
                      ),
                    ),
                  ),
                  Expanded(
                    flex: 2,
                    child: Text(
                      'Price',
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                        color: Color(0xff595959),
                      ),
                    ),
                  ),
                  Expanded(
                    flex: 3,
                    child: Text(
                      'Price \nChange',
                      textAlign: TextAlign.right,
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                        color: Color(0xff595959),
                      ),
                    ),
                  ),
                ],
              ),
            ),

            if (showGainers == true)
              ...widget.stocks!.map((gainer) => _buildRow(gainer)).toList(),
            if (showGainers == false)
              ...widget.losers!.map((loser) => _buildRowLosers(loser)).toList(),
            const SizedBox(height: 12),
            Center(
              child: TextButton(
                onPressed: () {

                },
                child: Text(
                  'See more',
                  style: TextStyle(color: Colors.green.shade600),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildRow(Gainers gainer) {
    Size size = MediaQuery.of(context).size;
    return GestureDetector(
      onTap: () {
        Get.to(SingleStockMarket(symbol: gainer.symbol!));
      },
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 12),
        decoration: const BoxDecoration(
          border: Border(bottom: BorderSide(color: Colors.grey, width: 0.2)),
        ),
        child: TopGainerWidgetItem(gainer: gainer),
      ),
    );
  }

  Widget _buildRowLosers(Losers loser) {
    return GestureDetector(
      onTap: () {
        Get.to(SingleStockMarket(symbol: loser.symbol!,));
      },
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 12),
        decoration: const BoxDecoration(
          border: Border(bottom: BorderSide(color: Colors.grey, width: 0.2)),
        ),
        child: TopLoserWidgetItem(losers: loser),
      ),
    );
  }

}

class TopLoserWidgetItem extends StatelessWidget {
  final Losers losers;

  const TopLoserWidgetItem({super.key, required this.losers});


  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Row(
      children: [
        Expanded(
          flex: 4,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                losers.symbol ?? '',
                style: const TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 14,
                ),
              ),
              Text(
                losers.name ?? '',
                style: const TextStyle(fontSize: 12),
              ),
            ],
          ),
        ),
         Container(
           width: size.width * .35,
            child: Text(
              '\$${losers.currentPrice ?? '0.00'}',
              style: const TextStyle(fontSize: 16),
            ),
          ),

        Column(
          children: [
            Text(
              '\▼ ${losers.changePercent ?? '0.00%'}%',
              textAlign: TextAlign.right,
              style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold,color: Colors.red),
            ),
            Text(
              '\+${losers.change ?? '0.00%'}%',
              textAlign: TextAlign.right,
              style: const TextStyle(fontSize: 10, fontWeight: FontWeight.w400,color: Colors.green),
            ),
          ],
        ),
      ],
    );
  }
}

class TopGainerWidgetItem extends StatelessWidget {
  final Gainers gainer;

  const TopGainerWidgetItem({super.key, required this.gainer});

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Expanded(
          flex: 4,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                gainer.symbol ?? '',
                style: const TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 14,
                ),
              ),
              Text(
                gainer.name ?? '',
                style: const TextStyle(fontSize: 12),
              ),
            ],
          ),
        ),
        Container(
          width: size.width * .35,
          child: Text(
            '\$${gainer.currentPrice ?? '0.00'}',
            style: const TextStyle(fontSize: 16),
          ),
        ),

        Column(
          children: [
            Text(
              '\▲${gainer.changePercent ?? '0.00%'}%',
              textAlign: TextAlign.right,
              style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold,color: Colors.green),
            ),
            Text(
              '\+${gainer.change ?? '0.00%'}%',
              textAlign: TextAlign.right,
              style: const TextStyle(fontSize: 10, fontWeight: FontWeight.w400,color: Colors.green),
            ),
          ],
        ),
      ],
    );
  }
}
