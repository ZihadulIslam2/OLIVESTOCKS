import 'package:flutter/material.dart';
import 'package:percent_indicator/percent_indicator.dart';

class ProtfolioHealth extends StatefulWidget {
  const ProtfolioHealth({super.key});

  @override
  State<ProtfolioHealth> createState() => _ProtfolioHealthState();
}

class _ProtfolioHealthState extends State<ProtfolioHealth> {
  bool isExpanded = true;

  final int index = 7; // current health index (1-10)

  Color getIndexColor(int i) {
    if (i <= 3) return Colors.redAccent;
    if (i <= 5) return Colors.amber;
    if (i <= 6) return Colors.yellow[600]!;
    if (i == 7) return Colors.green[700]!;
    return Colors.lightGreen;
  }

  @override
  Widget build(BuildContext context) {
    //Size size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        leading: const BackButton(color: Colors.black),
        title: const Text('Protfolio Health Index'),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Container(
              width: double.infinity,
              margin: const EdgeInsets.all(10),
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: Color(0xffF3F4F6),
                borderRadius: BorderRadius.circular(10),
              ),
              child: Column(
                children: [
                  isExpanded
                      ? Text(
                        "See your portfolio's Health Index, based on a weighted average of the performance metrics  of each of your holdings. See your portfolio's Health Index, based on a weighted average of the performance metrics  of each of your holdings. See your portfolio's Health Index, based on a weighted average of the performance metrics  of each of your holdings. See your portfolio's Health Index, based on a weighted average of the performance metrics  of each of your holdings. See your portfolio's Health Index, based on a weighted average of the performance metrics  of each of your holdings. ",
                        style: TextStyle(
                          fontWeight: FontWeight.w400,
                          fontSize: 13,
                        ),
                      )
                      : Text(
                        "See your portfolio's Health Index, based on a weighted average of the performance metrics of each of your holdings.",
                        style: const TextStyle(
                          fontWeight: FontWeight.w400,
                          fontSize: 13,
                        ),
                      ),
                  Align(
                    alignment: Alignment.centerLeft,
                    child: TextButton(
                      onPressed: () {
                        setState(() {
                          isExpanded = !isExpanded;
                        });
                      },
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Text(
                            isExpanded ? "Show Less" : "Learn More",
                            style: const TextStyle(color: Colors.green),
                          ),
                          Icon(
                            !isExpanded
                                ? Icons.arrow_drop_down_rounded
                                : Icons.arrow_drop_up_rounded,
                            color: Colors.green,
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 16),
            Container(
              width: double.infinity,
              margin: const EdgeInsets.all(10),
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: Color(0xffF3F4F6),
                borderRadius: BorderRadius.circular(10),
              ),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(
                    "Portfolio Health Index",
                    style: const TextStyle(
                      fontWeight: FontWeight.w500,
                      fontSize: 18,
                    ),
                  ),
                  const SizedBox(height: 16),
                  PortfolioHealthIndicator(index: 8),
                  const SizedBox(height: 16),
                  ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.green,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(24),
                      ),
                      padding: const EdgeInsets.symmetric(
                        horizontal: 24,
                        vertical: 12,
                      ),
                    ),
                    onPressed: () {},
                    child: const Text(
                      "View Top Performing Assets",
                      style: TextStyle(color: Colors.white),
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 16),
            Container(
              width: double.infinity,
              margin: const EdgeInsets.all(10),
              padding: const EdgeInsets.all(24),
              decoration: BoxDecoration(
                color: Color(0xffF3F4F6),
                borderRadius: BorderRadius.circular(10),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Text(
                    "Performance Distribution",
                    style: const TextStyle(
                      fontWeight: FontWeight.w500,
                      fontSize: 18,
                    ),
                  ),
                  const SizedBox(height: 16),
                  Center(
                    child: Container(
                      height: 160,
                      width: 160,
                      // color: Colors.white,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Text(
                            "$index",
                            style: const TextStyle(
                              fontSize: 48,
                              fontWeight: FontWeight.bold,
                              color: Colors.green,
                            ),
                          ),
                          const Text(
                            "Balanced",
                            style: TextStyle(fontWeight: FontWeight.w500),
                          ),
                        ],
                      ),
                    ),
                  ),
                  const SizedBox(height: 16),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Column(
                        children: [
                          PerformanceDistributionWith(percent: 10, size: 40),
                          const SizedBox(height: 12),
                          PerformanceDistributionWith(percent: 9, size: 40),
                          const SizedBox(height: 12),
                          PerformanceDistributionWith(percent: 8, size: 40),
                          const SizedBox(height: 12),
                          PerformanceDistributionWith(percent: 7, size: 40),
                          const SizedBox(height: 12),
                          PerformanceDistributionWith(percent: 6, size: 40),
                          const SizedBox(height: 12),
                        ],
                      ),
                      const SizedBox(width: 24),
                      Column(
                        children: [
                          PerformanceDistributionWith(percent: 5, size: 40),
                          const SizedBox(height: 12),
                          PerformanceDistributionWith(percent: 4, size: 40),
                          const SizedBox(height: 12),
                          PerformanceDistributionWith(percent: 3, size: 40),
                          const SizedBox(height: 12),
                          PerformanceDistributionWith(percent: 2, size: 40),
                          const SizedBox(height: 12),
                          PerformanceDistributionWith(percent: 1, size: 40),
                          const SizedBox(height: 12),
                        ],
                      ),
                    ],
                  ),
                ],
              ),
            ),
            const SizedBox(height: 16),
            
          ],
        ),
      ),
    );
  }
}

class PortfolioHealthIndicator extends StatelessWidget {
  final int index; // Must be between 1 to 10

  const PortfolioHealthIndicator({super.key, required this.index})
    : assert(index >= 1 && index <= 10);

  // Color based on health index
  Color getIndexColor(int i) {
    if (i <= 3) return Colors.redAccent;
    if (i <= 5) return Colors.amber;
    if (i <= 6) return Colors.yellow[700]!;
    if (i == 7) return Colors.green[700]!;
    return Colors.lightGreen;
  }

  // Text label based on index
  String getIndexLabel(int i) {
    if (i <= 3) return "Poor";
    if (i <= 5) return "Fair";
    if (i == 6 || i == 7) return "Balanced";
    return "Healthy";
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        CircularPercentIndicator(
          radius: 60.0,
          lineWidth: 10.0,
          percent: index / 10,
          center: Text(
            "$index",
            style: const TextStyle(
              fontSize: 28,
              fontWeight: FontWeight.bold,
              color: Colors.green,
            ),
          ),
          progressColor: Colors.green,
          backgroundColor: Colors.grey[200]!,
          circularStrokeCap: CircularStrokeCap.round,
        ),
        const SizedBox(height: 8),
        Text(
          getIndexLabel(index),
          style: const TextStyle(fontWeight: FontWeight.w500),
        ),
        const SizedBox(height: 16),
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 4, vertical: 8),
          decoration: BoxDecoration(
            color: Colors.grey[100],
            borderRadius: BorderRadius.circular(12),
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: List.generate(10, (i) {
              final isSelected = (i + 1) == index;

              return Column(
                children: [
                  AnimatedContainer(
                    duration: const Duration(milliseconds: 300),
                    width: size.width * 0.08,
                    height: 8,
                    decoration: BoxDecoration(
                      color: getIndexColor(i + 1),
                      borderRadius: BorderRadius.circular(4),
                      boxShadow:
                          isSelected
                              ? [
                                BoxShadow(
                                  color: Colors.grey.withOpacity(0.4),
                                  spreadRadius: 1,
                                  blurRadius: 4,
                                  offset: const Offset(0, 2),
                                ),
                              ]
                              : [],
                    ),
                  ),
                  const SizedBox(height: 4),
                  Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 6,
                      vertical: 2,
                    ),
                    decoration:
                        isSelected
                            ? BoxDecoration(
                              color: Colors.grey[300],
                              borderRadius: BorderRadius.circular(6),
                              boxShadow: [
                                BoxShadow(
                                  color: Colors.black.withOpacity(0.2),
                                  spreadRadius: 1,
                                  blurRadius: 4,
                                  offset: const Offset(0, 2),
                                ),
                              ],
                            )
                            : null,
                    child: Text(
                      "${i + 1}",
                      style: TextStyle(
                        fontSize: 10,
                        fontWeight: FontWeight.w500,
                        color: isSelected ? Colors.black : Colors.grey,
                      ),
                    ),
                  ),
                ],
              );
            }),
          ),
        ),
      ],
    );
  }
}

class PerformanceDistributionWith extends StatefulWidget {
  final int percent; // 0–100
  final double size; // The total size of the circular widget
  final Color fontColor;
  final bool isPartner;
  const PerformanceDistributionWith({
    super.key,
    required this.percent,
    this.size = 30,
    this.fontColor = Colors.black,
    this.isPartner = false,
  });

  @override
  State<PerformanceDistributionWith> createState() =>
      _PerformanceDistributionWithState();
}

class _PerformanceDistributionWithState
    extends State<PerformanceDistributionWith> {
  @override
  Widget build(BuildContext context) {
    final double clampedPercent = widget.percent.clamp(0, 100).toDouble();
    final double progressValue = (clampedPercent / 100.0) * 10;
    final double strokeWidth = widget.size * 0.08;
    final double fontSize = widget.size * 0.30; //0.25 defalult
    return Row(
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
                  strokeCap: StrokeCap.round,
                  value: progressValue,
                  strokeWidth: strokeWidth,
                  valueColor: AlwaysStoppedAnimation<Color>(
                    _getProgressColor(clampedPercent, widget.isPartner),
                  ),
                  backgroundColor: Color(0xffD9D9D9), // Light gray background
                ),
              ),
              Text(
                '${clampedPercent.toInt()}',
                style: TextStyle(
                  fontWeight: FontWeight.w400,
                  fontSize: fontSize,
                  color: widget.fontColor,
                ),
              ),
            ],
          ),
        ),
        const SizedBox(width: 8),
        Text(
          (widget.percent.toDouble()).toStringAsFixed(2) + '%',
          style: TextStyle(
            fontWeight: FontWeight.w400,
            fontSize: fontSize,
            color: widget.fontColor,
          ),
        ),
      ],
    );
  }

  Color _getProgressColor(double percent, bool isPartner) {
    if (isPartner == false)
      return Colors.green;
    else
      return Colors.green;

    // if (percent >= 75) return Color(0xff4B91C9);
    // if (percent >= 50) return Color(0xff4B91C9);
    //;return Color(0xff4B91C9);
  }
}
