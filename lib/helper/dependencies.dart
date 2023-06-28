import 'package:get/get.dart';
import 'package:qik_food/controllers/cart_controller.dart';
import 'package:qik_food/controllers/popular_proctcontroller.dart';
import 'package:qik_food/controllers/reccmnd_food_controller.dart';
import 'package:qik_food/data/api/api_client.dart';
import 'package:qik_food/data/repository/cart_repo.dart';
import 'package:qik_food/data/repository/popular_prodct_repo.dart';
import 'package:qik_food/data/repository/recoomnd_product_repo.dart';
import 'package:qik_food/defaults/app_constrains.dart';
import 'package:shared_preferences/shared_preferences.dart';

Future<void> init()async {

  final sharedPreferences = await SharedPreferences.getInstance();

  Get.lazyPut(()=>sharedPreferences);
// api client
  Get.lazyPut(()=> Apiclient(appBaseUrl: AppConstants.MAIN_URL));


  //repositry
  Get.lazyPut(()=>PopularProductRepo(apiClient: Get.find()));
  Get.lazyPut(()=>RecommendedProductRepo(apiClient: Get.find()));
  Get.lazyPut(()=>Cartrepo(sharedPreferences: Get.find()));

  //controllers
  Get.lazyPut(()=>PopularProductController(popularProductRepo: Get.find()));
  Get.lazyPut(()=>RecommendedProductController(recommendedProductRepo: Get.find()));
  Get.lazyPut(()=>Cartcontroller(cartrepo: Get.find()));


}