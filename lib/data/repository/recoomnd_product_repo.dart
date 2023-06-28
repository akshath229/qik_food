import 'package:get/get.dart';
import 'package:qik_food/data/api/api_client.dart';
import 'package:qik_food/defaults/app_constrains.dart';

class RecommendedProductRepo extends GetxService{
  final Apiclient apiClient;
  RecommendedProductRepo({required this.apiClient});

  Future<Response> getRecommendedProductList() async{
    return await apiClient.getData(AppConstants.RECCOMENDED_PRODUCT_URL);
  }
}