import 'package:get/get_connect/http/src/response/response.dart';
import 'package:olive_stocks_flutter/features/explore_plan/services/service_repository_interface.dart';

import '../repositories/subcription_repository_interface.dart';

class SubscriptionService implements SubscriptionServiceInterface {

  final SubscriptionRepositoryInterface subscriptionRepositoryInterface;

  SubscriptionService(this.subscriptionRepositoryInterface);

  @override
  Future<Response> getAllSubscription() async {
    return await subscriptionRepositoryInterface.getAllSubscription();

  }

}