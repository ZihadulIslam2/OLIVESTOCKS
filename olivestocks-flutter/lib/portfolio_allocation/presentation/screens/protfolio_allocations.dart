import 'dart:math';

import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:olive_stocks_flutter/features/portfolio/controller/portfolio_controller.dart';

import '../../../features/portfolio/domains/asset_allocation_response_model.dart';

class PortfolioAllocationsScreen extends StatefulWidget {
  const PortfolioAllocationsScreen({super.key});

  @override
  State<PortfolioAllocationsScreen> createState() => _PortfolioAllocationsScreenState();
}

class _PortfolioAllocationsScreenState extends State<PortfolioAllocationsScreen> {
  int selectedChipIndex = 0;
  List<String> tabs = ["Sector"];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        leading: const BackButton(color: Colors.black),
        title: const Text('Portfolio Allocations'),
      ),
      body: GetBuilder<PortfolioController>(builder: (portfolioController) {
        return !portfolioController.isAssetAllocationLoading
            ? SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.only(left: 8.0, right: 8.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Container(
                      padding: const EdgeInsets.all(16),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.all(Radius.circular(24)),
                        border: Border.all(color: Colors.grey, width: 0.5),
                      ),
                      child: SingleChildScrollView(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Text(
                              'Portfolio Distribution Analysis',
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                color: Colors.black,
                                fontSize: 18,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                            const SizedBox(height: 8),
                            Text(
                              'Comparing New Portfolio (March 2025) with Average Portfolio Allocation ',
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                color: Colors.black,
                                fontSize: 12,
                                fontWeight: FontWeight.w400,
                              ),
                            ),
                            const SizedBox(height: 16),

                            // Sector content directly without TabView
                            Container(
                              width: double.infinity,
                              margin: const EdgeInsets.all(10),
                              padding: const EdgeInsets.all(16),
                              decoration: BoxDecoration(
                                color: Color(0xffF9FAFB),
                                borderRadius: BorderRadius.circular(10),
                              ),
                              child: Column(
                                children: [
                                  const SizedBox(height: 36),
                                  Text(
                                    'New Portfolio Mar 2025',
                                    style: TextStyle(
                                      fontWeight: FontWeight.w500,
                                      fontSize: 18,
                                      color: Colors.black,
                                    ),
                                  ),
                                  const SizedBox(height: 36),
                                  NewProtfolioWidget(
                                      title1: 'Stocks',
                                      title2: 'Cash',
                                      stockPercent: double.tryParse(portfolioController
                                          .assetAllocationResponseModel!
                                          .assetAllocation!
                                          .stocks ??
                                          '0') ??
                                          0,
                                      cashPercent: double.tryParse(portfolioController
                                          .assetAllocationResponseModel!
                                          .assetAllocation!
                                          .cash ??
                                          '0') ??
                                          0,
                                      size: 130),
                                ],
                              ),
                            ),

                            Container(
                              width: double.infinity,
                              height: 600,
                              margin: const EdgeInsets.all(10),
                              padding: const EdgeInsets.all(16),
                              decoration: BoxDecoration(
                                color: Color(0xffF9FAFB),
                                borderRadius: BorderRadius.circular(10),
                              ),
                              child: Column(
                                children: [
                                  Text(
                                    "Average Portfolio",
                                    style: TextStyle(
                                      fontWeight: FontWeight.w500,
                                      fontSize: 18,
                                    ),
                                  ),
                                  const SizedBox(height: 36),
                                  AveragePortfolioWidget(
                                    holdingsBySector: portfolioController
                                        .assetAllocationResponseModel!
                                        .holdingsBySector,
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            )
            : Center(child: CircularProgressIndicator());
      }),
    );
  }
}

class NewProtfolioWidget extends StatefulWidget {
  final double stockPercent; // 0–100
  final double cashPercent; // 0–100 percent2;
  final double size; // The total size of the circular widget
  final Color fontColor;
  final bool isPartner;
  final String? title1;
  final String? title2;

  final AssetAllocation? assetAllocation;
  const NewProtfolioWidget({
    super.key,
    required this.stockPercent,
    required this.cashPercent,
    this.size = 30,
    this.fontColor = Colors.black,
    this.isPartner = false,
    required this.title1,
    required this.title2,
    this.assetAllocation,
  });

  @override
  State<NewProtfolioWidget> createState() => _NewProtfolioWidgetState();
}

class _NewProtfolioWidgetState extends State<NewProtfolioWidget> {
  @override
  Widget build(BuildContext context) {
    final double clampedPercent = widget.stockPercent.clamp(0, 100).toDouble();
    final double progressValue = (clampedPercent / 100.0);
    final double strokeWidth = widget.size * 0.08;
    return Column(
      children: [
        SizedBox(
          width: widget.size,
          height: widget.size,
          child: Stack(
            alignment: Alignment.center,
            children: [
              SizedBox(
                width: widget.size,
                height: widget.size,
                child: CircularProgressIndicator(
                  strokeCap: StrokeCap.square,
                  value: progressValue,
                  strokeWidth: strokeWidth,
                  valueColor: AlwaysStoppedAnimation<Color>(
                    _getProgressColor(clampedPercent, widget.isPartner),
                  ),
                  backgroundColor: Colors.red,
                ),
              ),
            ],
          ),
        ),
        const SizedBox(height: 36),
        Column(
          children: [
            Container(
              width: 220,
              height: 30,
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(10),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  Text(
                    widget.title1!,
                    style: TextStyle(
                      fontWeight: FontWeight.w600,
                      fontSize: 14,
                      color: widget.fontColor,
                    ),
                  ),
                  Text(
                    (widget.stockPercent.toDouble()).toStringAsFixed(2) + '%',
                    style: TextStyle(
                      color: Colors.green,
                      fontWeight: FontWeight.w600,
                      fontSize: 14,
                    ),
                  ),
                ],
              ),
            ),
            Container(
              width: 220,
              height: 30,
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(10),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  Text(
                    widget.title2!,
                    style: TextStyle(
                        fontWeight: FontWeight.w600,
                        fontSize: 14,
                        color: widget.fontColor),
                  ),
                  Text(
                    (widget.cashPercent.toDouble()).toStringAsFixed(2) + '%',
                    style: TextStyle(
                      fontWeight: FontWeight.w600,
                      fontSize: 14,
                      color: Colors.red,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ],
    );
  }

  Color _getProgressColor(double percent, bool isPartner) {
    if (isPartner == false)
      return Colors.green;
    else
      return Colors.green;
  }
}

class MultiColorCircleIndicator extends StatelessWidget {
  final double size;
  final Map<String, double> segments;

  MultiColorCircleIndicator({
    super.key,
    required this.size,
    required this.segments,
  });

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
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return GetBuilder<PortfolioController>(builder: (portfolioController) {
      return SizedBox(
        width: size.width,
        height: size.height * 0.15,
        child: PieChart(
          PieChartData(
            sectionsSpace: 0,
            centerSpaceRadius: 70,
            sections: List.generate(
              portfolioController
                  .assetAllocationResponseModel!.holdingsBySector!.length,
                  (index) {
                final asset = portfolioController
                    .assetAllocationResponseModel!.holdingsBySector![index];
                return PieChartSectionData(
                  color: pieColors[index % pieColors.length],
                  radius: 12,
                  showTitle: false,
                );
              },
            ),
          ),
        ),
      );
    });
  }
}

class AveragePortfolioWidget extends StatefulWidget {
  final List<HoldingsBySector>? holdingsBySector;

   AveragePortfolioWidget({super.key, this.holdingsBySector});

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
  State<AveragePortfolioWidget> createState() => _AveragePortfolioWidgetState();
}

class _AveragePortfolioWidgetState extends State<AveragePortfolioWidget> {
  Map<String, double> segments = {};

  @override
  Widget build(BuildContext context) {
    for (int i = 0; i < widget.holdingsBySector!.length; i++) {
      segments[widget.holdingsBySector![i].sector ?? ''] =
          double.tryParse(widget.holdingsBySector![i].percent!) ?? 0;
    }
    Size size = MediaQuery.of(context).size;
    return Column(
      children: [
        MultiColorCircleIndicator(
          size: size.height * .2,
          segments: segments,
        ),
        const SizedBox(height: 36),
        Column(
          children: [
            Container(
              width: size.width * .9,
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(10),
              ), // Added padding for better spacing
              child: Column(

                children: List.generate(
                  widget.holdingsBySector!.length,
                      (d) => Padding(
                    padding: const EdgeInsets.symmetric(vertical: 8.0),
                    child: Row(

                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Container(
                          width: 14,
                          height: 14,
                          margin: const EdgeInsets.only(left: 8),
                          decoration: BoxDecoration(
                            color: widget.pieColors[d % widget.pieColors.length],
                            shape: BoxShape.circle,
                          ),
                        ),
                        SizedBox(width: 8),
                        Text(
                          widget.holdingsBySector![d].sector ?? '',
                          style: TextStyle(
                            fontWeight: FontWeight.w600,
                            fontSize: 14,
                            color: Colors.black,
                          ),
                          overflow: TextOverflow.ellipsis,
                        ),
                        Spacer(),
                        Text(
                          '${widget.holdingsBySector![d].percent}%',
                          style: TextStyle(
                            fontWeight: FontWeight.w600,
                            fontSize: 14,
                            color: Colors.black,
                          ),
                        ),

                      ],
                    ),
                  ),
                ),

              ),
            ),
          ],
        ),
      ],
    );
  }
}