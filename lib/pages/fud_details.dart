import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:qik_food/controllers/popular_proctcontroller.dart';
import 'package:qik_food/defaults/app_constrains.dart';
import 'package:qik_food/reusableitems/quantity.dart';
import 'package:qik_food/controllers/popular_proctcontroller.dart';
import '../controllers/cart_controller.dart';
import '../defaults/dimensions.dart';
import '../reusableitems/app_column.dart';
import '../reusableitems/expandabletext.dart';
import '../reusableitems/icon.dart';
import 'cart/cart_page.dart';
import 'home/homepagetwo.dart';
import 'home/mainhomepage.dart';

class fooddetails extends StatelessWidget {
  int pageId;
  fooddetails({Key? key, required this.pageId}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var product= Get.find<PopularProductController>().popularProductList[pageId];
    Get.find<PopularProductController>().initProduct(product,Get.find<Cartcontroller>());

    return Scaffold(
      body: Stack(
        children: [

          Positioned(
            child: Column(
              children: [
                Container(
                height: 280,width: double.maxFinite,
                decoration: BoxDecoration(
                  image: DecorationImage(fit: BoxFit.cover,
                      image: NetworkImage(AppConstants.MAIN_URL+AppConstants.UPLOAD_URL+product.img!),
        ),
    ),
                )],
            ),
          ),
          Positioned(left: 20,right: 20,top: 20,
            child:
            Row(mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
    GestureDetector(onTap: (){Get.to((()=>Mainhomepage()));},
    child: AppIcon(icon: Icons.arrow_back_ios_new)),

                GetBuilder<PopularProductController>(builder: (controller){
                  return Stack(children: [
                    GestureDetector(onTap: () => showModalBottomSheet(isScrollControlled: true,
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.only(topLeft: Radius.circular(35),topRight:Radius.circular(35) )),
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
              ],
            ),),
          Positioned(top: 245,right: 0,left: 0,bottom: 0,
              child:
          Container(
            decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.only(topLeft: Radius.circular(20),topRight:Radius.circular(20) )),
            child: Padding(
              padding: const EdgeInsets.all(12.0),
              child:Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Appcolumn(text: product.name!,size: 40),
                  SizedBox(height: 12),
                  Text("About",style: TextStyle(fontSize: 20),),
                  Expanded(child: SingleChildScrollView(child: ExpandableText(text: product.description!,))),

                ],
              ),
            ),
          )),
      ],
      ),
      bottomNavigationBar: Container(
        height: 90,
        decoration: BoxDecoration(
            color: Colors.grey,
            borderRadius: BorderRadius.only(topLeft: Radius.circular(17),topRight:Radius.circular(17) )),
        child: Padding(
          padding: const EdgeInsets.only(left: 30,right: 30),
          child: Row(mainAxisAlignment: MainAxisAlignment.spaceBetween,
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
    );
  }
}
