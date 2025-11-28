import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:olive_stocks_flutter/features/stock_data_serving/presentations/widgets/rating_star_widget.dart';

import '../widget/genarel_screen_widget.dart';


class ManageNotificationScreen extends StatefulWidget {
  const ManageNotificationScreen({super.key});

  @override
  _ManageNotificationScreenState createState() => _ManageNotificationScreenState();
}

class _ManageNotificationScreenState extends State<ManageNotificationScreen>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;
  bool isSwitched = false;
  int selectedChipIndex = 0;

  List<String> tabs = ["General", "WatchList ", "Experts",];

  @override
  void initState() {
    _tabController = TabController(length: 3, vsync: this);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        title: const Text('Notifications'),

        // leading: const BackButton(),
      ),
      body: SafeArea(
        child: Column(
          children: [
            Container(
              width: size.width * .9,
              height: size.height * .15,
              decoration: BoxDecoration(
                color: Color(0xffEAF6EC),
                borderRadius: BorderRadius.circular(4),
                boxShadow: [
                  BoxShadow(
                    color: Colors.grey.withOpacity(0.2),
                    spreadRadius: 1,
                    blurRadius: 1,
                    offset: const Offset(0, 2),
                  ),
                ],
              ),
              child: Row(
                children: [
                  Icon(
                    Icons.notifications_outlined,
                    color: Colors.black,
                    size: 28,
                  ),
                  SizedBox(width: 10),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        'Smart Notifications',
                        style: TextStyle(
                          color: Colors.black,
                          fontSize: 14,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      SizedBox(height: 12,),
                      Text(
                        textAlign: TextAlign.start,
                        'Get alerts on price movements, upcoming earnings, \nand more for the stocks and experts you follow.',
                        style: TextStyle(
                          color: Colors.black,
                          fontSize: 10,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
        
                    ],
                  ),
                  SizedBox(width: 20,),
                  // Switch
                  Switch(value: isSwitched, onChanged: (value){
                    setState(() {
                      isSwitched = value;
                    });
                  },
                    activeColor: Colors.green,),
                ],
              ),
            ),
            SizedBox(height:  20,),
            Container(
              height: 45,
              child: TabBar(
                controller: _tabController,
                isScrollable: false,
                indicator: const BoxDecoration(
                  color: Colors.transparent,
                ),

                indicatorSize: TabBarIndicatorSize.tab,

                indicatorWeight: 0,

                labelPadding: const EdgeInsets.symmetric(horizontal: 8),
                dividerColor: Colors.transparent,

                tabs: List.generate(
                  tabs.length,
                      (index) => GestureDetector(
                    onTap: () {
                      _tabController.animateTo(index);
                      setState(() {
                        selectedChipIndex = index; // Keep in sync if you're using this variable
                      });
                    },
                    child: Container(
                      height: 60,
                      width: 111,
                      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(8),
                        color: _tabController.index == index
                            ? const Color(0xff28A745) // Selected tab - green
                            : const Color(0xffEAF6EC), // Unselected tab - light green
                        border: Border.all(
                          color: Colors.green, // Green border for both selected/unselected
                          width: 1,
                        ),
                      ),
                      child: Center(
                        child: Text(
                          tabs[index],
                          style: TextStyle(
                            fontSize: 12,
                            color: _tabController.index == index
                                ? Colors.white // Selected tab text - white
                                : Colors.black, // Unselected tab text - black
                          ),
                          textAlign: TextAlign.center,
                        ),
                      ),
                    ),
                  ),
                ),

              ),
            ),

            SizedBox(height: 20,),
            // Tab Views
            Expanded(
              child: TabBarView(
                controller: _tabController,
                children: [GeneralTab(), WatchListTab(), ExpertsTab(),],
              ),
            ),
          ],
        ),
      ),
    );
  }

}
// Economic Tab
class GeneralTab extends StatefulWidget {
  const GeneralTab({super.key});
  @override
  State<GeneralTab> createState() => _GeneralTabState();
}

class _GeneralTabState extends State<GeneralTab> {
  bool isSwitchedNews = false;
  bool isSwitchedArticle = false;
  bool isSwitchedStock = false;

  bool isSwitchedResearchHigh = false;
  bool isSwitchedResearchLow = false;
  bool isSwitchedIncrease = false;
  bool isSwitchedDecrease = false;

  bool isSwitchedEarningReport = false;
  bool isSwitchedDividend = false;

  @override
  Widget build(BuildContext context) {

    return Container(
      child: SingleChildScrollView(
        child: Column(
          children: [
            _buildHeaderRow(context),
          ],
        ),
      ),
    );
  }

  Widget _buildHeaderRow(context) {
    Size size = MediaQuery.of(context).size;
    return Container(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Column(
            children: [
              Row(
                children: [
                  Container(
                    height: size.height * .04,
                    width: size.width,
                    color: Color(0xffBCE4C5),
                    child: Padding(
                      padding: const EdgeInsets.only(left: 12),
                      child:  Align(
                        alignment: Alignment.centerLeft,
                        child: Text(
                          "Breaking News",
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 15,
                            color: Color(0xff000000),
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
              SizedBox(height: 10,),
                Column(
                  children: [
                    Container(
                      padding: const EdgeInsets.only(left: 12),
                      height: size.height * .06,
                      width: size.width,
                      color: Color(0xffEAF6EC),
                      child: Row(
                        children: [
                          Text('Breaking news', style: TextStyle(fontSize: 14, fontWeight: FontWeight.w500,color: Color(0xff595959)),),
                          Spacer(),
                          Switch(value: isSwitchedNews, onChanged: (value){
                            setState(() {
                              isSwitchedNews = value;
                            });
                          },
                            activeColor: Colors.green,),
                        ],
                      ),
                    ),
                    SizedBox(height: 8,),
                    Container(
                      padding: const EdgeInsets.only(left: 12),
                      height: size.height * .06,
                      width: size.width,
                      color: Color(0xffEAF6EC),
                      child: Row(
                        children: [
                          Text('New article published', style: TextStyle(fontSize: 14, fontWeight: FontWeight.w500,color: Color(0xff595959)),),
                          Spacer(),
                          Switch(value: isSwitchedArticle, onChanged: (value){
                            setState(() {
                              isSwitchedArticle = value;
                            });
                          },
                            activeColor: Colors.green,),
                        ],
                      ),
                    ),
                    SizedBox(height: 8,),
                    Container(
                      padding: const EdgeInsets.only(left: 12),
                      height: size.height * .06,
                      width: size.width,
                      color: Color(0xffEAF6EC),
                      child: Row(
                        children: [
                          Text('Stock ideas and analysis', style: TextStyle(fontSize: 14, fontWeight: FontWeight.w500,color: Color(0xff595959)),),
                          Spacer(),
                          Switch(value:isSwitchedStock, onChanged: (value){
                            setState(() {
                              isSwitchedStock = value;
                            });
                          },
                            activeColor: Colors.green,),
                        ],
                      ),
                    ),
                  ],
                ),
              ],),
          SizedBox(height: 10,),
          Column(
            children: [
              Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(
                    height: size.height * .04,
                    width: size.width,
                    color: Color(0xffBCE4C5),
                    child: Padding(
                      padding: const EdgeInsets.only(left: 12),
                      child:  Align(
                        alignment: Alignment.centerLeft,
                        child: Text(
                          "Price Action",
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 15,
                            color: Color(0xff000000),
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
              SizedBox(height: 10,),
              Column(
                      children: [
                        Container(
                          padding: const EdgeInsets.only(left: 12),
                          height: size.height * .06,
                          width: size.width,
                          color: Color(0xffEAF6EC),
                          child: Row(
                            children: [
                              Text('Reaches a new 52-week high', style: TextStyle(fontSize: 14, fontWeight: FontWeight.w500,color: Color(0xff595959)),),
                              Spacer(),
                              Switch(value: isSwitchedResearchHigh, onChanged: (value){
                                setState(() {
                                  isSwitchedResearchHigh = value;
                                });
                              },
                                activeColor: Colors.green,),
                            ],
                          ),
                        ),
                        SizedBox(height: 8,),
                        Container(
                          padding: const EdgeInsets.only(left: 12),
                          height: size.height * .06,
                          width: size.width,
                          color: Color(0xffEAF6EC),
                          child: Row(
                            children: [
                              Text('Reaches a new 52-week low', style: TextStyle(fontSize: 14, fontWeight: FontWeight.w500,color: Color(0xff595959)),),
                              Spacer(),
                              Switch(value: isSwitchedResearchLow, onChanged: (value){
                                setState(() {
                                  isSwitchedResearchLow = value;
                                });
                              },
                                activeColor: Colors.green,),
                            ],
                          ),
                        ),
                        SizedBox(height: 8,),
                        Container(
                          padding: const EdgeInsets.only(left: 12),
                          height: size.height * .06,
                          width: size.width,
                          color: Color(0xffEAF6EC),
                          child: Row(
                            children: [
                              Text('Daily increase more than 7%', style: TextStyle(fontSize: 14, fontWeight: FontWeight.w500,color: Color(0xff595959)),),
                              SizedBox(width: 5,),
                              Container(
                                height: size.height * .03,
                                width: size.width * .15,
                                child: TextFormField(
                                  textAlign: TextAlign.center,
                                  // controller: _emailController,
                                  decoration: InputDecoration(
                                    contentPadding: const EdgeInsets.only(bottom: 2),
                                    border: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(6),
                                      borderSide: const BorderSide(
                                        color: Color(0xff737373),
                                        width: 1,
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                              IconButton(onPressed: (){}, icon: Icon(Icons.mode_edit_outline_outlined, color: Colors.green,),),
                              Spacer(),
                              Switch(value:isSwitchedIncrease, onChanged: (value){
                                setState(() {
                                  isSwitchedIncrease = value;
                                });
                              },
                                activeColor: Colors.green,),
                            ],
                          ),
                        ),
                        SizedBox(height: 8,),
                        Container(
                          padding: const EdgeInsets.only(left: 12),
                          height: size.height * .06,
                          width: size.width,
                          color: Color(0xffEAF6EC),
                          child: Row(
                            children: [
                              Text('Daily decrease more than 7%', style: TextStyle(fontSize: 14, fontWeight: FontWeight.w500,color: Color(0xff595959)),),
                              SizedBox(width: 5,),
                              Container(
                                height: size.height * .03,
                                width: size.width * .15,
                                child: TextFormField(
                                  textAlign: TextAlign.center,
                                  // controller: _emailController,
                                  decoration: InputDecoration(
                                    contentPadding: const EdgeInsets.only(bottom: 2),
                                    border: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(6),
                                      borderSide: const BorderSide(
                                        color: Color(0xff737373),
                                        width: 1,
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                              IconButton(onPressed: (){}, icon: Icon(Icons.mode_edit_outline_outlined, color: Colors.green,),),
                              Spacer(),
                              Spacer(),
                              Switch(value:isSwitchedDecrease, onChanged: (value){
                                setState(() {
                                  isSwitchedDecrease = value;
                                });
                              },
                                activeColor: Colors.green,),
                            ],
                          ),
                        ),
                      ],
                    ),

              SizedBox(height: 10,),
              Column(
                children: [
                  Container(
                    height: size.height * .04,
                    width: size.width,
                    color: Color(0xffBCE4C5),
                    child: Padding(
                      padding: const EdgeInsets.only(left: 12),
                      child: Align(
                        alignment: Alignment.centerLeft,
                        child: Text(
                          "Calendar",
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 15,
                            color: Color(0xff000000),
                          ),
                        ),
                      ),
                    ),
                  ),
                  SizedBox(height: 10,),
                  Container(
                    padding: const EdgeInsets.only(left: 12),
                    height: size.height * .06,
                    width: size.width,
                    color: Color(0xffEAF6EC),
                    child: Row(
                      children: [
                        Text('Company releases an earning report', style: TextStyle(fontSize: 14, fontWeight: FontWeight.w500,color: Color(0xff595959)),),
                        Spacer(),
                        Switch(value: isSwitchedEarningReport, onChanged: (value){
                          setState(() {
                            isSwitchedEarningReport = value;
                          });
                        },
                          activeColor: Colors.green,),
                      ],
                    ),
                  ),
                  SizedBox(height: 8,),
                  Container(
                    padding: const EdgeInsets.only(left: 12),
                    height: size.height * .06,
                    width: size.width,
                    color: Color(0xffEAF6EC),
                    child: Row(
                      children: [
                        Text('Company announces a new dividend', style: TextStyle(fontSize: 14, fontWeight: FontWeight.w500,color: Color(0xff595959)),),
                        Spacer(),
                        Switch(value: isSwitchedDividend, onChanged: (value){
                          setState(() {
                            isSwitchedDividend = value;

                          });
                        },
                          activeColor: Colors.green,),
                      ],
                    ),
                  ),
                ],
              ),
              ],),
        ],
      ),
    );
  }
}

// Earnings Tab
class WatchListTab extends StatefulWidget {
  const WatchListTab({super.key});
  @override
  _WatchListTabState createState() => _WatchListTabState();
}

class _WatchListTabState extends State<WatchListTab> {
  bool isSwitchedAAPL = false;
  bool isSwitchedDELL = false;
  bool isSwitchedNVDA = false;
  bool isSwitchedAMZN = false;
  bool isSwitchedGOOGLE = false;


  @override
  Widget build(BuildContext context) {

    return Container(
      child: SingleChildScrollView(
        child: Column(
          children: [
            _buildHeaderRow(context),
          ],
        ),
      ),
    );
  }

  Widget _buildHeaderRow(context) {
    Size size = MediaQuery.of(context).size;
    return Container(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Column(
            children: [
              Row(
                children: [
                  Container(
                    height: size.height * .04,
                    width: size.width,
                    color: Color(0xffBCE4C5),
                    child: Padding(
                      padding: const EdgeInsets.only(left: 12),
                      child:  Align(
                        alignment: Alignment.centerLeft,
                        child: Text(
                          "Watchlist’s Stocks",
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 15,
                            color: Color(0xff000000),
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
              SizedBox(height: 10,),
              Column(
                children: [
                  Container(
                    padding: const EdgeInsets.only(left: 12),
                    height: size.height * .06,
                    width: size.width,
                    color: Color(0xffEAF6EC),
                    child: Row(
                      children: [
                        Text('AAPL', style: TextStyle(fontSize: 14, fontWeight: FontWeight.w500,color: Color(0xff595959)),),
                        Text('(Apple)', style: TextStyle(fontSize: 14, fontWeight: FontWeight.w500,color: Color(0xff999999)),),
                        Spacer(),
                        Switch(value: isSwitchedAAPL, onChanged: (value){
                          setState(() {
                            isSwitchedAAPL = value;
                          });
                        },
                          activeColor: Colors.green,),
                      ],
                    ),
                  ),
                  SizedBox(height: 8,),
                  Container(
                    padding: const EdgeInsets.only(left: 12),
                    height: size.height * .06,
                    width: size.width,
                    color: Color(0xffEAF6EC),
                    child: Row(
                      children: [
                        Text('DELL', style: TextStyle(fontSize: 14, fontWeight: FontWeight.w500,color: Color(0xff595959)),),
                        Text('(Dell Technologies)', style: TextStyle(fontSize: 14, fontWeight: FontWeight.w500,color: Color(0xff999999)),),
                        Spacer(),
                        Switch(value: isSwitchedDELL, onChanged: (value){
                          setState(() {
                            isSwitchedDELL = value;
                          });
                        },
                          activeColor: Colors.green,),
                      ],
                    ),
                  ),
                  SizedBox(height: 8,),
                  Container(
                    padding: const EdgeInsets.only(left: 12),
                    height: size.height * .06,
                    width: size.width,
                    color: Color(0xffEAF6EC),
                    child: Row(
                      children: [
                        Text('NVDA', style: TextStyle(fontSize: 14, fontWeight: FontWeight.w500,color: Color(0xff595959)),),
                        Text('(Nvidia)', style: TextStyle(fontSize: 14, fontWeight: FontWeight.w500,color: Color(0xff999999)),),
                        Spacer(),
                        Switch(value:isSwitchedNVDA, onChanged: (value){
                          setState(() {
                            isSwitchedNVDA = value;
                          });
                        },
                          activeColor: Colors.green,),
                      ],
                    ),
                  ),
                  SizedBox(height: 8,),
                  Container(
                    padding: const EdgeInsets.only(left: 12),
                    height: size.height * .06,
                    width: size.width,
                    color: Color(0xffEAF6EC),
                    child: Row(
                      children: [
                        Text('AMZN', style: TextStyle(fontSize: 14, fontWeight: FontWeight.w500,color: Color(0xff595959)),),
                        Text('(Amazon)', style: TextStyle(fontSize: 14, fontWeight: FontWeight.w500,color: Color(0xff999999)),),
                        Spacer(),
                        Switch(value:isSwitchedAMZN, onChanged: (value){
                          setState(() {
                            isSwitchedAMZN = value;
                          });
                        },
                          activeColor: Colors.green,),
                      ],
                    ),
                  ),
                  SizedBox(height: 8,),
                  Container(
                    padding: const EdgeInsets.only(left: 12),
                    height: size.height * .06,
                    width: size.width,
                    color: Color(0xffEAF6EC),
                    child: Row(
                      children: [
                        Text('GOOGLE', style: TextStyle(fontSize: 14, fontWeight: FontWeight.w500,color: Color(0xff595959)),),
                        Text('(Alphabet Class A)', style: TextStyle(fontSize: 14, fontWeight: FontWeight.w500,color: Color(0xff999999)),),
                        Spacer(),
                        Switch(value:isSwitchedGOOGLE, onChanged: (value){
                          setState(() {
                            isSwitchedGOOGLE = value;
                          });
                        },
                          activeColor: Colors.green,),
                      ],
                    ),
                  ),
                ],
              ),
            ],),
        ],
      ),
    );
  }
}
// Dividend Tab
class ExpertsTab extends StatefulWidget {
  const ExpertsTab({super.key});
  @override
  State<ExpertsTab> createState() => _ExpertsTabState();
}


class _ExpertsTabState extends State<ExpertsTab> {
  bool isSwitchedExperts = false;

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        children: [
          _buildHeaderRow(context),
        ],
      ),
    );
  }

  Widget _buildHeaderRow(context) {
    Size size = MediaQuery.of(context).size;
    return Column(
      children: [
        Container(
          height: size.height * .04,
          width: size.width,
          color: Color(0xffBCE4C5),
          child: Padding(
            padding: const EdgeInsets.only(left: 12),
            child:  Align(
              alignment: Alignment.centerLeft,
              child: Text(
                "Followed Experts",
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 15,
                  color: Color(0xff000000),
                ),
              ),
            ),
          ),
        ),
        SizedBox(height: 10,),
        Container(
          padding: const EdgeInsets.only(left: 12),
          height: size.height * .09,
          width: size.width,
          color: Color(0xffEAF6EC),
          child: Row(
            children: [
             CircleAvatar(
               radius: 25,
               backgroundImage: NetworkImage('https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcQPfO37MK81JIyR1ptwqr_vYO3w4VR-iC2wqQ&s'),
             ),
              SizedBox(width: 10,),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text('Hello, Alex Mitchell', style: TextStyle(fontSize: 16, fontWeight: FontWeight.w500,color: Color(0xff000000)),),
                  Text('alexmitcheel@gmail.com', style: TextStyle(fontSize: 12, fontWeight: FontWeight.w400,color: Color(0xff595959)),),
                StarRatingWidget(rating: 4,),
                ],
              ),
              Spacer(),
              Switch(value: isSwitchedExperts, onChanged: (value){
                setState(() {
                  isSwitchedExperts = value;
                });
              },
                activeColor: Colors.green,),
            ],
          ),
        ),
      ],
    );
  }
}
