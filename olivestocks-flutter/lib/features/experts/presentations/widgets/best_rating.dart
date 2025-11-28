import 'package:flutter/material.dart';

import '../../../../common/data/analyst_data.dart';


class BestRatingSection extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final data = AnalystData.bestRating;
    final ratingType = data[1];

    


    // Determine color based on rating type
    Color ratingColor;
    if (ratingType.toLowerCase() == "buy") {
      ratingColor = Colors.green;
    } else if (ratingType.toLowerCase() == "sell") {
      ratingColor = Colors.red;
    } else if (ratingType.toLowerCase() == "hold") {
      ratingColor = Colors.orange;
    } else {
      ratingColor = Colors.black;
    }

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 0),
      child: Container(
        width: double.infinity,
        padding: const EdgeInsets.all(12),
        decoration: BoxDecoration(
          color: Colors.grey.shade100,
          borderRadius: BorderRadius.circular(10),
          border: Border.all(color: Colors.grey.shade300),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text("Best Rating",
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
            const SizedBox(height: 8),
            Text("Stock: ${data[0]}"),
            Row(
              children: [
              Text("Rating Type: "),Text("${data[1]},",
                  style: const TextStyle(color: Colors.green, fontWeight: FontWeight.bold)),
            ]),
            Text("Dates: ${data[2]}"),
            Text("Gain: ${data[3]}",
                style:  TextStyle(color: ratingColor, fontWeight: FontWeight.bold)),
          ],
        ),
      ),
    );
  }
}
