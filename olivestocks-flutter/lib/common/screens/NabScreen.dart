import 'package:flutter/material.dart';
import 'package:olive_stocks_flutter/common/screens/side_menu.dart';
import '../../features/markets/presentations/screens/market_screen.dart';
import '../../features/news/presentations/screens/news_screen.dart';
import '../../features/portfolio/presentations/screens/portfolo_screen.dart';

class NavScreen extends StatefulWidget {

  const NavScreen({super.key});

  @override
  State<NavScreen> createState() => _NavScreenState();
}

class _NavScreenState extends State<NavScreen> {

  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  int _page = 0;

  List<Widget> widgets = [];

  @override
  void initState() {
    widgets = [
      PortfolioScreen(onItemTapped: onItemTapped,),
      NewsScreen(),
      MarketScreen(),
      SizedBox(),
    ];
    super.initState();
  }

  void onItemTapped() {
    setState(() {
      _scaffoldKey.currentState?.openDrawer();
    });
  }

  void _onItemTapped(int index) {
    if(index == 3) {
      onItemTapped();
       // menuBottomSheet(context);
      return;
    }
    setState(() {
      _page = index;
    });
  }

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      key: _scaffoldKey,
      drawer: SideMenu(),
      body: widgets[_page],

      bottomNavigationBar: BottomNavigationBar(

        backgroundColor: Color(0xffE9F0FF),

        type: BottomNavigationBarType.fixed,

        items: <BottomNavigationBarItem>[

          BottomNavigationBarItem(icon: _page == 0 ? Image.asset('assets/images/home_icon_green.png') : Image.asset('assets/images/home_icon.png'), label: 'Portfolio'),
          BottomNavigationBarItem(icon: _page == 1 ? Image.asset('assets/images/news_icon_green.png') : Image.asset('assets/images/news_icon.png'), label: 'News'),
          BottomNavigationBarItem(icon: _page == 2 ? Image.asset('assets/images/market_icon_green.png') : Image.asset('assets/images/market_icon.png'), label: 'Markets'),
          BottomNavigationBarItem(icon: _page == 3 ? Icon(Icons.menu, color: Colors.green,) : Icon(Icons.menu, color: Colors.black,), label: 'Menu'),

        ],
        currentIndex: _page,
        selectedItemColor: Colors.green,
        showUnselectedLabels: true,
        unselectedItemColor: Colors.black,
        unselectedLabelStyle: TextStyle(color: Colors.black),
        onTap: _onItemTapped,
      ),
    );
  }

}
