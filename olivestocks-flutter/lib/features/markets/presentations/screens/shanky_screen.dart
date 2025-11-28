import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_echarts/flutter_echarts.dart';
import 'package:get/get.dart';

import '../../../news/controllers/news_controller.dart';
import '../../../news/presentations/screens/news_details_screen.dart';
import '../../../portfolio/presentations/widgets/SingleStockMarketUpcomingEventsWidget.dart';
import '../../../portfolio/presentations/widgets/single_market_news_widget.dart';
import '../../../sanky/controller/controller.dart';
import '../../../sanky/domain/entity/sankey.dart';
import '../../../sanky/view/sankey_echart.dart';
import '../widgets/single_stock_market_upcoming_events_widget.dart';

class SankyScreen extends StatefulWidget {
  final String symbol;
  const SankyScreen({Key? key, required this.symbol}) : super(key: key);

  static final SankeyController sankeyController = SankeyController();

  @override
  State<SankyScreen> createState() => _SankyScreenState();
}

class _SankyScreenState extends State<SankyScreen> {

  @override
  void initState() {
    Get.find<NewsController>().getAllNews(widget.symbol);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    SankyScreen.sankeyController.getSankyFor(symbol: widget.symbol);
    Size size = MediaQuery.of(context).size;
    return Scaffold(
        appBar: AppBar(
          title: const Text('Stocks Earning'),
        ),
        body: SingleChildScrollView(
          child: Column(
            children: [
              ListenableBuilder(
                  listenable: SankyScreen.sankeyController,
                  builder: (context, before) {
                    Sankey? sankyData;
                    if(SankyScreen.sankeyController.sankeyResponse is SankeyData) {
                      sankyData = (SankyScreen.sankeyController.sankeyResponse as SankeyData).sankey;
                    }

                    return Container(
                      width: size.width,
                      child: (SankyScreen.sankeyController.sankeyResponse is SankeyLoading) ?
                      Center(child: Text("Loading sanky..."))
                          : Center(
                        child: Column(
                          children: [
                            SizedBox(
                              height: size.height * .85,
                              width: size.width,
                              child: Padding(
                                padding: const EdgeInsets.all(12.0),
                                child: Echarts(
                                  onLoad: (p0) {

                                  },
                                  onWebResourceError: (p0, p1) {
                                  },
                                  key: Key(DateTime.now().toIso8601String()),
                                  reloadAfterInit: true,
                                  onMessage: (message) {
                                  },
                                  option: '''
                            {
                            "tooltip": {
                              "trigger": "item",
                              "triggerOn": "mousemove",
                              "formatter": "{a} <br/>{b} : {c}"
                            },
                            "series": [
                              {
                                "type": "sankey",
                                "orient": "vertical",
                                "roam": false,
                                "layout": "none",    
                                "nodeAlign": "justify",
                                "nodeGap": 20,
                                "nodeWidth": 15,
                                "layoutIterations": 32,
                                "emphasis": {
                                  "focus": "adjacency"
                                },
                                "lineStyle": {
                                  "color": "gradient",
                                  "curveness": 0.5
                                },
                                "data": ${sankyData!.nodesRawData.map((node) => jsonEncode(node)).toList()},
                                "links": ${sankyData.linksRawData.map((link) => jsonEncode(link)).toList()},
                                "label": {
                                  "show": true,
                                  "color": "#333",
                                  "fontWeight": "normal",
                                  "fontSize": 10,
                                  "position": "right", 
                                  "rotate": -90,
                                  "offset": [15, 0],
                                  "overflow": "none",
                                  "width": 60,
                                  "lineHeight": 12,
                                  "backgroundColor": "rgba(255,255,255,0.8)",
                                  "padding": [2, 4],
                                  "borderRadius": 2
                                },
                                "itemStyle": {
                                  "borderWidth": 0.5,
                                  "borderColor": "#ccc"
                                }
                              }
                            ]
                            }
                            ''',
                                ),
                              ),
                            ),
                            SizedBox(height: 20),
                          ],
                        ),
                      ),
                    );
                  }
              ),
              SizedBox(height: 20),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 18.0),
                child: Container(
                  width: size.width,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(4),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black26,
                        spreadRadius: 2,
                        blurRadius: 2,
                      ),
                    ],
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(14.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Latest News',
                          style: TextStyle(
                            fontWeight: FontWeight.w700,
                            fontSize: 18,
                          ),
                        ),
                        SizedBox(height: 15),

                        GetBuilder<NewsController>(
                          builder: (newsController) {
                            return newsController.isLoadingNew
                                ? Container(
                              height: size.height * 0.5,
                              child: Center(
                                child: CircularProgressIndicator(),
                              ),
                            )
                                : ListView.builder(
                              physics: NeverScrollableScrollPhysics(),
                              shrinkWrap: true,
                              itemCount:
                              newsController
                                  .getAllNewsResponseModel
                                  .data
                                  ?.length,
                              itemBuilder: (context, index) {
                                return GestureDetector(
                                  onTap: () {
                                    Get.to(
                                      NewsDetailsScreen(
                                        newsData:
                                        newsController
                                            .getAllNewsResponseModel
                                            .data![index],
                                      ),
                                    );
                                  },
                                  child: SingleMarketNewsWidget(
                                    newsData:
                                    newsController
                                        .getAllNewsResponseModel
                                        .data![index],
                                  ),
                                );
                              },
                            );
                          },
                        ),
                        SizedBox(height: 10),
                        Align(
                          alignment: Alignment.center,
                          child: Text(
                            'Show More News',
                            style: TextStyle(
                              color: Colors.green,
                              fontWeight: FontWeight.w500,
                              fontSize: 14,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              SizedBox(height: 20),
              SingleStockMarketDailyGainersLosers(),
              SizedBox(height: 20),
              SingleStockMarketUpcomingEventsWidget(),
              SizedBox(height: 60),
            ],
          ),
        )
    );
  }
}
