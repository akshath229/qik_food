import 'package:get/get.dart';
import 'package:qik_food/data/repository/cart_repo.dart';
import 'package:qik_food/models/cart_model.dart';
import 'package:qik_food/models/popularprodctmodel.dart';

class Cartcontroller extends GetxController{
  final Cartrepo cartrepo;
  Cartcontroller({required this.cartrepo});
  Map<int, CartModel> _item={};

  Map<int, CartModel> get item=> _item;

  List<CartModel> storageItems=[];
  
  
  void addItem(ProductsModel product, int quantity){
    var totalQuantity=0;
      if(_item.containsKey(product.id!)){
        _item.update(product.id!, (value)
        {
          totalQuantity= value.quantity!+quantity;
          return CartModel(
            id:value.id,
            name:value.name,
            price  :value.price,
            img :value.img,
            quantity :value.quantity!+quantity,
            isExist:true,
            time:DateTime.now().toString(),
            product: product,
          );
        });
        if(totalQuantity<=0){
          _item.remove(product.id);
        }
      }else{
        if(quantity>0){
          _item.putIfAbsent(product.id!, () {

            return CartModel(
              id:product.id,
              name:product.name,
              price  :product.price,
              img :product.img,
              quantity :quantity,
              isExist:true,
              time:DateTime.now().toString(),
              product: product,
            );
          }
          );
        }else{
          Get.snackbar("itemcount", "atleat 1");
        }

      }
      cartrepo.addToCartList(getItems);
update();
}

  bool existInCart(ProductsModel product){
    if(_item.containsKey(product.id)){
      return true;
    }
    return false;
}
  var quantity=0;
  int getQuantity(ProductsModel product){
    if(_item.containsKey(product.id)){
      _item.forEach((key, value) {
        if(key==product.id){
          quantity = value.quantity!;
        }
      });
    }
    return quantity;
}

  int get totalitem{
  var totalQuantity=0;
  _item.forEach((key, value) {
    totalQuantity += value.quantity!;
  });
  return totalQuantity;
}

List<CartModel> get getItems{
  return _item.entries.map((e) {
    return e.value;
   }).toList();
}

  int get totalAmount{
    var total=0;
    _item.forEach((key, value) {
      total += value.quantity!*value.price!;
    });
    return total;
  }

  List<CartModel> GetCartData(){

    setCart = cartrepo.getCartList();
    return storageItems;
  }
  set setCart(List<CartModel>items){
    storageItems = items;

    for(int i=0;i<storageItems.length;i++){
      _item.putIfAbsent(storageItems[i].product!.id!, () => storageItems[i]);
    }
  }

  void addToHistory(){
    cartrepo.addToCartHistoryList();
    clear();
  }
void clear(){
    _item={};
    update();
}

List<CartModel> getCartHistoryList(){
    return cartrepo.getCartHistoryList();
}

set setItems(Map<int,CartModel>setItems) {
  _item = {};
  _item = setItems;
}

void addToCartList(){
    update();
}
  }
