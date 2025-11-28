import 'package:flutter/material.dart';

import '../../../../common/widgets/cutom_profile_image.dart';
import '../../../../common/widgets/default_circular_percent_widget.dart';

class ExpertCard extends StatefulWidget {
  final int selectedSortTab;
  const ExpertCard({super.key, required this.selectedSortTab});

  @override
  State<ExpertCard> createState() => _ExpertCardState();
}

  class _ExpertCardState extends State<ExpertCard> {

  @override
  Widget build(BuildContext context) {
    int selectedSortTab = widget.selectedSortTab;
    Size size = MediaQuery.of(context).size;
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            children: [
              // ProfileAvatarWithBadge(
              //   imagePath: "assets/images/man.jpeg",
              //   badgeNumber: 11,
              // ),
              const SizedBox(width: 20),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: const [
                  Text(
                    "Alex Mitchell",
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                  Text("TD Cowen", style: TextStyle(color: Colors.grey)),
                  Row(
                    children: [
                      Icon(Icons.star, color: Colors.amber, size: 16),
                      Icon(Icons.star, color: Colors.amber, size: 16),
                      Icon(Icons.star, color: Colors.amber, size: 16),
                      Icon(Icons.star, color: Colors.amber, size: 16),
                      Icon(Icons.star_half, color: Colors.amber, size: 16),
                    ],
                  ),
                ],
              ),
            ],
          ),


           Row(
             children: [
              Icon(Icons.arrow_drop_up_outlined, color: Colors.green, size: size.width * 0.07),
               Text(
                "11.58%",
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  color: Colors.green,
                  fontSize: 16,
                ),
                         ),
             ],
           ),
          CircularPercentWidget(percent: 68, selectedSortTab: selectedSortTab),

          // Container(
          //   width: 40,
          //   height: 40,
          //   alignment: Alignment.center,
          //   decoration: BoxDecoration(
          //     shape: BoxShape.circle,
          //     border: Border.all(color: Colors.green, width: 5),
          //   ),
          //   child: const Text(
          //     "68%",
          //     style: TextStyle(
          //       fontWeight: FontWeight.bold,
          //       color: Colors.green,
          //     ),
          //   ),
          // )
        ],
      ),
    );
  }
}
