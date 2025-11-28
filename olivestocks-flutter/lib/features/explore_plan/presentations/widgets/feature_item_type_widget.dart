import 'package:flutter/material.dart';

import '../../domain/get_all_subcription_response_model.dart';
import 'feature_item.dart';

class FeatureItemTypeWidget extends StatelessWidget {
  final Feature feature;
  final String featureTitle;

  const FeatureItemTypeWidget({super.key, required this.feature, required this.featureTitle});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.only(left: 32),
          child: Container(
            height: 30,
            color: feature.featuresType == 'Core'
                ? Colors.green.withOpacity(.2)
                : feature.featuresType == 'Premium'
                ? Colors.orange.withOpacity(.2)
                : feature.featuresType == 'ultimate'
                ? Colors.lightBlue.withOpacity(.2)
                : Colors.white,
            child: Align(
              alignment: Alignment.centerLeft,
              child: Padding(
                padding: const EdgeInsets.only(left: 10),
                child: Text(
                  '$featureTitle Feature',
                  style: TextStyle(
                    fontSize: 12,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ),
            ),
          ),
        ),
        SizedBox(height: 12),
        Padding(
          padding: const EdgeInsets.only(
            left: 32,
            right: 32,
          ),
          child: Container(
            decoration: BoxDecoration(),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: List.generate(feature.type!.length, (index){
                return Padding(
                  padding: const EdgeInsets.only(bottom: 8.0),
                  child: FeatureItemWidget( icon: feature.type![index].active! ? 'assets/logos/check.png' : 'assets/logos/cross.png' ,title: feature.type![index].name!,),
                );
              }),
            ),
          ),
        ),
      ],
    );
  }
}
