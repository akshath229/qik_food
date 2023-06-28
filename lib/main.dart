import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:qik_food/controllers/cart_controller.dart';
import 'package:qik_food/controllers/popular_proctcontroller.dart';
import 'package:qik_food/controllers/reccmnd_food_controller.dart';
import 'package:qik_food/pages/fud_details.dart';
import 'package:qik_food/pages/home/homepagetwo.dart';
import 'package:qik_food/routes/route_helper.dart';
import 'package:qik_food/splash/splash_page.dart';
import 'pages/home/popularfud_details.dart';
import 'helper/dependencies.dart'as dependcy;

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await dependcy.init();
  runApp(Qik_fud());
}

class Qik_fud extends StatelessWidget {
  Qik_fud({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Get.find<Cartcontroller>().GetCartData();

   return GetBuilder<PopularProductController>(builder: (_){
     return GetBuilder<RecommendedProductController>(builder: (_){
       return GetMaterialApp(
         debugShowCheckedModeBanner: false,
// home: Splashscreen(),
         initialRoute: RouteHelper.getsplashpage(),
         getPages: RouteHelper.routes,
         theme: ThemeData(useMaterial3: true),
       );
     });
   },);
  }
}
