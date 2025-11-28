import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:olive_stocks_flutter/common/screens/NabScreen.dart';
import 'package:olive_stocks_flutter/features/auth/controllers/auth_controller.dart';
import '../../../portfolio/controller/portfolio_controller.dart';
import '../../../portfolio/presentations/screens/portfolo_screen.dart';
import '../widgets/portfolio_header_widget.dart';

class CreateNewPortfolio extends StatefulWidget {
  const CreateNewPortfolio({super.key});

  @override
  State<CreateNewPortfolio> createState() => _CreateNewPortfolioState();
}

class _CreateNewPortfolioState extends State<CreateNewPortfolio> {
  final GlobalKey<FormState> _formkey = GlobalKey<FormState>();
  late TextEditingController _emailController;
  late TextEditingController _passwordController;

  final List<String> stockTitles = [
    'AAPL', 'GOOGL', 'MSFT', 'AMZN', 'TSLA',
    'FB', 'NFLX', 'NVDA', 'BRK.B', 'JNJ'
  ];

  final List<String> selectedStocks = [];

  void _addStock(String stock) {
    if (!selectedStocks.contains(stock)) {
      setState(() {
        selectedStocks.add(stock);
      });
    }
  }

  void _removeStock(String stock) {
    setState(() {
      selectedStocks.remove(stock);
    });
  }

  void _resetAll() {
    setState(() {
      selectedStocks.clear();
    });
  }

  @override
  void initState() {
    _emailController = TextEditingController();
    _passwordController = TextEditingController();

    var controller = Get.find<PortfolioController>();
    if (Get.find<AuthController>().isLoggedIn()) {
      controller.getPortfolio();
    }

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    return GetBuilder<AuthController>(
      builder: (authController) {
        return Scaffold(
          body: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.only(left: 16, right: 16),
              child: Container(
                width: size.width,
                height: size.height,
                padding: const EdgeInsets.only(left: 20, right: 20),
                child: Center(
                  child: Form(
                    key: _formkey,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        // SizedBox(height: size.height * .22),
                        PortfolioHeaderCards(),
                        Center(
                          child: Image.asset(
                            'assets/images/olv_logo.png',
                            height: 104,
                            width: 124,
                          ),
                        ),
                        const SizedBox(height: 20),
                        Center(
                          child: Text(
                            'Stay Informed with Analyst Outlooks and Actionable Advice',
                            style: TextStyle(
                              color: Colors.black.withOpacity(.7),
                              fontSize: 20,
                            ),
                            textAlign: TextAlign.center,
                          ),
                        ),
                        const SizedBox(height: 20),
                        TextFormField(
                          controller: _emailController,
                          decoration: InputDecoration(
                            prefixIcon: const Icon(
                              Icons.search_rounded,
                              color: Colors.green,
                            ),
                            hintText: 'Add Stocks, ETFs or Crypto',
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(6),
                              borderSide: const BorderSide(
                                color: Color(0xff737373),
                                width: 1,
                              ),
                            ),
                          ),
                          validator: (String? value) {
                            if (value?.isEmpty ?? true) {
                              return 'Enter valid email';
                            }
                            return null;
                          },
                        ),
                        const SizedBox(height: 16),

                        Center(
                          child: Text(
                            'Popular Stocks',
                            style: TextStyle(
                              color: Colors.black.withOpacity(.7),
                              fontSize: 17,
                            ),
                          ),
                        ),
                        const SizedBox(height: 20),

                        // Popular Stocks Grid
                        Container(
                          height: size.height * .1,
                          width: size.width * .73,
                          child: GridView.builder(
                            physics: const NeverScrollableScrollPhysics(),
                            padding: EdgeInsets.zero,
                            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                              crossAxisCount: 4,
                              crossAxisSpacing: 8.0,
                              mainAxisSpacing: 8.0,
                              childAspectRatio: size.width * 0.16 / 19,
                            ),
                            itemCount: stockTitles.length,
                            itemBuilder: (context, index) {
                              final stock = stockTitles[index];
                              return GestureDetector(
                                onTap: () => _addStock(stock),
                                child: Container(
                                  padding: const EdgeInsets.symmetric(horizontal: 4, vertical: 2),
                                  decoration: BoxDecoration(
                                    border: Border.all(color: Colors.green),
                                    borderRadius: BorderRadius.circular(12),
                                  ),
                                  child: Padding(
                                    padding: const EdgeInsets.only(left: 1,right: 1),
                                    child: Row(
                                      mainAxisAlignment: MainAxisAlignment.center,
                                      children: [
                                        Text(stock, style: const TextStyle(fontSize: 12,fontWeight: FontWeight.bold)),
                                        Spacer(),
                                        const Icon(Icons.add_circle, size: 14, color: Colors.green,weight: 60,),
                                      ],
                                    ),
                                  ),
                                ),
                              );
                            },
                          ),
                        ),

                        Center(
                          child: Text(
                            'Your Stocks Picks',
                            style: TextStyle(
                              color: Colors.black.withOpacity(.7),
                              fontSize: 17,
                            ),
                          ),
                        ),
                        const SizedBox(height: 30),

                        // Your Stock Picks Grid
                        Container(
                          height: size.height * .1,
                          width: size.width * .73,
                          child: GridView.builder(
                            physics: const NeverScrollableScrollPhysics(),
                            padding: EdgeInsets.zero,
                            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                              crossAxisCount: 4,
                              crossAxisSpacing: 8.0,
                              mainAxisSpacing: 8.0,
                              childAspectRatio: size.width * 0.16 / 19,
                            ),
                            itemCount: selectedStocks.length,
                            itemBuilder: (context, index) {
                              final stock = selectedStocks[index];
                              return GestureDetector(
                                onTap: () => _removeStock(stock),
                                child: Container(
                                  padding: const EdgeInsets.symmetric(horizontal: 4, vertical: 2),
                                  decoration: BoxDecoration(

                                    border: Border.all(color: Color(0xff28A745)),
                                    borderRadius: BorderRadius.circular(10),
                                  ),
                                  child: Padding(
                                    padding: const EdgeInsets.only(left: 1,right: 1),
                                    child: Row(
                                      mainAxisAlignment: MainAxisAlignment.center,
                                      children: [
                                        Text(stock, style: const TextStyle(fontSize: 12,fontWeight: FontWeight.bold)),
                                        Spacer(),
                                        const Icon(Icons.remove_circle_outlined, size: 14, color: Colors.red),
                                      ],
                                    ),
                                  ),
                                ),
                              );
                            },
                          ),
                        ),

                        TextButton(
                          onPressed: _resetAll,
                          child: const Text('Reset ALL', style: TextStyle(color: Colors.red, fontSize: 16, fontWeight: FontWeight.bold),),
                        ),

                        const SizedBox(height: 30),
                        Container(
                          height: 35,
                          width: size.width * .4,
                          decoration: BoxDecoration(
                            color: const Color(0xff28A745),
                            borderRadius: BorderRadius.circular(5),
                          ),
                          child: Center(
                            child: Text(
                              'Create',
                              style: TextStyle(
                                color: Colors.white.withOpacity(.9),
                                fontSize: 12,
                              ),
                            ),
                          ),
                        ),
                        const SizedBox(height: 30),
                        Row(
                          children: [
                            TextButton(
                              onPressed: () {
                                Get.back();
                              },
                              child: const Text(
                                'Back',
                                style: TextStyle(
                                  color: Colors.green,
                                  fontSize: 16,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                            const Spacer(),
                            TextButton(
                              onPressed: () {
                                Get.to(NavScreen());
                              },
                              child: const Text(
                                'Next',
                                style: TextStyle(
                                  color: Colors.green,
                                  fontSize: 16,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 20),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}
