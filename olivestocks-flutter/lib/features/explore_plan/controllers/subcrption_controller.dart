import 'package:get/get.dart';
import 'package:olive_stocks_flutter/features/explore_plan/domain/get_all_subcription_response_model.dart';

import '../../../helpers/remote/data/api_checker.dart';
import '../services/service_repository_interface.dart';

class SubscriptionController extends GetxController implements GetxService {

  final SubscriptionServiceInterface subscriptionServiceInterface;
  SubscriptionController(this.subscriptionServiceInterface);

  bool isSubscriptionLoading = false;

  GetAllSubscriptionPlanResponseModel getAllSubscriptionPlanResponseModel = GetAllSubscriptionPlanResponseModel(
    success: false,
    message: '',
    data: [],
  );


  Future<void>getAllSubscription()async{
    isSubscriptionLoading = true;
    update();
    try {
      Response? response = await subscriptionServiceInterface.getAllSubscription();
      if(response.statusCode == 200) {
        getAllSubscriptionPlanResponseModel = GetAllSubscriptionPlanResponseModel.fromJson(response.body);
        print('Success: getAllSubscription');
      }else{
        ApiChecker.checkApi(response);
      }
    } catch (e) {
      print('Error in getAllSubscription: $e');
    }
    isSubscriptionLoading = false;
    update();
  }
}