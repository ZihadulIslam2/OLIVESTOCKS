
import 'package:get/get.dart';
import 'package:olive_stocks_flutter/features/news/repositories/news_repository.dart';
import 'package:olive_stocks_flutter/features/news/repositories/news_repository_interface.dart';
import 'package:olive_stocks_flutter/features/news/services/news_service_interface.dart';
import 'package:olive_stocks_flutter/features/portfolio/repositories/portfolio_repository_interface.dart';
import 'package:olive_stocks_flutter/features/portfolio/services/portfolio_service_interface.dart';
import 'package:olive_stocks_flutter/payment/services/stripe_service.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../features/auth/controllers/auth_controller.dart';
import '../features/auth/repositories/auth_repository.dart';
import '../features/auth/repositories/auth_repository_interface.dart';
import '../features/auth/sevices/auth_service.dart';
import '../features/auth/sevices/auth_service_interface.dart';
import '../features/explore_plan/controllers/subcrption_controller.dart';
import '../features/explore_plan/repositories/subcription_repository.dart';
import '../features/explore_plan/repositories/subcription_repository_interface.dart';
import '../features/explore_plan/services/service_repository.dart';
import '../features/explore_plan/services/service_repository_interface.dart';
import '../features/news/controllers/news_controller.dart';
import '../features/news/services/news_service.dart';
import '../features/portfolio/controller/portfolio_controller.dart';
import '../features/portfolio/repositories/portfolio_repository.dart';
import '../features/portfolio/services/portfolio_service.dart';
import 'remote/data/api_client.dart';

Future<void> initDI() async{

  SharedPreferences prefs = await SharedPreferences.getInstance();

  ApiClient apiClient = ApiClient(appBaseUrl: 'https://backend-rafi-hzi9.onrender.com/api/v1', sharedPreferences: prefs);


  //////////// Auth Service, Repository and Controller Start ////////////////////////////////

  Get.lazyPut(() => ApiClient(appBaseUrl: 'appBaseUrl', sharedPreferences: prefs));

  Get.lazyPut(()=> AuthRepository(apiClient: Get.find(), sharedPreferences: prefs));
  AuthRepositoryInterface authRepositoryInterface = AuthRepository(apiClient: Get.find(), sharedPreferences: prefs);
  Get.lazyPut(()=> authRepositoryInterface);
  AuthServiceInterface authServiceInterface = AuthService(Get.find());

  Get.lazyPut(() => authServiceInterface);
  Get.lazyPut(()=> StripeService());
  Get.lazyPut(()=> AuthController(authServiceInterface: Get.find(), service: Get.find()));
  Get.lazyPut(()=> AuthService(Get.find()));


  //////////// Auth Service, Repository and Controller end ////////////////////////////////



  //////////// News Service, Repository and Controller start ////////////////////////////////

  Get.lazyPut(() => NewsRepository(Get.find(), prefs));

  NewsRepositoryInterface newsRepositoryInterface = NewsRepository(Get.find(), prefs);
  Get.lazyPut(()=> newsRepositoryInterface);
  
  NewsServiceInterface newsServiceInterface = NewsService(Get.find());
  Get.lazyPut(() => newsServiceInterface);


  Get.lazyPut(() => NewsService(Get.find()));
  Get.lazyPut(() => NewsController(Get.find()));

  //////////// News Service, Repository and Controller end ////////////////////////////////


  //////////// Portfolio Service, Repository and Controller start ////////////////////////////////

  Get.lazyPut(() => PortfolioRepository(Get.find(), prefs));

  PortfolioRepositoryInterface portfolioRepositoryInterface = PortfolioRepository(Get.find(), prefs);

  Get.lazyPut(()=> portfolioRepositoryInterface);
  PortfolioServiceInterface portfolioServiceInterface = PortfolioService(Get.find());
  Get.lazyPut(() => portfolioServiceInterface);


  Get.lazyPut(() => PortfolioService(Get.find()));

  Get.lazyPut(() => PortfolioController(Get.find()));

  //////////// Portfolio Service, Repository and Controller end ////////////////////////////////


  //////////// Subscription Service, Repository and Controller START ////////////////////////////////

  Get.lazyPut(() => SubscriptionRepository(Get.find(), prefs));

  SubscriptionRepositoryInterface subscriptionRepositoryInterface = SubscriptionRepository(Get.find(), prefs);

  Get.lazyPut(()=> subscriptionRepositoryInterface);
  SubscriptionServiceInterface subscriptionServiceInterface = SubscriptionService(Get.find());
  Get.lazyPut(() => subscriptionServiceInterface);


  Get.lazyPut(() => SubscriptionService(Get.find()));

  Get.lazyPut(() => SubscriptionController(Get.find()));


  //////////// Subscription Service, Repository and Controller START ////////////////////////////////

}

