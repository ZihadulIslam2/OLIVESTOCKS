import 'package:get/get_connect/http/src/response/response.dart';
import 'package:olive_stocks_flutter/features/explore_plan/repositories/subcription_repository_interface.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../core/contants/urls.dart';
import '../../../helpers/remote/data/api_client.dart';

class SubscriptionRepository implements SubscriptionRepositoryInterface {
  final ApiClient apiClient;
  final SharedPreferences sharedPreferences;

  SubscriptionRepository(this.apiClient, this.sharedPreferences);

  @override
  Future<Response> getAllSubscription() async {
    return await apiClient.getData(Urls.getAllSubscription);

  }
}