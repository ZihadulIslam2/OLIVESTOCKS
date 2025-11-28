import 'package:flutter/material.dart';
import 'package:flutter_html/flutter_html.dart';
// import 'package:olive_stocks_flutter/common/widgets/custom_cached_image_widget.dart';
import '../../../markets/presentations/widgets/single_market_news_widget.dart';
import '../../domain/get_all_news_response_model.dart';

class NewsDetailsScreen extends StatefulWidget {
  final Data newsData;

  const NewsDetailsScreen({super.key, required this.newsData});

  @override
  State<NewsDetailsScreen> createState() => _NewsDetailsScreenState();
}

class _NewsDetailsScreenState extends State<NewsDetailsScreen> {
  bool isArabic(String text) {
    final arabicRegex = RegExp(r'[\u0600-\u06FF]');
    return arabicRegex.hasMatch(text);
  }

  @override
  Widget build(BuildContext context) {
    final title = widget.newsData.newsTitle ?? '';
    final description = widget.newsData.newsDescription ?? '';
    final imageUrl = widget.newsData.newsImage ?? '';
    final isTitleArabic = isArabic(title);
    final isDescriptionArabic = isArabic(description);

    print("🖼️ News Image URL: $imageUrl");

    return Scaffold(
      appBar: AppBar(title: const Text('News')),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Directionality(
                textDirection: isTitleArabic ? TextDirection.rtl : TextDirection.ltr,
                child: Text(
                  title,
                  style: const TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.w600,
                    fontFamily: 'Poppins',
                  ),
                  textAlign: isTitleArabic ? TextAlign.right : TextAlign.left,
                ),
              ),
              const SizedBox(height: 16),

              if (imageUrl.isNotEmpty)
                ClipRRect(
                  borderRadius: BorderRadius.circular(8),
                  child: Image.network(
                    imageUrl,
                    fit: BoxFit.cover,
                    errorBuilder: (context, error, stackTrace) =>
                    const Icon(Icons.broken_image, size: 60),
                    loadingBuilder: (context, child, loadingProgress) {
                      if (loadingProgress == null) return child;
                      return const Center(child: CircularProgressIndicator());
                    },
                  ),
                ),

              const SizedBox(height: 16),
              Directionality(
                textDirection: isDescriptionArabic ? TextDirection.rtl : TextDirection.ltr,
                child: Html(
                  data: description,
                  style: {
                    "*": Style(
                      fontFamily: 'Poppins',
                      fontSize: FontSize(16),
                      textAlign: isDescriptionArabic ? TextAlign.right : TextAlign.left,
                    ),
                  },
                ),
              ),
              const SizedBox(height: 30),
              const Text(
                'Related News',
                style: TextStyle(
                  fontWeight: FontWeight.w700,
                  fontSize: 18,
                  fontFamily: 'Poppins',
                ),
              ),
              const SizedBox(height: 10),
            ],
          ),
        ),
      ),
    );
  }
}
