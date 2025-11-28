import 'package:flutter/material.dart';
import '../../domain/get_all_subcription_response_model.dart';
import 'feature_item_type_widget.dart';

class FeatureBaseWidget extends StatelessWidget {
  final SubscriptionPlan data;

  const FeatureBaseWidget({super.key, required this.data});

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Column(
      children: [
        Column(
            children: List.generate(data.features!.length, (index) {
              return  FeatureItemTypeWidget(feature: data.features![index], featureTitle: data.features![index].featuresType!,);
            }
            )),

      ],
    );
  }
}
