import 'dart:collection';
import 'dart:math';
import 'dart:ui';


part 'sankey_node.dart';
part 'sankey_link.dart';

extension OffsetClamp on Offset {
  Offset clamp(Offset min, Offset max) {
    return Offset(
      dx.clamp(min.dx, max.dx),
      dy.clamp(min.dy, max.dy),
    );
  }
}

base class Sankey {
  final List<Map<String, dynamic>> nodesRawData;
  final List<Map<String, dynamic>> linksRawData;

  Sankey({required this.linksRawData, required this.nodesRawData});

  factory Sankey.reversed({
    required List<Map<String, dynamic>> linksRawData,
    required List<Map<String, dynamic>> nodesRawData,
  }) {
    for(final link in linksRawData) {
      String temp = link["source"];
      link["source"] = link["target"];
      link["target"] = temp;
    }

    return Sankey(linksRawData: linksRawData, nodesRawData: nodesRawData);
  }


  factory Sankey.dummy() {
    final List<Map<String, dynamic>> dummyNodes = [
      { "name": "Search" },
      { "name": "YouTube" },
      { "name": "Google AdSense" },
      { "name": "Google Play" },
      { "name": "Google Cloud" },
      { "name": "Verily (Other Bets)" },
      { "name": "Ad Revenue" },
      { "name": "Other Revenue" },
      { "name": "Revenue" },
      { "name": "Gross Profit" },
      { "name": "Operating Expenses" },
      { "name": "Cost of Revenue" },
      { "name": "Net Profit" },
      { "name": "Tax" },
      { "name": "Other Expenses" },
      { "name": "R&D" },
      { "name": "Sales & Marketing (S&M)" },
      { "name": "General & Admin (G&A)" },
      { "name": "TAC (Traffic Acquisition Costs)" },
    ];

    final List<Map<String, dynamic>> dummyLinks = [
      { "source": "Ad Revenue", "target": "Search", "value": 44.0 },
      { "source": "Ad Revenue", "target": "YouTube", "value": 8.0 },
      { "source": "Ad Revenue", "target": "Google AdSense", "value": 7.7 },
      { "source": "Revenue", "target": "Ad Revenue", "value": 59.6 },

      { "source": "Other Revenue", "target": "Google Play", "value": 8.3 },
      { "source": "Other Revenue", "target": "Google Cloud", "value": 8.4 },
      { "source": "Other Revenue", "target": "Verily (Other Bets)", "value": 0.3 },
      { "source": "Revenue", "target": "Other Revenue", "value": 17.0 },

      { "source": "Gross Profit", "target": "Revenue", "value": 43.5 },
      { "source": "Cost of Revenue", "target": "Revenue", "value": 33.2 },

      { "source": "Operating Expenses", "target": "Gross Profit", "value": 22.1 },
      { "source": "Net Profit", "target": "Gross Profit", "value": 19.7 },
      { "source": "Net Profit", "target": "Gross Profit", "value": 19.7 },

      { "source": "R&D", "target": "Operating Expenses", "value": 11.3 },
      { "source": "Sales & Marketing (S&M)", "target": "Operating Expenses", "value": 6.9 },
      { "source": "General & Admin (G&A)", "target": "Operating Expenses", "value": 4.0 },

      { "source": "Other Expenses", "target": "Cost of Revenue", "value": 20.6 },
      { "source": "TAC (Traffic Acquisition Costs)", "target": "Cost of Revenue", "value": 12.6 },

      { "source": "Tax", "target": "Net Profit", "value": 1.5 },
    ];
    return Sankey(linksRawData: dummyLinks, nodesRawData: dummyNodes);
  }
}