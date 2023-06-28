import 'package:dots_indicator/dots_indicator.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:qik_food/controllers/popular_proctcontroller.dart';
import 'package:qik_food/controllers/reccmnd_food_controller.dart';
import 'package:qik_food/defaults/app_constrains.dart';
import 'package:qik_food/defaults/dimensions.dart';
import 'package:qik_food/models/popularprodctmodel.dart';
import 'package:qik_food/pages/home/popularfud_details.dart';
import 'package:qik_food/routes/route_helper.dart';
import '../../reusableitems/app_column.dart';

class Newfoodsslide extends StatefulWidget {
  const Newfoodsslide({Key? key}) : super(key: key);

  @override
  State<Newfoodsslide> createState() => _NewfoodsslideState();
}

class _NewfoodsslideState extends State<Newfoodsslide> {
  PageController pagecontroller = PageController(viewportFraction: .85);
  var _currPageValue = 0.0;
  double _scaleFactor=0.8;
  double _height = Dimensions.pageviewcontainer;

  @override
  void initState(){
    super.initState();
    pagecontroller.addListener(() {
      setState(() {
        _currPageValue = pagecontroller.page!;

      });
    });
  }
  @override
  void dispose(){
    pagecontroller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        GetBuilder<PopularProductController>(builder: (popularproducts) {

         return Container(height: Dimensions.pageviewfullcontainer,
          child: PageView.builder(
          controller: pagecontroller,
          itemCount: popularproducts.popularProductList.length,
          itemBuilder: (context,position){
          return _buildPageItem(position, popularproducts.popularProductList[position]);
          }
          )
          );
        }
        ),


    GetBuilder<PopularProductController>(builder: (popularproducts) {
         return DotsIndicator(
    dotsCount: popularproducts.popularProductList.length<=0?1:popularproducts.popularProductList.length,
      position: _currPageValue.floor(),
      decorator: DotsDecorator(
    size: const Size.square(9.0),
    activeSize: const Size(18.0, 9.0),
    activeShape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(5.0)),
    ),
         );
    }
    ),
        SizedBox(height: Dimensions.height25,),
        Row(
          children: [
            Text("popular"),
          ],
        ),
        // list of food and details
    GetBuilder<RecommendedProductController>(builder: (reccomendedproducts) {
          return ListView.builder(physics: NeverScrollableScrollPhysics(),
              shrinkWrap: true,
              itemCount: reccomendedproducts.recommendedProductList.length,
              itemBuilder: (context, index){
            return Padding(
              padding: const EdgeInsets.only(bottom: 8,left: 20,right:20 ,top:10 ),
              child: GestureDetector(onTap: (){Get.toNamed(RouteHelper.getreccomendedFood(index));
              },
                child: Container(width: double.maxFinite,height:140,
                  child: Row(
                    children: [
                                                      // image
                      Container(height: 125,width: 140,
                          decoration: BoxDecoration(
                              image:DecorationImage(image:
                              NetworkImage(
                                  AppConstants.MAIN_URL+AppConstants.UPLOAD_URL+reccomendedproducts.recommendedProductList[index].img!),
                                  fit: BoxFit.cover,),
                              borderRadius: BorderRadius.only(topLeft: Radius.circular(35),bottomLeft:Radius.circular(35) )),
                      ),
                      SizedBox(width: 5),
                                                       // text
                      Expanded(
                        child:
                        Container(height: 125,
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.only(
                                  bottomRight: Radius.circular(35),topRight:Radius.circular(35)),
                              border: Border.all(width: .5,color: Colors.black12),
                              color: Colors.white,
                          ),
                          child:
                          Padding(
                            padding: const EdgeInsets.only(left: 18),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                SizedBox(height: 13),
                                Text(reccomendedproducts.recommendedProductList[index].name!,style: TextStyle(fontSize: Dimensions.font20,)),
                                SizedBox(height: 8),
                                Text("Fresh tomato,cucumber,onion,spinach",style: TextStyle(color: Colors.grey,fontSize:Dimensions.font13)),
                                SizedBox(height: 10),
                                Row(

                                  children: [
                                    Icon(Icons.fast_forward_outlined,color: Colors.red),
                                    Text("Fast delivery",style: TextStyle(color: Colors.grey,fontSize:Dimensions.font13)),

                                    Icon(Icons.location_on,color: Colors.tealAccent),
                                    Text("3.5 KM",style: TextStyle(color: Colors.grey,fontSize:Dimensions.font13)),

                                    Icon(Icons.access_time_rounded,color: Colors.orange.shade900),
                                    Text("20 min",style: TextStyle(color: Colors.grey,fontSize:Dimensions.font13)),
                                  ],
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            );
          });}
  ),
      ],
    );
  }
  Widget _buildPageItem(int index, ProductsModel popularProduct, ){
    Matrix4 matrix = new Matrix4.identity();
    if(index==_currPageValue.floor()){
      var currscale = 1-(_currPageValue-index)*(1-_scaleFactor);
      var currTrans =  _height*(1-currscale)/2;
      matrix = Matrix4.diagonal3Values(1,currscale,1)..setTranslationRaw(0,currTrans,0);
    }
    else if(index == _currPageValue.floor()+1){
      var currscale = _scaleFactor+(_currPageValue-index+1)*(1-_scaleFactor);
      var currTrans = _height*(1-currscale)/2;
      matrix = Matrix4.diagonal3Values(1,currscale,1);
      matrix = Matrix4.diagonal3Values(1,currscale,1)..setTranslationRaw(0,currTrans,0);
    }
    else if(index == _currPageValue.floor()-1){
      var currscale = 1-(_currPageValue-index)*(1-_scaleFactor);
      var currTrans = _height*(1-currscale)/2;
      matrix = Matrix4.diagonal3Values(1,currscale,1);
      matrix = Matrix4.diagonal3Values(1,currscale,1)..setTranslationRaw(0,currTrans,0);
    }
    else{
      var currscale = .8;
      matrix = Matrix4.diagonal3Values(1,currscale,1)..setTranslationRaw(0,_height*(1-_scaleFactor)/2,1);
    }
    return Transform(transform: matrix,
      child: Stack(
        children: [
          GestureDetector(
            onTap: (){
              Get.toNamed(RouteHelper.getpopularFood(index));
            },
            child: Container(
            height: Dimensions.pageviewcontainer,
            margin: EdgeInsets.only(right: Dimensions.width20,left: Dimensions.width20),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(Dimensions.circlebordersmall),
              color: Colors.lightGreen,
              image: DecorationImage(image:NetworkImage(
                  AppConstants.MAIN_URL+"/uploads/images/"+popularProduct.img!),
                fit: BoxFit.cover,),
            ),
        ),
          ),
          Align(
            alignment: Alignment.bottomCenter,
            child: Container(
              height: Dimensions.pageviewtxtcontainer,
              margin: EdgeInsets.only(right: Dimensions.width27,left: Dimensions.width27,bottom: Dimensions.height18),
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(Dimensions.circleborder),
                  color: Colors.grey.shade100,
                boxShadow: [
                  BoxShadow(color: Colors.black12,blurRadius: 8.0,offset: Offset(0,5)),

                ],

              ),
              child: Container(width: double.maxFinite,
                child: Padding(
                  padding: const EdgeInsets.all(18.0),
                  child: Appcolumn(text: popularProduct.name!,size: 22),

                ),
              ),
            ),
          ),
      ]
      ),
    );
  }
}
