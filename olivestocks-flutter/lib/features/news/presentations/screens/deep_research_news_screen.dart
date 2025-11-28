import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../auth/controllers/auth_controller.dart';
import '../../controllers/news_controller.dart';
import 'deep_research_details_screen.dart';

class DeepResearchNewsScreen extends StatefulWidget {
  final String symbol;

  const DeepResearchNewsScreen({super.key, required this.symbol});

  @override
  State<DeepResearchNewsScreen> createState() => _DeepResearchNewsScreenState();
}

class _DeepResearchNewsScreenState extends State<DeepResearchNewsScreen> {
  final NewsController _controller = Get.find<NewsController>();

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _fetchNews();
    });
  }

  bool isArabic(String text) {
    return RegExp(r'[\u0600-\u06FF]').hasMatch(text);
  }

  Future<void> _fetchNews() async {
    try {
      await _controller.getDeepResearch(widget.symbol);
    } catch (e) {
      Get.snackbar('Error', 'Failed to load news: ${e.toString()}');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        title: Text('Deep Research - ${widget.symbol}'),
        elevation: 0,
        actions: [
          IconButton(
            icon: const Icon(Icons.refresh),
            onPressed: _fetchNews,
          ),
        ],
      ),
      body: GetBuilder<NewsController>(
        builder: (controller) {
          if (controller.isDeepResearchNewsLoading) {
            return const Center(child: CircularProgressIndicator());
          }

          // Filter news by the current symbol
          final filteredNews = controller.deepResearchNewsResponseModel.data
              ?.where((news) => news.symbol == widget.symbol)
              .toList();

          if (filteredNews == null || filteredNews.isEmpty) {
            return Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Text(
                    'No deep research news available',
                    style: TextStyle(fontSize: 16),
                  ),
                  const SizedBox(height: 16),
                  ElevatedButton(
                    onPressed: _fetchNews,
                    child: const Text('Retry'),
                  ),
                ],
              ),
            );
          }

          return RefreshIndicator(
            onRefresh: _fetchNews,
            child: ListView.separated(
              padding: const EdgeInsets.all(16),
              itemCount: filteredNews.length,
              separatorBuilder: (context, index) => const SizedBox(height: 16),
              itemBuilder: (context, index) {
                final newsItem = filteredNews[index];
                final isArabicText = isArabic(newsItem.newsTitle ?? '');

                return Card(
                  color: Colors.white,
                  elevation: 2,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: InkWell(
                    borderRadius: BorderRadius.circular(12),
                    onTap: () => Get.to(() => DeepResearchNewsDetailsScreen(
                      symbol: widget.symbol,
                      newsData: newsItem,
                    )),
                    child: Padding(
                      padding: const EdgeInsets.all(16),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          if (newsItem.newsImage != null && newsItem.newsImage!.isNotEmpty)
                            ClipRRect(
                              borderRadius: BorderRadius.circular(8),
                              child: Image.network(
                                newsItem.newsImage!,
                                height: 180,
                                width: double.infinity,
                                fit: BoxFit.cover,
                                errorBuilder: (context, error, stackTrace) =>
                                    Container(
                                      height: 180,
                                      color: Colors.grey[200],
                                      child: const Center(
                                        child: Icon(Icons.broken_image, size: 40),
                                      ),
                                    ),
                              ),
                            ),
                          const SizedBox(height: 12),
                          Directionality(
                            textDirection: isArabicText ? TextDirection.rtl : TextDirection.ltr,
                            child: Text(
                              newsItem.newsTitle ?? 'No title',
                              style: const TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.bold,
                              ),
                              maxLines: 2,
                              overflow: TextOverflow.ellipsis,
                            ),
                          ),
                          const SizedBox(height: 8),
                          Text(
                            newsItem.symbol ?? 'N/A',
                            style: TextStyle(
                              color: Colors.blue[700],
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                );
              },
            ),
          );
        },
      ),
    );
  }
}