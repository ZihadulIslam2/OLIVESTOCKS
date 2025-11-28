import 'package:flutter/material.dart';

import '../screens/news_screen.dart';
import 'breaking_news_card.dart';


class NewsFilterTabs extends StatefulWidget {
   NewsFilterTabs({super.key});

  @override
  NewsFilterTabsState createState() => NewsFilterTabsState();
}

class NewsFilterTabsState extends State<NewsFilterTabs> {
bool isNewsTab = false;
  String selectedFilter = 'Watchlist';

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 18, left: 16, right: 16, bottom: 10),
      child: Column(
        children: [
          // News / Breaking News toggle
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Expanded(
                child: OutlinedButton(
                  onPressed: () {
                    setState(() {
                      isNewsTab = true;
                      MaterialPageRoute(
                        builder:(context) => const NewsScreen(),
                      );
                      
                    });
                  },
                  style: OutlinedButton.styleFrom(
                    minimumSize: const Size.fromHeight(50),
                    side: BorderSide(color: Colors.green),
                    backgroundColor: isNewsTab ? Colors.green :   Colors.white,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                  child: Text(
                    "News",
                    style: TextStyle(
                      fontSize: 20,
                      color: isNewsTab ? Colors.white : Colors.black,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ),
              ),
              SizedBox(width: 5),
              Expanded(
                child: ElevatedButton(
                  onPressed: () {
                    setState(() {
                      isNewsTab = false;
                      Navigator.push(context, MaterialPageRoute(
                        builder: (context) => BreakingNewsCard(),
                      ));
                      
                    });
                  },
                  style: ElevatedButton.styleFrom(
                    minimumSize: const Size.fromHeight(50),
                    backgroundColor: isNewsTab ? Colors.white :  Colors.green,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                  child: Text(
                    "Breaking News",
                    style: TextStyle(
                      fontSize: 20,
                        color: isNewsTab ? Colors.black : Colors.white, 
                        fontWeight: FontWeight.w500
                      ),
                  ),
                ),
              ),
            ],
          ),
          SizedBox(height: 12),

          // Watchlist and All News pills
          Row(
            children: [
              GestureDetector(
                onTap: () {
                  setState(() {
                    selectedFilter = 'Watchlist';
                  });
                },
                child: Container(
                  padding: EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                  decoration: BoxDecoration(
                    color: selectedFilter == 'Watchlist'
                        ? Colors.green
                        : Colors.grey.shade200,
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: Text(
                    'Watchlist',
                    style: TextStyle(
                      color: selectedFilter == 'Watchlist'
                          ? Colors.white
                          : Colors.black,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ),
              ),
              SizedBox(width: 10),
              GestureDetector(
                onTap: () {
                  setState(() {
                    selectedFilter = 'All News';
                    MaterialPageRoute(
                      builder: (context) => BreakingNewsCard(),
                    );
                  });
                },
                child: Container(
                  padding: EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                  decoration: BoxDecoration(
                    color: selectedFilter == 'All News'
                        ? Colors.green
                        : Colors.grey.shade200,
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: Text(
                    'All News',
                    style: TextStyle(
                      color: selectedFilter == 'All News'
                          ? Colors.white
                          : Colors.black,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}