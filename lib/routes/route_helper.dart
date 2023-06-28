import 'package:get/get.dart';
import 'package:qik_food/splash/splash_page.dart';
import '../pages/cart/cart_page.dart';
import '../pages/fud_details.dart';
import '../pages/home/homepagetwo.dart';
import '../pages/home/mainhomepage.dart';
import '../pages/home/popularfud_details.dart';

class RouteHelper{
  static const String splashpage= "/splash-page";
  static const String initial="/";
  static const String popularFood="/popular-food";
  static const String reccomendedFood="/reccomended-food";
  static const String cartPage="/cart-page";

  static String getsplashpage()=>'$splashpage';
  static String getInitial()=> '$initial';
  static  String getpopularFood(int pageId)=>"$popularFood?pageId=$pageId";
  static  String getreccomendedFood(int pageId)=>"$reccomendedFood?pageId=$pageId";
  static  String getCartPage()=>"$cartPage";


  static List<GetPage> routes=[
    GetPage(name: splashpage, page: ()=>Splashscreen()),
    GetPage(name:initial, page: ()=>Mainhomepage()),
    GetPage(name: popularFood, page: (){
      var pageId=Get.parameters['pageId'];

      return fooddetails(pageId:int.parse(pageId!));
    },
transition: Transition.native
    ),

    GetPage(name:  reccomendedFood, page: (){
      var pageId=Get.parameters['pageId'];
      return Popularfud_details(pageId:int.parse(pageId!));
    },
transition: Transition.native
    ),
    GetPage(name: cartPage, page: (){
      return Cartpage();
    },

    )
  ];
}