import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:intl/intl.dart';
import 'package:qik_food/commonappwidget/empty_cart_page.dart';
import 'package:qik_food/controllers/cart_controller.dart';
import 'package:qik_food/defaults/app_constrains.dart';
import 'package:qik_food/models/cart_model.dart';
import 'package:qik_food/routes/route_helper.dart';

import '../../reusableitems/icon.dart';
import 'cart_page.dart';

class CartHistory extends StatelessWidget {
  const CartHistory({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var getCartHistoryList = Get.find<Cartcontroller>().getCartHistoryList().reversed.toList();

    Map<String, int> cartItemsPerOrder = Map();

    for (int i = 0; i < getCartHistoryList.length; i++) {
      if (cartItemsPerOrder.containsKey(getCartHistoryList[i].time)) {
        cartItemsPerOrder.update(getCartHistoryList[i].time!, (value) => ++value);
      } else {
        cartItemsPerOrder.putIfAbsent(getCartHistoryList[i].time!, () => 1);
      }
    }

    List<int> cartItemsPerOrderToList() {
      return cartItemsPerOrder.entries.map((e) => e.value).toList();
    }

    List<String> cartOrderTimeToList() {
      return cartItemsPerOrder.entries.map((e) => e.key).toList();
    }

    List<int> ItemsPerOrder = cartItemsPerOrderToList();
    var Listcounter = 0;
   Widget timewidget(int index){
     var outputDate = DateTime.now().toString();
     if(index<getCartHistoryList.length){
       DateTime parseDate =
       DateFormat("yyyy-MM-dd HH:mm:ss").parse(getCartHistoryList[Listcounter].time!);
       var inputDate = DateTime.parse(parseDate.toString());
       var outputFormat = DateFormat("MM/dd/yyyy hh:mm a");
       var outputDate = outputFormat.format(inputDate);
     }

      return Text(outputDate);
    }

    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text(
          "Order history",
          style: TextStyle(fontSize: 25),
        ),
        actions: [
          GestureDetector(
            onTap: () => showModalBottomSheet(
              isScrollControlled: true,
              context: context,
              builder: (context) => Cartpage(),
            ),
            child: AppIcon(icon: Icons.add_shopping_cart),
          ),
          SizedBox(),
        ],
      ),
      body: Column(
        children: [
          GetBuilder<Cartcontroller>(builder: (_cartController){
            return _cartController.getCartHistoryList().length>0?
            Expanded(
              child: Container(
                height: 200,
                child: ListView.builder(
                  itemCount: ItemsPerOrder.length,
                  itemBuilder: (context, i) {
                    String orderTime = cartItemsPerOrder.keys.elementAt(i);
                    int itemCount = cartItemsPerOrder[orderTime]!;

                    return Container(
                      height: 150,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          timewidget(Listcounter),

                          SizedBox(
                            height: 6,
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Wrap(
                                direction: Axis.horizontal,
                                children: List.generate(itemCount, (index) {
                                  if (Listcounter < getCartHistoryList.length) {
                                    Listcounter++;
                                  }
                                  // number of images show ith history
                                  return index <= 2
                                      ? Container(
                                    height: 50,
                                    width: 50,
                                    margin: EdgeInsets.only(right: 5),
                                    decoration: BoxDecoration(
                                      color: Colors.orange,
                                      image: DecorationImage(
                                        fit: BoxFit.cover,
                                        image: NetworkImage(AppConstants.MAIN_URL +
                                            AppConstants.UPLOAD_URL +
                                            getCartHistoryList[Listcounter - 1].img!),
                                      ),
                                    ),
                                  )
                                      : Container();
                                }),
                              ),
                              Container(
                                height: 100,
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                  children: [
                                    Text("Total"),
                                    Text("Items: ${cartItemsPerOrder[orderTime]}"),
                                    ElevatedButton(
                                      style: ElevatedButton.styleFrom(
                                        primary: Colors.white, // Button color
                                        onPrimary: Colors.teal, // Text color
                                        side: BorderSide(color: Colors.teal), // Outline color
                                        fixedSize: Size(90, 25), // Button size
                                      ),
                                      onPressed: () {
                                        var orderTime = cartOrderTimeToList();
                                        Map<int, CartModel> moreOrder = {};
                                        for (int j = 0; j < getCartHistoryList.length; j++) {
                                          if (getCartHistoryList[j].time == orderTime[i]) {
                                            moreOrder.putIfAbsent(getCartHistoryList[j].id!, () =>
                                                CartModel.fromJson(jsonDecode(jsonEncode(getCartHistoryList[j])))
                                            );


                                          }
                                        }
                                        Get.find<Cartcontroller>().setItems = moreOrder;
                                        Get.find<Cartcontroller>().addToCartList();

                                        Get.toNamed(RouteHelper.getCartPage());
                                      },
                                      child: Text('Add More', style: TextStyle(fontSize: 8)),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    );
                  },
                ),
              ),
            ) : Padding(
              padding: const EdgeInsets.only(top: 180,),
              child: Center(
                child: Container(width: 350,
                    child: NodataPage(imgpath: "lib/images/order_history.png",)),
              ),
            );
          })


        ],
      ),
    );
  }
}
