import 'package:flutter/material.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:get/get.dart';
import '../../../auth/controllers/auth_controller.dart';
import '../../../explore_plan/presentations/screens/explore_plan_screen.dart';
import '../../domain/get_deep_research_response_model.dart';

class DeepResearchNewsDetailsScreen extends StatelessWidget {
  final NewsData newsData;
  final String symbol;

  DeepResearchNewsDetailsScreen({
    super.key,
    required this.newsData,
    required this.symbol,
  });

  final AuthController _auth = Get.find<AuthController>();

  bool isArabic(String text) => RegExp(r'[\u0600-\u06FF]').hasMatch(text);

  String previewHtml(String? html, double pct) {
    final content = html ?? '';
    if (content.isEmpty) return '';
    final len = content.length;
    int cut = (len * pct).toInt();
    if (cut < 1) cut = 1;
    if (cut > len) cut = len;
    return content.substring(0, cut);
  }

  void _showUpgradeDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (_) => AlertDialog(
        title: const Text("Upgrade Required"),
        content: const Text("This feature is available for subscribed users only."),
        actions: [
          TextButton(onPressed: () => Navigator.pop(context), child: const Text("Cancel")),
          ElevatedButton(
            onPressed: () => Get.to(() => const ExplorePlanScreen()),
            style: ElevatedButton.styleFrom(backgroundColor: Colors.green),
            child: const Text("Upgrade Plan", style: TextStyle(color: Colors.white)),
          ),
        ],
      ),
    );
  }

  Widget _lockedPreview(BuildContext context, String content) {
    final preview = previewHtml(content, 0.3);
    Size size = MediaQuery.of(context).size;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Stack(
          children: [
            Html(data: preview),
            Positioned.fill(
              child: IgnorePointer(
                child: Container(
                  decoration: const BoxDecoration(
                    gradient: LinearGradient(
                      begin: Alignment.center,
                      end: Alignment.bottomCenter,
                      colors: [Colors.transparent, Colors.white70, Colors.white],
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
        const SizedBox(height: 12),
        Center(
          child: SizedBox(
            width: size.width * 0.47,
            child: ElevatedButton(
              onPressed: () => _showUpgradeDialog(context),
              style: ElevatedButton.styleFrom(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20),
                  ),
                  backgroundColor: Colors.green
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                const Icon(Icons.menu_book, color: Colors.white,size: 25,),
                SizedBox(width: 3,),
                Text("Continue Reading", style: TextStyle(color: Colors.white,fontWeight: FontWeight.bold))]),
            ),
          ),
        ),
      ],
    );
  }

  // Helper function to check if user has a paid subscription
  bool _isPaidUser(String subscriptionStatus) {
    if (subscriptionStatus.isEmpty || subscriptionStatus == "Free") {
      return false;
    }

    // List of all possible paid subscription statuses
    final paidStatuses = [
      'premium', 'ultimate', 'pro', 'paid', 'subscription',
      'member', 'vip', 'gold', 'silver', 'bronze'
    ];

    final status = subscriptionStatus.toLowerCase();

    // Check if the status contains any of the paid keywords
    return paidStatuses.any((paidStatus) => status.contains(paidStatus));
  }

  @override
  Widget build(BuildContext context) {
    final bool rtlTitle = isArabic(newsData.newsTitle ?? '');
    final bool rtlDesc = isArabic(newsData.newsDescription ?? '');
    final String imageUrl = newsData.newsImage ?? '';
    final bool isPaidArticle = newsData.isPaid ?? false;

    return GetBuilder<AuthController>(builder: (authController) {
      final String subscriptionStatus =
          authController.getSingleUserResponseModel?.payment ?? "Free";

      // Check if user has a paid subscription
      final bool isUserPaid = _isPaidUser(subscriptionStatus);
      print('User subscription status: "$subscriptionStatus", is paid user: $isUserPaid');

      // Final condition - show full content if article is free OR if user is paid
      final bool showFull = !isPaidArticle || isUserPaid;

      return Scaffold(
        appBar: AppBar(
            backgroundColor: Colors.white,
            title: const Text('News')),
        body: Directionality(
          textDirection: rtlDesc ? TextDirection.rtl : TextDirection.ltr,
          child: SafeArea(
            child: SingleChildScrollView(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Title
                  Text(
                    newsData.newsTitle ?? '',
                    style: const TextStyle(
                        fontSize: 20, fontWeight: FontWeight.bold),
                    textAlign: rtlTitle ? TextAlign.right : TextAlign.left,
                  ),
                  const SizedBox(height: 16),

                  // Image
                  if (imageUrl.isNotEmpty)
                    ClipRRect(
                      borderRadius: BorderRadius.circular(8),
                      child: Image.network(
                        imageUrl,
                        fit: BoxFit.cover,
                        width: double.infinity,
                        errorBuilder: (_, __, ___) =>
                        const Icon(Icons.broken_image, size: 60),
                        loadingBuilder: (context, child, progress) {
                          if (progress == null) return child;
                          return const Center(child: CircularProgressIndicator());
                        },
                      ),
                    ),

                  const SizedBox(height: 16),

                  // Content
                  if (showFull)
                    Html(data: newsData.newsDescription ?? '')
                  else
                    _lockedPreview(context, newsData.newsDescription ?? ''),

                  const SizedBox(height: 30),

                  const Text('Related News',
                      style: TextStyle(
                          fontWeight: FontWeight.w700, fontSize: 18)),
                  const SizedBox(height: 10),
                  const Text('Coming soon...'),
                ],
              ),
            ),
          ),
        ),
      );
    });
  }
}