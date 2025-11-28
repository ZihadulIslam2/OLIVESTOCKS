import 'package:flutter/material.dart';

import '../../../../common/data/analyst_data.dart';


class AdditionalInfoSection extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final data = AnalystData.additionalInfo;
    //Size size = MediaQuery.of(context).size;

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 0),
      child: Container(
      //  height: size.height * .11,
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
            const Text("Additional Information",
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
            const SizedBox(height: 8),
            Text("Main Sector: ${data[0]}"),
            Text("GEO Coverage: ${data[1]}"),
          ],
        ),
      ),
    );
  }
}
