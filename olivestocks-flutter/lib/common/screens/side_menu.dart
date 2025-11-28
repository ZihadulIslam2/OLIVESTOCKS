import 'package:flutter/material.dart';
import '../../features/experts/presentations/screens/olive_stock_screen.dart';
import '../../features/experts/presentations/screens/my_export_screen.dart';
import '../../features/experts/presentations/screens/the_olive_stocks_under_radar_screen.dart';
import '../../features/settings/presentation/screens/settings_screen.dart';
import '../../features/stock_data_serving/presentations/screens/daily_insider_trading_screen_2.dart';
import '../../features/stock_data_serving/presentations/screens/dividend_screen.dart';
import '../../features/stock_data_serving/presentations/screens/eft_screener_screen.dart';
import '../../features/stock_data_serving/presentations/screens/stock_screener_screen.dart';
import '../../features/stock_data_serving/presentations/screens/trending_stocks_screen.dart';
import '../widgets/menu_item_data.dart';
import '../widgets/menu_section.dart';
import '../widgets/profile_header.dart';
import '../widgets/promo_card.dart';
import 'contact_us_screen.dart';

class SideMenu extends StatefulWidget {

  const SideMenu({super.key});

  @override
  State<SideMenu> createState() => _SideMenuState();
}

class _SideMenuState extends State<SideMenu> {
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return  Drawer(
      child: mounted ? SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(16),
          child: Container(
            width: size.width * .7,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [

                const ProfileHeader(),
                const PromoCard(),
                const SizedBox(height: 24),
                MenuSection(
                  title: 'Stock Ideas',
                  items: [
                    MenuItemData(
                      title: 'Olive stocks portfolio',
                      iconImage: 'assets/logos/bar-chart-08.png',
                      route: OliveStocksPortfolioScreen(),
                    ),
                    MenuItemData(
                      title: 'Quality Stocks',
                      iconImage: 'assets/logos/stop-circle.png',
                      route: QualityStocksScreen(),
                    ),
                     MenuItemData(
                      title: 'Daily Insider Trading',
                      iconImage:'assets/logos/bar-chart-04.png',
                      isUpComing: true,
                      route: DailyInsiderTradingScreen2(),
                    ),
                     MenuItemData(
                      title: 'Trending Stocks',
                      iconImage: 'assets/logos/Icon (1).png',
                      /// [Todo] 
                      route:TrendingStocksScreen(),
                    ),

                  ],
                ),
                const SizedBox(height: 16),
                 MenuSection(
                  title: 'Screener',
                  items: [
                    MenuItemData(
                      title: 'Stock Screener',
                      iconImage: 'assets/logos/bar-line-chart.png',
                      route: StockScreenerScreen(),
                    ),
                    MenuItemData(
                      title: 'ETF Screener',
                      iconImage: 'assets/logos/Icon (2).png',
                      route: ETFScreen(),
                    ),
                    MenuItemData(
                      title: 'Dividend Screener',
                      iconImage: 'assets/logos/trend-up-01.png',
                      route:DividendScreener(),
                    ),
                  ],
                ),
                const SizedBox(height: 16),
                 MenuSection(
                  title: 'Shortcuts',
                  items: [
                    MenuItemData(
                      title: 'My Experts',
                      iconImage: 'assets/logos/users-plus.png',
                       route: MyExpertsScreen(),
                      isUpComing: true
                    ),
                    MenuItemData(
                      title: 'Contact Us',
                      iconImage: 'assets/logos/pencil-line.png',
                      route: ContactUsScreen(),
                    ),
                    MenuItemData(
                      isUpComing: false,
                      title: 'Settings',
                      iconImage: 'assets/logos/settings-01.png',
                      route: SettingsScreen(),
                    ),

                  ],
                ),
                const SizedBox(height: 24),
                 const Divider(),
                 const SizedBox(height: 12),
                const Text.rich(
                  TextSpan(
                    children: [
                       TextSpan(
                        text:
                            'News published on the Olives Stocks Lorem ipsum is a dummy or placeholder text commonly used in graphic design, publishing, and web development by email to support@OlivesStocks.com, or by phone at +1 075682958455  ',
                        style: TextStyle(fontSize: 12, color: Colors.black54),
                      ),
                      TextSpan(
                        text: 'support@greenstocks.com',
                        style: TextStyle(
                          fontSize: 12,
                          color: Colors.green,
                          decoration: TextDecoration.underline,
                        ),
                      ),
                      TextSpan(
                        text: ' or by phone at ',
                        style: TextStyle(fontSize: 12, color: Colors.black54),
                      ),
                      TextSpan(
                        text: '+1 877 658 8865',
                        style: TextStyle(
                          fontSize: 12,
                          color: Colors.green,
                          decoration: TextDecoration.underline,
                        ),
                      ),
                      TextSpan(
                        text: '.',
                        style: TextStyle(fontSize: 12, color: Colors.black54),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 24),


              ],
            ),
          ),
        ),
      ) : Center(
        child: CircularProgressIndicator(),
      ),
    );
  }
}
