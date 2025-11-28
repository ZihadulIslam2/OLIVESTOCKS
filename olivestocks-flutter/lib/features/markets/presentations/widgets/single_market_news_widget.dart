import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:olive_stocks_flutter/common/data/all_data.dart';
import 'package:olive_stocks_flutter/common/widgets/custom_cached_image_widget.dart';
import 'package:olive_stocks_flutter/features/news/domain/get_all_news_response_model.dart';
import '../../../news/controllers/news_controller.dart';

class SingleMarketNewsWidget extends StatelessWidget {
  final Data newsData;

  const SingleMarketNewsWidget({super.key, required this.newsData});

  void togglePin() {
    final controller = Get.find<NewsController>();
    final index = controller.newsList.indexWhere((n) => newsData.id == newsData.id);
    if (index != -1) {
      final currentPinState = controller.newsList[index].isPinned ?? false;
      controller.newsList[index].isPinned = !currentPinState;

      controller.newsList.sort((a, b) {
        final aPinned = newsData.isPinned ?? false;
        final bPinned = newsData.isPinned ?? false;
        if (aPinned && !bPinned) return -1;
        if (!aPinned && bPinned) return 1;
        return 0;
      });

      controller.update();
    }
  }

  bool isArabic(String text) {
    return RegExp(r'[\u0600-\u06FF]').hasMatch(text);
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final title = newsData.newsTitle ?? '';
    final isTitleArabic = isArabic(title);

    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 5.0, horizontal: 10.0),
      child: Container(
        height: size.height * 0.13,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(6),
          boxShadow: const [
            BoxShadow(
              color: Colors.black12,
              blurRadius: 4,
              offset: Offset(0, 2),
            ),
          ],
        ),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // News Image
            ClipRRect(
              borderRadius: BorderRadius.circular(10),
              child: GlobalCachedNetworkImage(
                imageUrl: newsData.newsImage ?? '',
                width: size.width * 0.32,
                height: size.height * 0.12,
                fit: BoxFit.cover,
                errorWidget: (context, url, error) =>
                const Center(child: Icon(Icons.error)),
              ),
            ),
            const SizedBox(width: 10),

            // Text Area
            Expanded(
              child: Padding(
                padding: const EdgeInsets.symmetric(vertical: 6.0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // News title
                    Directionality(
                      textDirection:
                      isTitleArabic ? TextDirection.rtl : TextDirection.ltr,
                      child: Text(
                        title,
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                        style: const TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.w700,
                          fontFamily: 'Poppins',
                        ),
                        textAlign:
                        isTitleArabic ? TextAlign.right : TextAlign.left,
                      ),
                    ),

                    // Time + Source
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Flexible(
                          child: Text(
                            AllData.timeAgo(newsData.updatedAt ?? ''),
                            style: const TextStyle(
                              fontSize: 12,
                              color: Colors.black54,
                              fontWeight: FontWeight.w500,
                              fontFamily: 'Poppins',
                            ),
                            overflow: TextOverflow.ellipsis,
                          ),
                        ),
                        const SizedBox(width: 10),
                        Container(
                          constraints: const BoxConstraints(maxWidth: 80),
                          padding: const EdgeInsets.symmetric(
                              horizontal: 6, vertical: 2),
                          decoration: BoxDecoration(
                            border: Border.all(color: Colors.black26),
                            borderRadius: BorderRadius.circular(15),
                          ),
                          child: Text(
                            newsData.source ?? '',
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                            style: const TextStyle(
                              fontSize: 11,
                              fontWeight: FontWeight.bold,
                              color: Colors.black87,
                              fontFamily: 'Poppins',
                            ),
                          ),
                        ),
                      ],
                    ),

                    // Bookmark Icon
                    Align(
                      alignment: Alignment.bottomLeft,
                      child: GestureDetector(
                        onTap: togglePin,
                        child: Icon(
                          newsData.isPinned == true
                              ? Icons.bookmark
                              : Icons.bookmark_border,
                          size: 18,
                          color: newsData.isPinned == true
                              ? Colors.blue
                              : Colors.black45,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
