import 'dart:convert';

import 'package:flutter/widgets.dart';
import 'package:olive_stocks_flutter/features/sanky/domain/entity/sankey.dart';
import 'package:http/http.dart' as http;

sealed class SankyResponse {

}

class SankeyLoading extends SankyResponse {

}

class SankeyData extends SankyResponse {
  final Sankey sankey;

  SankeyData(this.sankey);
}

class SankeyController extends ChangeNotifier{
  SankyResponse _sankyResponse = SankeyLoading();
  SankyResponse get sankeyResponse => _sankyResponse;

  Future<Sankey?> getSankyFor({required String symbol}) async {


    // final response = await http.get(Uri.parse("http://localhost:3001/api/v1/stocks/revenue-breakdown?symbol=$symbol"));
    // print(response.body);
    // final rawData = jsonDecode(response.body);
    // final rawLinks = (rawData["links"] as List<dynamic>).map((data) => data as Map<String, dynamic>).toList();
    // final rawNodes = (rawData["nodes"] as List<dynamic>).map((data) => data as Map<String, dynamic>).toList();
    // _sankyResponse = SankeyData(Sankey(linksRawData: rawLinks, nodesRawData: rawNodes)); notifyListeners();
    _sankyResponse= SankeyData(Sankey.dummy());

    notifyListeners();

  }
}