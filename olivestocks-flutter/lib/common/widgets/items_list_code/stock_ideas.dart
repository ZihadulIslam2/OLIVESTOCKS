// import 'package:flutter/material.dart';
//
// import '../menu_item_data.dart';
// class SideMenu extends StatelessWidget {
//   const SideMenu({super.key});
//
//   @override
//   Widget build(BuildContext context) {
//     return Drawer(
//       child: SafeArea(
//         child: SingleChildScrollView(
//           padding: const EdgeInsets.all(16),
//           child: Column(
//             crossAxisAlignment: CrossAxisAlignment.start,
//             children: const [
//               ProfileHeader(),
//               SizedBox(height: 16),
//               PromoCard(),
//               SizedBox(height: 24),
//               MenuSection(
//                 title: 'Stock Ideas',
//                 items: [
//                   MenuItemData(title: 'Analysts Top Stocks', icon: Icons.bar_chart, route: '/analysts'),
//                   MenuItemData(title: 'Top Smart Score Stocks', icon: Icons.star, route: '/smart-score'),
//                   MenuItemData(title: 'Daily Insider Trading', icon: Icons.swap_horiz, route: '/insider-trading'),
//                   MenuItemData(title: 'Daily Analyst Ratings', icon: Icons.rate_review, route: '/analyst-ratings'),
//                   MenuItemData(title: 'Trending Stocks', icon: Icons.trending_up, route: '/trending'),
//                   MenuItemData(title: 'Best Dividend Stocks', icon: Icons.attach_money, route: '/dividends'),
//                   MenuItemData(title: 'Insiders\' Hot Stocks', icon: Icons.whatshot, route: '/hot-stocks'),
//                   MenuItemData(title: 'Stock Comparison', icon: Icons.compare, route: '/comparison'),
//                   MenuItemData(title: 'Smart Dividends', icon: Icons.money, route: '/smart-dividends'),
//                   MenuItemData(title: 'Smart Investor', icon: Icons.account_balance_wallet, route: '/smart-investor'),
//                 ],
//               ),
//               SizedBox(height: 16),
//               MenuSection(
//                 title: 'Screener',
//                 items: [
//                   MenuItemData(title: 'Stock Screener', icon: Icons.filter_alt, route: '/stock-screener'),
//                   MenuItemData(title: 'ETF Screener', icon: Icons.stacked_line_chart, route: '/etf-screener'),
//                 ],
//               ),
//               SizedBox(height: 16),
//               MenuSection(
//                 title: 'Shortcuts',
//                 items: [
//                   MenuItemData(title: 'Discover Portfolios', icon: Icons.search, route: '/discover'),
//                   MenuItemData(title: 'IPOs', icon: Icons.rocket_launch, route: '/ipos'),
//                   MenuItemData(title: 'My Experts', icon: Icons.person, route: '/experts'),
//                   MenuItemData(title: 'Reading List', icon: Icons.menu_book, route: '/reading'),
//                   MenuItemData(title: 'Help', icon: Icons.help_outline, route: '/help'),
//                   MenuItemData(title: 'Contact Us', icon: Icons.contact_mail, route: '/contact'),
//                   MenuItemData(title: 'Setting', icon: Icons.settings, route: '/settings'),
//                 ],
//               ),
//             ],
//           ),
//         ),
//       ),
//     );
//   }
// }
//
//
//
//
//
// // import 'package:flutter/material.dart';
// // import '../models/menu_item_data.dart';
// // import 'menu_section.dart';
// // import 'profile_header.dart';
// // import 'promo_card.dart';
//
// // // 👇 New imports
// // import '../data/stock_ideas_items.dart';
// // import '../data/screener_items.dart';
// // import '../data/shortcuts_items.dart';
//
// // class SideMenu extends StatelessWidget {
// //   const SideMenu({super.key});
//
// //   @override
// //   Widget build(BuildContext context) {
// //     return Drawer(
// //       backgroundColor: Colors.white,
// //       width: MediaQuery.of(context).size.width * 0.7,
// //       child: SafeArea(
// //         child: SingleChildScrollView(
// //           padding: const EdgeInsets.all(16),
// //           child: Column(
// //             crossAxisAlignment: CrossAxisAlignment.start,
// //             children: [
// //               const ProfileHeader(),
// //               const SizedBox(height: 16),
// //               const PromoCard(),
// //               const SizedBox(height: 24),
// //               MenuSection(title: 'Stock Ideas', items: stockIdeasItems),
// //               const SizedBox(height: 24),
// //               MenuSection(title: 'Screener', items: screenerItems),
// //               const SizedBox(height: 24),
// //               MenuSection(title: 'Shortcuts', items: shortcutsItems),
// //               const SizedBox(height: 24),
// //               const Divider(),
// //               const SizedBox(height: 12),
// //               Text.rich(
// //                 TextSpan(
// //                   children: [
// //                     const TextSpan(
// //                       text:
// //                           'Ideas published on the Green Stocks platform are only for information purposes. Please consult with your advisor before acting on any ideas. You can reach us at ',
// //                       style: TextStyle(fontSize: 12, color: Colors.black54),
// //                     ),
// //                     TextSpan(
// //                       text: 'support@greenstocks.com',
// //                       style: TextStyle(
// //                         fontSize: 12,
// //                         color: Colors.green,
// //                         decoration: TextDecoration.underline,
// //                       ),
// //                     ),
// //                     const TextSpan(
// //                       text: ' or by phone at ',
// //                       style: TextStyle(fontSize: 12, color: Colors.black54),
// //                     ),
// //                     TextSpan(
// //                       text: '+1 877 658 8865',
// //                       style: TextStyle(
// //                         fontSize: 12,
// //                         color: Colors.green,
// //                         decoration: TextDecoration.underline,
// //                       ),
// //                     ),
// //                     const TextSpan(
// //                       text: '.',
// //                       style: TextStyle(fontSize: 12, color: Colors.black54),
// //                     ),
// //                   ],
// //                 ),
// //               ),
// //               const SizedBox(height: 24),
// //             ],
// //           ),
// //         ),
// //       ),
// //     );
// //   }
// // }