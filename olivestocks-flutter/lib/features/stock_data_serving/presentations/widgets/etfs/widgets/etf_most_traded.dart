import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../../../markets/presentations/screens/single_stock_market.dart';
import '../../table_model/most_traded_model.dart';


class MostTradedETFs extends StatefulWidget {
  final List<MsFinancialInstrument>? stocks;
  final List<MsFinancialInstrument>? etfs;


  const MostTradedETFs({
    super.key,
    this.stocks,
    this.etfs,
  }) : assert(stocks != null || etfs != null, 'Either stocks or etfs must be provided');


  @override
  State<MostTradedETFs> createState() => _MostTradedETFsState();
}

class _MostTradedETFsState extends State<MostTradedETFs> {
  bool showGainers = true;

  List<MsFinancialInstrument> get instrumentList =>
      widget.stocks ?? widget.etfs ?? [];

  bool get isStockList => widget.stocks != null;

  List<MsFinancialInstrument> get displayList => showGainers
      ? instrumentList.where((item) => item.percentageChange >= 0).toList()
      : instrumentList.where((item) => item.percentageChange < 0).toList();

  @override
  Widget build(BuildContext context) {
    final title = isStockList ? 'Most-traded Stocks' : 'Most traded ETFs';
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
              offset: const Offset(0, 3), // changes position of shadow
            ),
          ],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(height: 16),
            Padding(
              padding: const EdgeInsets.only(left: 12),
              child: Text(
                title,
                style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
              ),
            ),
            const SizedBox(height: 8),
            Container(
              padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 12),
              color: Color(0xffEAF6EC),
              child: const Row(
                children: [
                  Expanded(
                    flex: 4,
                    child: Text('Company', style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
                  ),
                  Expanded(
                    flex: 2,
                    child: Text('Volumne', style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
                  ),
                  Expanded(
                    flex: 3,
                    child: Text(
                      'Price \nChange',
                      textAlign: TextAlign.right,
                      style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                    ),
                  ),
                ],
              ),
            ),
            ...displayList.map(_buildRow).toList(),
            const SizedBox(height: 12),
            Center(
              child: TextButton(onPressed: (){}, child: Text('See more',style: TextStyle(color: Colors.green),),
              ),),
          ],
        ),
      ),
    );
  }

  Widget _buildRow(MsFinancialInstrument instrument) {
    final isPositive = instrument.percentageChange >= 0;
    final percentText = '${isPositive ? '+' : ''}${instrument.percentageChange.toStringAsFixed(2)}%';
    final valueText = '${isPositive ? '+' : '-'}\$${instrument.valueChange.abs().toStringAsFixed(2)}';
    final color =  Colors.red;
    final icon = Icons.arrow_drop_down;

    return GestureDetector(
      onTap: (){

        Get.to(SingleStockMarket(symbol: '',));

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
                    instrument.ticker,
                    style: const TextStyle(fontWeight: FontWeight.bold,fontSize: 14),
                  ),
                  Text(
                    instrument.description,
                    style: const TextStyle(fontSize: 12),
                  ),
                ],
              ),
            ),
            Expanded(
              flex: 2,
              child: Text(
                '\$${instrument.currentValue.toStringAsFixed(2)}M',
                style: const TextStyle(fontSize: 16),
              ),
            ),
            Expanded(
              flex: 3,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      Icon(icon, color: color, size: 30),
                      Text(
                        percentText,
                        style: TextStyle(
                          color: color,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                  Text(
                    valueText,
                    style: TextStyle(
                      color: color,
                      fontSize: 12,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
