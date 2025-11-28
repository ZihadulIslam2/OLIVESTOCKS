
import 'package:flutter/material.dart';
import 'package:olive_stocks_flutter/features/stock_data_serving/presentations/widgets/pro_ratings_widget.dart';
import 'package:olive_stocks_flutter/features/stock_data_serving/presentations/widgets/pro_widget.dart';
import 'package:olive_stocks_flutter/features/stock_data_serving/presentations/widgets/rating_star_widget.dart';

class DailyListWidget extends StatelessWidget {
  const DailyListWidget({super.key, required this.context});

  final BuildContext context;

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        children: [
          const Divider(height: 1, thickness: 1),
          _buildHeaderRow(),
          const Divider(height: 1, thickness: 1),
          _buildListContent(),
        ],
      ),
    );
  }

  Widget _buildHeaderRow() {
    Size size = MediaQuery.of(context).size;
    return Padding(
      padding: const EdgeInsets.only(left: 16, right: 16),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Container(
            width: size.width * .20,
            child: const Text(
              "Analyst",
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 12),
            ),
          ),
          const Spacer(),
          Container(
            width: size.width * .56,
            child: Row(
              children: [
                const Text(
                  "Company",
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 12),
                ),
                const Spacer(),
                const Text(
                  "Price Target",
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 12),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildListContent() {
    Size size = MediaQuery.of(context).size;

    return ListView.builder(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      itemCount: 20,
      itemBuilder: (context, index) {
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Stock Item
            InkWell(
              onTap: () {
                //Get.to(AdsScreen());
              },
              child: Center(
                child: Container(
                  padding: const EdgeInsets.all(12),
                  decoration: const BoxDecoration(color: Colors.transparent),
                  child: Column(
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          // Stock Info Section
                          Container(
                            height: size.height * .065,
                            width: size.width * .23,
                            child: Row(
                              children: [
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    ProRatingsWidget(),
                                    Text('N/A',style: TextStyle(color: Colors.green,fontSize: 12,fontWeight: FontWeight.w400),),
                                    StarRatingWidget(rating: 3,),
                                  ],
                                ),
                              ],
                            ),
                          ),
                          // Price and Ratings Section
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              // Price Change Section
                              Container(
                                width: size.width * .30,
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [ProWidget()],
                                ),
                              ),
                              // Analyst Ratings Section
                             Column(
                               crossAxisAlignment: CrossAxisAlignment.end,
                               children: [
                                 Text('\$55'),
                                 const Text(
                                   "▲27.27% (Upside)",
                                   style: TextStyle(fontSize: 14, color: Colors.green,fontWeight: FontWeight.w500),
                                 ),
                                 Row(
                                   children: [
                                     Text('Upgraded,04/06/25',style: TextStyle(fontWeight: FontWeight.w400),),
                                     Icon(Icons.lock,size:15,color: Colors.red,),
                                   ],
                                 )
                               ],
                             )
                            ],
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ),
            const Divider(height: 1, thickness: 1),
            const SizedBox(height: 4),
          ],
        );
      },
    );
  }
}
