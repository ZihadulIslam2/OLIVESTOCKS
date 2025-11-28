import 'package:flutter/material.dart';

import '../../etfs/widgets/etf_analysts_top.dart';
import '../../etfs/widgets/etf_daily_ratings.dart';
import '../../etfs/widgets/etf_most_traded.dart';
import '../../etfs/widgets/etf_upcoming_events.dart';
import '../../table/most_traded.dart';
import '../../table/top_daily_stock_gainer_losers.dart';

import '../../table_model/most_traded_model.dart';
import '../../table_model/stock_etf_model.dart';

// import 'etf_top_gainers_losers.dart'; // Uncomment when ready

class EtfsTab extends StatelessWidget {
  final TabController? tabController;
  final List<FinancialInstrument> etfList = [
    FinancialInstrument(
      ticker: 'VOO',
      description: 'Vanguard S&P 500\nETF',
      currentValue: 382.15,
      percentageChange: 0.52,
      valueChange: 1.97,
    ),
    FinancialInstrument(
      ticker: 'ARKK',
      description: 'ARK Innovation\nETF',
      currentValue: 41.67,
      percentageChange: -2.33,
      valueChange: -0.99,
    ),
    FinancialInstrument(
      ticker: 'DIA',
      description: 'SPDR Dow Jones\nETF',
      currentValue: 345.22,
      percentageChange: 1.05,
      valueChange: 3.58,
    ),
    FinancialInstrument(
      ticker: 'VOO',
      description: 'Vanguard S&P 500\nETF',
      currentValue: 382.15,
      percentageChange: 0.52,
      valueChange: 1.97,
    ),
    FinancialInstrument(
      ticker: 'ARKK',
      description: 'ARK Innovation\nETF',
      currentValue: 41.67,
      percentageChange: -2.33,
      valueChange: -0.99,
    ),
    FinancialInstrument(
      ticker: 'DIA',
      description: 'SPDR Dow Jones\nETF',
      currentValue: 345.22,
      percentageChange: 1.05,
      valueChange: 3.58,
    ),

    FinancialInstrument(
      ticker: 'VOO',
      description: 'Vanguard S&P 500\nETF',
      currentValue: 382.15,
      percentageChange: 0.52,
      valueChange: 1.97,
    ),
    FinancialInstrument(
      ticker: 'ARKK',
      description: 'ARK Innovation\nETF',
      currentValue: 41.67,
      percentageChange: -2.33,
      valueChange: -0.99,
    ),
    FinancialInstrument(
      ticker: 'DIA',
      description: 'SPDR Dow Jones\nETF',
      currentValue: 345.22,
      percentageChange: 1.05,
      valueChange: 3.58,
    ),
    FinancialInstrument(
      ticker: 'VOO',
      description: 'Vanguard S&P 500\nETF',
      currentValue: 382.15,
      percentageChange: 0.52,
      valueChange: 1.97,
    ),
  ];
  final List<MsFinancialInstrument> etfList1 = [
    MsFinancialInstrument(
      ticker: 'MSFT',
      description: 'Microsoft Corp.\nTech Giant',
      currentValue: 16.49,
      percentageChange: 1.45,
      valueChange: 4.72,
    ),
    MsFinancialInstrument(
      ticker: 'NFLX',
      description: 'Netflix Inc.\nStreaming Leader',
      currentValue: 420.67,
      percentageChange: -0.98,
      valueChange: -4.12,
    ),
    MsFinancialInstrument(
      ticker: 'NVDA',
      description: 'NVIDIA Corp.\nAI & GPUs',
      currentValue: 690.35,
      percentageChange: 3.87,
      valueChange: 25.75,
    ),
    MsFinancialInstrument(
      ticker: 'MSFT',
      description: 'Microsoft Corp.\nTech Giant',
      currentValue: 330.22,
      percentageChange: 1.45,
      valueChange: 4.72,
    ),
    MsFinancialInstrument(
      ticker: 'NFLX',
      description: 'Netflix Inc.\nStreaming Leader',
      currentValue: 420.67,
      percentageChange: -0.98,
      valueChange: -4.12,
    ),
    MsFinancialInstrument(
      ticker: 'NVDA',
      description: 'NVIDIA Corp.\nAI & GPUs',
      currentValue: 690.35,
      percentageChange: 3.87,
      valueChange: 25.75,
    ),

    MsFinancialInstrument(
      ticker: 'MSFT',
      description: 'Microsoft Corp.\nTech Giant',
      currentValue: 330.22,
      percentageChange: 1.45,
      valueChange: 4.72,
    ),
    MsFinancialInstrument(
      ticker: 'NFLX',
      description: 'Netflix Inc.\nStreaming Leader',
      currentValue: 420.67,
      percentageChange: -0.98,
      valueChange: -4.12,
    ),
    MsFinancialInstrument(
      ticker: 'NVDA',
      description: 'NVIDIA Corp.\nAI & GPUs',
      currentValue: 690.35,
      percentageChange: 3.87,
      valueChange: 25.75,
    ),
  ];
  EtfsTab({super.key, required this.tabController});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        children: [

          //TopGainersLosers(etfs: etfList),
          const SizedBox(height: 16),
          MostTradedETFs(etfs: etfList1),
          const SizedBox(height: 16),
          // const EtfTopDaily(),
          const EtfUpcomingEvents(),
          const SizedBox(height: 16),
          const EtfAnalystsTop(),
          const SizedBox(height: 16),
          const EtfDailyRatings(),

        ],
      ),
    );
  }
}
