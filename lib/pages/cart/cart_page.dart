import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_state_manager/get_state_manager.dart';
import 'package:qik_food/commonappwidget/empty_cart_page.dart';
import 'package:qik_food/controllers/cart_controller.dart';
import 'package:qik_food/controllers/popular_proctcontroller.dart';
import 'package:qik_food/controllers/reccmnd_food_controller.dart';
import 'package:qik_food/defaults/app_constrains.dart';
import 'package:qik_food/routes/route_helper.dart';

class Cartpage extends StatelessWidget {
  const Cartpage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(

        children: [
          Positioned(left: 0,right: 0,
    child: Container(width: double.maxFinite,decoration: BoxDecoration( color: Colors.teal),
      child:
      Column(
        children: [
          Icon(Icons.arrow_drop_up_sharp),
          Text("Cart",style: TextStyle(fontSize: 24,fontWeight: FontWeight.bold),),
        ],
      ),
    )
),

          GetBuilder<Cartcontroller>(builder: (_cartController){
            return _cartController.getItems.isNotEmpty?Positioned(top:70,bottom: 0,right: 0,left: 0,
              child: Container(
                  child:  GetBuilder<Cartcontroller>(builder: (cartcontroller) {
                    var _cartlist = cartcontroller.getItems;
                    return ListView.builder(
                        itemCount: _cartlist.length,
                        itemBuilder: (_,index){
                          return Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Container(height: 130,width: double.maxFinite,
                              decoration:BoxDecoration(color: Colors.white,
                                  borderRadius: BorderRadius.circular(35),border: Border.all(color: Colors.black38)),
                              child: Row(
                                children: [
                                  GestureDetector(onTap: () {
                                    var popularIndex = Get.find<PopularProductController>()
                                        .popularProductList.indexOf(_cartlist[index].product!);
                                    if(popularIndex>=0){
                                      Get.toNamed(RouteHelper.getpopularFood(popularIndex));

                                    }else{
                                      var recommendedIndex = Get.find<RecommendedProductController>()
                                          .recommendedProductList.indexOf(_cartlist[index].product!);
                                      if(recommendedIndex<0){
                                        Get.snackbar("histry product", "not avialble");
                                      }else{
                                        Get.toNamed(RouteHelper.getreccomendedFood(recommendedIndex));
                                      }

                                    }
                                  },
                                    child: Container(height:130,width: 110,
                                      decoration:
                                      BoxDecoration(borderRadius: BorderRadius.only(topLeft: Radius.circular(35),bottomLeft: Radius.circular(25)),color: Colors.teal,
                                        image: DecorationImage(fit: BoxFit.cover,
                                          image: NetworkImage(AppConstants.MAIN_URL+AppConstants.UPLOAD_URL+cartcontroller.getItems[index].img!),
                                        ),),
                                    ),
                                  ),
                                  SizedBox(width: 8,),
                                  Expanded(
                                    child: Container(
                                      height: 120,
                                      child: Column(
                                        crossAxisAlignment: CrossAxisAlignment.start,
                                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                        children: [
                                          Text(cartcontroller.getItems[index].name!,
                                            style: TextStyle(color: Colors.black,fontSize: 25),),
                                          Text("normlf",style: TextStyle(color: Colors.grey,),),
                                          Row(
                                            children: [
                                              Text( "\₹ "+cartcontroller.getItems[index]!.price.toString(),
                                                style: TextStyle(color: Colors.black,fontSize: 25),),
                                              SizedBox(width: 45),
                                              Container(
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
                                                        cartcontroller.addItem(_cartlist[index].product!, -1);
                                                      },
                                                      icon: Icon(Icons.remove),
                                                    ),
                                                    Text(_cartlist[index].quantity.toString(),
                                                      style: TextStyle(fontSize: 20),
                                                    ),
                                                    IconButton(
                                                      onPressed: () {
                                                        cartcontroller.addItem(_cartlist[index].product!, 1);
                                                      },
                                                      icon: Icon(Icons.add),
                                                    ),
                                                  ],
                                                ),
                                              ),
                                            ],
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                ],

                              ),
                            ),
                          );
                        }
                    );
                  }
                  )
              ),
            ):NodataPage();
          })
        ],
      ),




      bottomNavigationBar:GetBuilder<Cartcontroller>(builder: (cartcontroller) {
        return Container(
          height: 90,
          decoration: BoxDecoration(
              color: Colors.grey,
              borderRadius: BorderRadius.only(topLeft: Radius.circular(17),topRight:Radius.circular(17) )),
          child: Padding(
            padding: const EdgeInsets.only(left: 30,right: 30),
            child: cartcontroller.getItems.length > 0?
            Row(mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [

                Container(
                    width: 130,
                    height: 50,
                    decoration: BoxDecoration(color: Colors.white,
                      borderRadius: BorderRadius.circular(35),
                      border: Border.all(color: Colors.white),
                    ),
                    child: Container(
                      child: Center(child: Text("\₹ "+cartcontroller.totalAmount.toString())),),
                  ),


                GetBuilder<Cartcontroller>(builder: (Cartcontroller) {
                  return Container(height: 55,width: 160,decoration: BoxDecoration(color: Colors.green,
                    borderRadius: BorderRadius.circular(35),),
                    child:  Center(
                      child: GestureDetector(onTap:(){
                        Cartcontroller.addToHistory();
                        print("tatp");
                      } ,
                        child: Text(
                          "Checkout",
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
            ):Container(),
          ),
        );
      })


    );

  }
}
