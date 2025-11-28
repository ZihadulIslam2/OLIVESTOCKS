import 'package:flutter/material.dart';
import 'package:olive_stocks_flutter/features/news/domain/get_all_news_response_model.dart';
import '../../../../common/widgets/custom_cached_image_widget.dart';

class SingleMarketNewsWidget extends StatelessWidget {
  const SingleMarketNewsWidget({super.key, required this.newsData});
  final Data newsData;

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10.0),
      child: Container(
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(4),
          boxShadow: [
            BoxShadow(color: Colors.black26, spreadRadius: 2, blurRadius: 2),
          ],
        ),
        height: size.height * .13,
        child: Row(
          children: [
            const SizedBox(width: 10),
            Container(
              width: size.width * .35,
              height: size.height * .12,
              decoration: BoxDecoration(borderRadius: BorderRadius.circular(1)),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(10),
                child: GlobalCachedNetworkImage(imageUrl: newsData.newsImage!,),
                // child: Image.network(
                //   'https://plus.unsplash.com/premium_photo-1664474619075-644dd191935f?fm=jpg&q=60&w=3000&ixlib=rb-4.1.0&ixid=M3wxMjA3fDB8MHxzZWFyY2h8MXx8aW1hZ2V8ZW58MHx8MHx8fDA%3D',
                //   fit: BoxFit.cover,
                // ),
              ),
            ),
            const SizedBox(width: 10),
            Container(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    height: (size.height * .12) / 2,
                    width: size.width * .42,
                    // color: Colors.red,
                    child: Text(
                      'Want up to 11% Dividend Yield? Analysts Select 2 D',
                      style: TextStyle(
                        fontWeight: FontWeight.w700,
                        fontSize: 13,
                      ),
                    ),
                  ),
                  //const SizedBox(height: 10,),
                  Container(
                    width: size.width * .43,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          '10.00pm, 20/11/25',
                          style: TextStyle(
                            color: Colors.black45,
                            fontWeight: FontWeight.w700,
                            fontSize: 12,
                          ),
                        ),
                        Container(
                          height: 20,
                          width: size.width * .12,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(20),
                            border: Border.all(),
                          ),
                          child: Center(
                            child: Text(
                              'AAPL',
                              style: TextStyle(
                                fontSize: 11,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  Icon(Icons.bookmark_border, color: Colors.black45),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}