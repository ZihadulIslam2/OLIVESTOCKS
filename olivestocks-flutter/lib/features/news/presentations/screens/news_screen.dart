import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:olive_stocks_flutter/features/news/controllers/news_controller.dart';
import 'package:olive_stocks_flutter/features/news/domain/get_portfolio_news_response_model.dart';
import '../../../../common/screens/notification_screen.dart';
import '../../../../common/widgets/notification_icon_with_badge.dart';
import '../../../../common/widgets/tow_tabs_bar_custom.dart';
import '../../../markets/presentations/widgets/single_market_news_widget.dart';
import '../../../portfolio/controller/portfolio_controller.dart';
import '../../../portfolio/presentations/widgets/search_bar.dart';
import '../widgets/breaking_news_card.dart';
import '../widgets/featured_news_card.dart';
import '../widgets/tip_card.dart';
import 'news_details_screen.dart';

class NewsScreen extends StatefulWidget {
  const NewsScreen({super.key});

  @override
  State<NewsScreen> createState() => _NewsScreenState();
}

class _NewsScreenState extends State<NewsScreen> with TickerProviderStateMixin {
  late TabController _mainTabController;
  int selectedTabIndex = 0;
  int selectedFilterIndex = 0; // 0 for Watchlist, 1 for All News

  void helpGettingId() async{
    String? id = await Get.find<PortfolioController>().getPresentPortfolio();
    if (Get.find<PortfolioController>().portfolios.isNotEmpty) {
      Get.find<NewsController>().postPortfolioNewsWithConversion(id!);
      Get.find<NewsController>().getAllNewsWithMarket(id);
      Get.find<NewsController>().postPortfolioNewsWithConversion(id);
    }
  }

  @override
  void initState() {
    super.initState();

    _mainTabController = TabController(length: 2, vsync: this);
    helpGettingId();
  }

  @override
  void dispose() {
    _mainTabController.dispose();
    super.dispose();
  }

  Widget _buildFilterButton(String label, int index) {
    final bool isSelected = selectedFilterIndex == index;
    return GestureDetector(
      onTap: () {
        setState(() {
          selectedFilterIndex = index;
        });
      },
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
        decoration: BoxDecoration(
          color: isSelected ? Colors.green : Colors.grey.shade200,
          borderRadius: BorderRadius.circular(20),
        ),
        child: Text(
          label,
          style: TextStyle(
            color: isSelected ? Colors.white : Colors.black,
            fontWeight: FontWeight.w500,
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        title: Padding(
          padding: const EdgeInsets.symmetric(
            horizontal: 16.0,
            vertical: 10,
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                "News",
                style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
              ),
              Row(
                children: [
                  Image.asset('assets/images/file-06.png', height: 20, width: 20),
                  SizedBox(width: 15),
                  GestureDetector(
                      onTap: () => showSearch(
                          context: context,
                          delegate: MyDataSearchDelegate(
                              items: Get.find<PortfolioController>().searchStockResponseModel.results!)),
                      child: Icon(Icons.search)),
                  SizedBox(width: 15),
                  const NotificationIconWithBadge(),
                ],
              ),
            ],
          ),
        ),
      ),
      body: GetBuilder<NewsController>(
        builder: (newsController) {
          return !newsController.isLoadingNew
              ? SafeArea(
            child: Column(
              children: [
                // Search Bar
                // Padding(
                //   padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8),
                //   child: SizedBox(
                //     height: 45,
                //     child: TextField(
                //       decoration: InputDecoration(
                //         hintText: 'Search news',
                //         suffixIcon: const Icon(Icons.search),
                //         border: OutlineInputBorder(
                //           borderRadius: BorderRadius.circular(8.0),
                //         ),
                //       ),
                //     ),
                //   ),
                // ),
                const SizedBox(height: 8),

                // Main Tabs (News/Breaking News)
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16.0),
                  child: TwoTabsBarCustom(
                    firstTabText: "News",
                    secondTabText: "Breaking News",
                    selectedIndex: selectedTabIndex,
                    onTabChanged: (index) {
                      setState(() {
                        selectedTabIndex = index;
                      });
                    },
                  ),
                ),

                // Filter Buttons (Watchlist/All News) - Original style
                Padding(
                  padding: const EdgeInsets.only(
                    top: 18,
                    left: 16,
                    right: 16,
                    bottom: 10,
                  ),
                  child: Row(
                    children: [
                      _buildFilterButton('Watchlist', 0),
                      const SizedBox(width: 10),
                      _buildFilterButton('All News', 1),
                    ],
                  ),
                ),

                Expanded(
                  child: IndexedStack(
                    index: selectedTabIndex,
                    children: [
                      // News Tab Content
                      IndexedStack(
                        index: selectedFilterIndex,
                        children: [
                          // Watchlist Tab Content
                          buildPortfolioStockNewsWidget(newsController, size),
                          // All News Tab Content
                          buildAllNews(newsController),
                        ],
                      ),

                      // Breaking News Tab Content
                      _buildBreakingNews(newsController),
                    ],
                  ),
                ),
              ],
            ),
          )
              : Center(
            child: CircularProgressIndicator(),
          );
        },
      ),
    );
  }



  Widget buildPortfolioStockNewsWidget(NewsController newsController, Size size) {
    if (newsController.isPortfolioNewsLoading) {
      return const Center(child: CircularProgressIndicator());
    }

    final newsList = newsController.portfolioNewsList;

    if (newsList.isEmpty) {
      return const Center(child: Text("No portfolio news available."));
    }

    return GetBuilder<PortfolioController>(builder:(portfolioController){
      return newsController.isPortfolioNewsLoading ? Center(child: CircularProgressIndicator(),) : ListView.builder(
        padding: const EdgeInsets.symmetric(vertical: 8),
        itemCount: newsList.length,
        itemBuilder: (context, index) {
          final newsItem = newsList[index];

          if (index == 0) {
            return Column(
              children: [
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16.0),
                  child: FeaturedNewsCard(newsData: newsItem),
                ),
                const SizedBox(height: 8),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 8.0),
                  child: GestureDetector(
                    onTap: () {
                      Get.to(() => NewsDetailsScreen(newsData: newsItem));
                    },
                    child: SingleMarketNewsWidget(newsData: newsItem),
                  ),
                ),
              ],
            );
          }

          return Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8.0),
            child: GestureDetector(
              onTap: () {
                Get.to(() => NewsDetailsScreen(newsData: newsItem));
              },
              child: SingleMarketNewsWidget(newsData: newsItem),
            ),
          );
        },
      );
    } );
  }



  Widget buildAllNews(NewsController newsController) {
    return ListView.builder(
      padding: const EdgeInsets.symmetric(vertical: 8),
      itemCount: newsController.getAllNewsResponseModel.data!.length + 1,
      itemBuilder: (context, index) {
        if (index == 0) {
          // Featured news at the top
          return Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0),
            child: FeaturedNewsCard(
              newsData: newsController.getAllNewsResponseModel.data![0],
            ),
          );
        } else {
          final newsItem = newsController.getAllNewsResponseModel.data![index - 1];

          bool isArabic(String text) {
            return RegExp(r'[\u0600-\u06FF]').hasMatch(text);
          }

          final bool isTitleArabic = isArabic(newsItem.newsTitle ?? '');

          return Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8.0),
            child: GestureDetector(
              onTap: () {
                Get.to(NewsDetailsScreen(newsData: newsItem));
              },
              child: Container(
                margin: const EdgeInsets.symmetric(vertical: 5),
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
                child: ListTile(
                  leading: ClipRRect(
                    borderRadius: BorderRadius.circular(6),
                    child: Image.network(
                      newsItem.newsImage!,
                      width: 80,
                      height: 80,
                      fit: BoxFit.cover,
                      errorBuilder: (context, error, stackTrace) =>
                      const Icon(Icons.broken_image),
                    ),
                  ),
                  title: Directionality(
                    textDirection:
                    isTitleArabic ? TextDirection.rtl : TextDirection.ltr,
                    child: Text(
                      newsItem.newsTitle ?? '',
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                      style: const TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.bold,
                        fontFamily: 'Poppins',
                      ),
                      textAlign:
                      isTitleArabic ? TextAlign.right : TextAlign.left,
                    ),
                  ),
                  subtitle: Text(
                    newsItem.source ?? '',
                    style: const TextStyle(
                      fontSize: 12,
                      color: Colors.black54,
                      fontFamily: 'Poppins',
                    ),
                  ),
                ),
              ),
            ),
          );
        }
      },
    );
  }


  Widget _buildBreakingNews(NewsController newsController) {
    return ListView.builder(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      itemCount: newsController.getAllNewsResponseModel.data!.length,
      itemBuilder: (context, index) {
        if (index == 0) {
          return BreakingNewsCard();
        } else if (index == 6) {
          return Column(
            children: [
              SizedBox(height: 12),
              TipCard(),
              SizedBox(height: 12),
              BreakingNewsCard(),
            ],
          );
        }
        return GestureDetector(
            onTap: () {
              Get.to(NewsDetailsScreen(
                  newsData: newsController.getAllNewsResponseModel.data![index]));
            },
            child: BreakingNewsCard());
      },
    );
  }
}

extension on GetPortfolioNewsResponseModel {
  operator [](int other) {}
}