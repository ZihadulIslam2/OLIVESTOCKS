import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_echarts/flutter_echarts.dart';
import 'package:olive_stocks_flutter/features/sanky/domain/entity/sankey.dart';

import '../controller/controller.dart';


class SankeyEChart extends StatefulWidget {
  final double height;
  final double width;
  final String symbol;
  const SankeyEChart({super.key, required this.symbol, required this.height, required this.width});



  @override
  State<SankeyEChart> createState() => _SankeyEChartState();
}

class _SankeyEChartState extends State<SankeyEChart> {

  static final SankeyController sankeyController = SankeyController();

  @override
  void didUpdateWidget(covariant SankeyEChart oldWidget) {
    // TODO: implement didUpdateWidget
    super.didUpdateWidget(oldWidget);
  }
  // Map<String, dynamic> get chartOptions => {
  @override
  Widget build(BuildContext context) {
    sankeyController.getSankyFor(symbol: widget.symbol);
    Size size = MediaQuery.of(context).size;
    return Container(
      height: size.height * .77,
      child: ListenableBuilder(
          listenable: sankeyController,
          builder: (context, before) {
            Sankey? sankyData;
            if(sankeyController.sankeyResponse is SankeyData) {
              sankyData = (sankeyController.sankeyResponse as SankeyData).sankey;
            }

            return Container(
              height: size.height * .77,
              width: size.width,
              child: (sankeyController.sankeyResponse is SankeyLoading) ?
              Center(child: Text("Loading sanky..."))
                  : Center(
                child: Column(
                  children: [

                    SizedBox(
                      height: widget.height * .77,
                      width: widget.width,
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
                          "triggerOn": "mousemove"
                        },
                        "series": [
                          {
                            "type": "sankey",
                            "orient": "vertical", 
                            "roam": false,
                            "layout": "none",    
                            "nodeAlign": "justify",
                            "nodeGap": 20,
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
                                "color": "black",
                                "position": "bottom", 
                                "rotate": 0,
                              }
                            }
                          ]
                        }
                        ''',
                        ),

                      ),
                    ),

                  ],
                ),
              ),
            );

          }
      ),
    );
  }
}