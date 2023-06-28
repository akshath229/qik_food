import 'package:get/get.dart';
import 'package:qik_food/controllers/cart_controller.dart';
import 'package:qik_food/data/repository/popular_prodct_repo.dart';
import '../models/cart_model.dart';
import '../models/popularprodctmodel.dart';

class PopularProductController extends GetxController {
  final PopularProductRepo popularProductRepo;

  PopularProductController({required this.popularProductRepo});

  List<dynamic> _popularProductList = [];
  List<dynamic> get popularProductList => _popularProductList;
  late Cartcontroller _cart;


 int _quantity = 0;

 int get quantity=>_quantity;
 int _incartitems=0;
 int get incartitems=>_incartitems+_quantity;

  Future<void> getPopularProductList() async {
    Response response = await popularProductRepo.getPopularProductList();
    if (response.statusCode == 200) {
      print("got oi !!!!!!!");
      _popularProductList = [];
      _popularProductList.addAll(Product.fromJson(response.body).products);
      update();
    }else{


    }
  }

  void  setQuantity(bool isIncrement){
    if(isIncrement){
      _quantity = checkQuantity(_quantity+1);
    }else{
      _quantity = checkQuantity(_quantity-1);
    }
    update();
  }
 int checkQuantity(int quantity){
    if((_incartitems+quantity)<0){
      Get.snackbar("itemcount", "invalid number"
       );
      if(_incartitems>0){
        _quantity = -_incartitems;
        return _quantity;
      }
      return 0;
    }else if(_incartitems+quantity>10){
      Get.snackbar("itemcount", "reached max limit");
      return 10;
    }else{
      return quantity;
    }
  }

  void initProduct(ProductsModel product,Cartcontroller cart){
    _quantity=0;
    _incartitems=0;
    _cart=cart;
    var exist = false;
    exist= _cart.existInCart(product);
if(exist){
  _incartitems= _cart.getQuantity(product);
}

  }

  void addItem(ProductsModel product){

    if(_quantity>0){
      _cart.addItem(product, _quantity);
      _quantity=0;
      _incartitems=_cart.getQuantity(product);
    }
update();
  }

  int get totalitem{
    return _cart.totalitem;

  }
  List<CartModel> get getItems{
    return _cart.getItems;
  }
}