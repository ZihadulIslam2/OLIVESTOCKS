class Urls {
  static const String baseUrl = 'https://backend-rafi-hzi9.onrender.com/api/v1';


  ///////////////////// Authentication URLs Start /////////////////////

  static const String register = '/auth/register';
  static const String login = '/auth/login';
  static const String logOut = '/auth/log-out';
  static const String refreshAccessToken = '/api/v1/auth/refresh-access-token';
  static const String forgetPassword = '/auth/forgot-password';
  static const String resetPassword = '/auth/reset-password';
  static const String changePassword = '/auth/change-password';

  static const String emailVerification = '/auth/verify-email';

  static const String postUpdateUser = '/user/update-user';

  static const String getSingleUser = '/user/get-user/';

  static const String deletePortfolio= '/protfolio/';

  static const String patchUpdatePortfolio= '/protfolio/';

  static const String getWithPaymentSingleUser= '/user/get-user/';

  static const String patchRenamePortfolio= '/protfolio/';




  ///////////////////// Authentication URLs End /////////////////////


  //////////////////// News URLs Start //////////////////////////////

  static const String getAllNewsList = '/admin/news/all-news/';
  static const String getASingleNews = '/admin/news/';
  static const String getMarketNews = '/admin/news/market-news';
  static const String getPortfolioNews = '/admin/news/get-protfolio-news';
  static const String getDeepResearchNews = '/admin/news/deep-research';

  //////////////////// News URLs End //////////////////////////////

  static const String verifyCode = '/api/v1/auth/verify-code';
  //static const String logOut = '/api/v1/auth/logout';

  //Stocks
  static const String getAllGainerAndLooserUrl = '/stocks/daily-gainner-loser';
  static const String getAllMostTradedStocks = '/stocks/stock-summary';
  static const String getAllAnalystsTopStocks = '/stocks/stock-summary';
  static const String getAllDailyAnalystRatings = '/stocks/quality-stocks';

  static const String getAllUpComingEvents = '/portfolio/upcoming-event?portfolioId=';

  static const String getAllOverallBalance = '/portfolio/overview/';

  static const String getAllPerformances = '/get-performance/';
  static const String getAllOliveStocksPortfolio = '/stocks/olive-stock-protfolio';
  static const String getAllOliveStocksUnderRadar = '/stocks/olive-stock-protfolio';
  static const String getAllTrendingStocks = '/stocks/stock-summary';
  static const String postAssetAllocation = '/portfolio/allocation?portfolioId=';
  static const String getAllStocksWarning= '/portfolio/allocation?portfolioId=';
  static const String getAllOliveStocksPortfolioNew = '/stocks/olive-stock-protfolio';
  static const String getPortfolioById = '/portfolio/get/';

  static const String postAddStockPortfolio = '/protfolio/add-stock';

  static const String postDeleteStockPortfolio = '/protfolio/delete-stock';
  static const String postDeleteStockWatchlist = '/protfolio/watchlist/remove';

  static const String getStockOverview = '/stocks/get-stock-overview?symbol=';
  static const String getPriceChart = '/stocks/stocks-overview?symbol=';
  static const String getTargetChart = '/stocks/stock/target-price?symbol=';
  static const String getRevenueChart = '/stocks/stock/earnings-surprise?symbol=';
  static const String getEPSChart = '/stocks/stock/eps?symbol=';
  static const String getCashFlowChart = '/stocks/stock/cash-flow?symbol=';
  static const String getEarningsChart = '/stocks/stock/earnings-surprise?symbol=';

  static const String searchStockData = '/stocks/search?q=';

  static const String getWatchlist = '/protfolio/watchlist';


  static const String createNewPortfolio = '/protfolio/create';

  static const String getPortfolio = '/portfolio/get';

  static const String postSupport = '/user/support';

  static const String postAddToWatchList = '/protfolio/watchlist/add';


  static const String getNotification = '/user/notification';


  static const String getAllSubscription = '/subscription';

  static const String postConfirmPayment = '/confirm-payment';

  static const String postCreatePayment = '/create-payment';








  //................................ If need to get filtered commanders
  // static const String getFilteredCommanders =
  //     '/api/v1/commander?page=1&limit=8&service=Army&unit=101st Division';

  static const String getSpecificCommanders = '/api/v1/commander/';

  //Services
  static const String getAllReviews = '/api/v1/review?page=1&limit=1';

  static const String createReview = '/api/v1/review';

  static const String getTopFiveReviews = '/api/v1/review/top-five';

  static const String getAllServices = '/api/v1/service?page=1&limit=10';

  static const String getAllBlogs =
      '/api/v1/blog?page=1&limit=100&slug=first-blogsdaf';

  static const String getABlogs = '/api/v1/blog/';

  static const String getAllCategoryBlogs = '/api/v1/blog/blog-category';

  static const String getAllUnits = '/api/v1/unit?page=1&limit=10';

  static const String getAllContact = '/api/v1/contact/';
  static const String getAllFeaturedReview = '/api/v1/review/featured-top-five';

  static const String loadSinglePortfolioStocks = '/portfolio/get/';

  static const String commentUnderBlog = '/api/v1/blog/comment';

//static const String getCommanderById = '/api/v1/commanders/';


}
