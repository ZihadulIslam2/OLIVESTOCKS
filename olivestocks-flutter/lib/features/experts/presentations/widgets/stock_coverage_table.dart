import 'package:flutter/material.dart';

class StockCoverageTable extends StatelessWidget {
  final List<Map<String, String>> stockData;

  const StockCoverageTable({super.key, required this.stockData});

  @override
  Widget build(BuildContext context) {
    //Size size = MediaQuery.of(context).size;
    return Container(
     // height: size.height * 1,
      width: double.infinity,

      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          /// Title
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0),
            child: Container(
              padding: const EdgeInsets.all(12),
              width: double.infinity,
              decoration: BoxDecoration(
                color: Colors.grey.shade300,
                borderRadius: BorderRadius.circular(0),
                border: Border.all(color: Colors.grey.shade300),
              ),
              child: const Text(
                "Stock Coverage",
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
            ),
          ),

          /// Column headers
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0),
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              width: double.infinity,
              decoration: BoxDecoration(
                color: Colors.green.shade100,
                borderRadius: BorderRadius.circular(0),
                border: Border.all(color: Colors.grey.shade300),
              ),
              child: const Padding(
                padding: EdgeInsets.symmetric(vertical: 8),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Expanded(
                      flex: 4,
                      child: Text(
                        "Company",
                        style: TextStyle(
                          fontWeight: FontWeight.w600,
                          fontSize: 14,
                        ),
                      ),
                    ),
                    Expanded(
                      flex: 4,
                      child: Text(
                        "Position",
                        style: TextStyle(
                          fontWeight: FontWeight.w600,
                          fontSize: 14,
                        ),
                      ),
                    ),
                    Expanded(
                      flex: 4,
                      child: Text(
                        "Price Target",
                        style: TextStyle(
                          fontWeight: FontWeight.w600,
                          fontSize: 14,
                        ),
                      ),
                    ),
                    // Expanded(
                    //   flex: 2,
                    //   child: Text(
                    //     " ",
                    //     style: TextStyle(
                    //       fontWeight: FontWeight.w600,
                    //       fontSize: 14,
                    //     ),
                    //   ),
                    // ),
                  ],
                ),
              ),
            ),
          ),

          /// Stock rows
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 4),
            child: ListView.builder(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              itemCount: stockData.length,
              itemBuilder: (context, index) {
                final stock = stockData[index];
                final isPositive = !stock['change']!.contains("-");

                return Column(
                  children: [
                    Container(
                      padding: const EdgeInsets.all(12),
                      decoration: BoxDecoration(
                        color: Colors.grey.shade300,
                        border: Border.all(color: Colors.grey.shade300),
                        borderRadius: BorderRadius.circular(0),
                      ),
                      child: Row(
                        children: [
                          /// Company Column
                          Expanded(
                            flex: 3,
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  stock["company"]!,
                                  style: const TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontSize: 14,
                                  ),
                                ),
                                const SizedBox(height: 2),
                                Text(
                                  stock["subtitle"]!,
                                  style: const TextStyle(
                                    color: Colors.black,
                                    fontSize: 11,
                                  ),
                                ),
                              ],
                            ),
                          ),

                          /// Position Column
                          Expanded(
                            flex: 2,
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  stock["position"]!,
                                  style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    color:
                                        stock["position"] == "BUY"
                                            ? Colors.green
                                            : Colors.orange,
                                    fontSize: 14,
                                  ),
                                ),
                                const SizedBox(height: 2),
                                Text(
                                  stock["date"]!,
                                  style: const TextStyle(
                                    fontSize: 11,
                                    color: Colors.black,
                                  ),
                                ),
                              ],
                            ),
                          ),

                          /// Price Target Column
                          Expanded(
                            flex: 3,
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.end,
                              children: [
                                Text(
                                  stock["price"]!,
                                  style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontSize: 14,
                                    color:
                                        isPositive ? Colors.green : Colors.red,
                                  ),
                                ),
                                const SizedBox(height: 2),
                                Text(
                                  "${stock["change"]} (${stock["status"]})",
                                  style: TextStyle(
                                    fontSize: 11,
                                    color:
                                        isPositive ? Colors.green : Colors.red,
                                  ),
                                ),
                              ],
                            ),
                          ),

                          const SizedBox(width: 16),

                          /// Icon Column
                          SizedBox(
                            width: 28,
                            child: Align(
                              alignment: Alignment.centerRight,
                              child: Icon(
                                isPositive
                                    ? Icons.arrow_drop_up
                                    : Icons.arrow_drop_down,
                                color: isPositive ? Colors.green : Colors.red,
                                size: 24,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),

                    /// Divider between rows except after last
                    if (index != stockData.length - 1)
                      SizedBox(
                        width: double.infinity,
                        child: const Divider(
                          color: Colors.grey,
                          thickness: 1,
                          height: 1,
                        ),
                      ),
                  ],
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
 