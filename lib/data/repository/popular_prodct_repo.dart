import 'package:get/get.dart';
import 'package:qik_food/data/api/api_client.dart';
import 'package:qik_food/defaults/app_constrains.dart';

class PopularProductRepo extends GetxService{
  final Apiclient apiClient;
  PopularProductRepo({required this.apiClient});

  Future<Response> getPopularProductList() async{
    return await apiClient.getData(AppConstants.POPULAR_PRODUCT_URL);
  }
}