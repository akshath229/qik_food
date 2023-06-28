import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:qik_food/controllers/cart_controller.dart';
import 'package:qik_food/controllers/popular_proctcontroller.dart';
import 'package:qik_food/controllers/reccmnd_food_controller.dart';
import 'package:qik_food/defaults/app_constrains.dart';
import 'package:qik_food/defaults/dimensions.dart';
import 'package:qik_food/reusableitems/expandabletext.dart';
import 'package:qik_food/reusableitems/icon.dart';
import 'package:qik_food/reusableitems/quantity.dart';
import '../cart/cart_page.dart';
import 'homepagetwo.dart';
import 'mainhomepage.dart';
import 'newfud_tile.dart';

class Popularfud_details extends StatelessWidget {
  final int pageId;
  const Popularfud_details({Key? key,required this.pageId}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var product = Get.find<RecommendedProductController>().recommendedProductList[pageId];
    Get.find<PopularProductController>().initProduct(product,Get.find<Cartcontroller>());
    return Scaffold(
      body: CustomScrollView(
        slivers: [
          SliverAppBar(leading: GestureDetector(
              onTap: (){Get.to((()=>Mainhomepage()));},
              child: Icon(Icons.arrow_back_ios_new_rounded,color: Colors.white,size: Dimensions.iconsize)),
            actions: [Padding(
              padding: const EdgeInsets.only(right: 15),
              child:  GetBuilder<PopularProductController>(builder: (controller){
                return Stack(children: [
                  GestureDetector(onTap: () => showModalBottomSheet(isScrollControlled: true,
                    context: context, builder: (context) => Cartpage(),),
                      child: AppIcon(icon: Icons.add_shopping_cart)),
                  Get.find<PopularProductController>().totalitem>=1?
                  Positioned(right: 26,left: 26,
                    child:
                    AppIcon(icon: Icons.circle,size: 12,backgroundColour: Colors.lightGreen,iconColor: Colors.white12),
                  ):

                  Container(),
                  Get.find<PopularProductController>().totalitem>=1?
                  Positioned(right:26,left: 34,top: 4,
                    child:Text(Get.find<PopularProductController>().totalitem.toString(),
                        style: TextStyle(color: Colors.white,fontSize: 12)),

                  ):
                  Container(),

                ],);
              }
              )
            ),
            ],
            flexibleSpace: FlexibleSpaceBar(
              background: Image.network(AppConstants.MAIN_URL+AppConstants.RECCOMENDED_PRODUCT_URL+product.img!,width: double.maxFinite,fit: BoxFit.cover,),
              centerTitle: true,
              title: Text(product.name!),
            ),
            expandedHeight: 250,floating: true,
            pinned: true,backgroundColor: Colors.grey,

          ),
          SliverToBoxAdapter(child: Container(
            child: Padding(
              padding: const EdgeInsets.all(35.0),
            child: ExpandableText(text: product.description!),),

          ),),
        ],
      ),
      bottomNavigationBar: Column(
        mainAxisSize: MainAxisSize.min,
        children: [

          GetBuilder<PopularProductController>(builder: (popularproducts) {
            return Container(
              width: 130,
              height: 50,
              decoration: BoxDecoration(color: Colors.white,
                borderRadius: BorderRadius.circular(35),
                border: Border.all(color: Colors.white),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  IconButton(
                    onPressed: () {
                      popularproducts.setQuantity(false);
                    },
                    icon: Icon(Icons.remove),
                  ),
                  Text(
                    popularproducts.incartitems.toString(),
                    style: TextStyle(fontSize: 20),
                  ),
                  IconButton(
                    onPressed: () {
                      popularproducts.setQuantity(true);
                    },
                    icon: Icon(Icons.add),
                  ),
                ],
              ),
            );

          },
          ),
          Container(
            height: 90,
            decoration: BoxDecoration(
                color: Colors.grey,
                borderRadius: BorderRadius.only(topLeft: Radius.circular(17),topRight:Radius.circular(17) )),
            child: Padding(
              padding: const EdgeInsets.only(left: 30,right: 30),
              child: Row(mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Container(width: 50,height: 50,decoration: BoxDecoration(borderRadius: BorderRadiusDirectional.circular(12),color: Colors.white),
                    child: Icon(Icons.favorite),),
                  GetBuilder<PopularProductController>(builder: (popularproducts) {
                    return Container(height: 55,width: 160,decoration: BoxDecoration(color: Colors.green,
                      borderRadius: BorderRadius.circular(35),),
                      child:  Center(
                        child: GestureDetector(onTap:(){
                          popularproducts.addItem(product);
                        } ,
                          child: Text(
                            "\₹ ${product.price!} | Add to Cart",
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 16.0,
                            ),
                          ),
                        ),
                      ),
                    );
                  })
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
