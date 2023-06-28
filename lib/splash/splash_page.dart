import 'dart:async';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:qik_food/routes/route_helper.dart';
import '../controllers/popular_proctcontroller.dart';
import '../controllers/reccmnd_food_controller.dart';

class Splashscreen extends StatefulWidget {
  const Splashscreen({Key? key}) : super(key: key);

  @override
  State<Splashscreen> createState() => _SplashscreenState();
}

class _SplashscreenState extends State<Splashscreen> with TickerProviderStateMixin{

 late Animation<double> animation;
 late AnimationController controller;

 Future<void>_loadresource() async {
   await Get.find<PopularProductController>().getPopularProductList();
   await Get.find<RecommendedProductController>().getRecommendedProductList();
 }

 @override
 void initState() {
   super.initState();
   _loadresource();
   controller = AnimationController(vsync: this, duration: Duration(seconds: 1))
     ..forward();

   animation = CurvedAnimation(parent: controller, curve: Curves.easeInQuad);

   Timer(
       Duration(seconds: 3),
           () => Get.offNamed(RouteHelper.getInitial())
   );
 }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.yellow.shade700,
      body: Column(mainAxisAlignment: MainAxisAlignment.center,crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          ScaleTransition(scale: animation,
              child:
              Center(child: Image.asset("lib/images/splash_logo_round.png",width: 290,)))
        ],
      ),
    );
  }
}
