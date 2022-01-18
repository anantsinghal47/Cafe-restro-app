import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';

class CartItem{
  final String image;
  final String id;
  final String title;
  final int quantity;
  final double price;
  CartItem({
    @required this.id,
    @required this.title,
    @required this.quantity,
    @required this.price,
    @required this.image
  }
    );
}

class Cart with ChangeNotifier {

  Map<String,CartItem> _items={};
  Map<String,CartItem>  get items {
    return {..._items};
  }
  int get itemCount{
    return _items == null ? 0 : _items.length;
  }
  double get totalPrice {
    var total =0.0;
    _items.forEach((key, cartItem) {
      total += cartItem.price * cartItem.quantity;
    });
    return total;
  }

  void addItem(String id , String title , double price , int quantity , String image){
    if(_items.containsKey(id)){
      print("hello");
      //change the quantity4
      _items.update(id, (existingItem) => CartItem(id: existingItem.id, title: existingItem.title, quantity: existingItem.quantity + quantity, price: existingItem.price ,image: existingItem.image));
    }
    else {
      print("hemlo");
      _items.putIfAbsent(id, () => CartItem(id: id, title: title, quantity: quantity, price: price , image: image));
    }
    notifyListeners();
  }
  void removeItem(String productId){
    _items.remove(productId);
    notifyListeners();
  }
  void clear(){
    _items ={};
    notifyListeners();
  }
}

class CartModel {
  final String image;
  final String id;
  final String title;
  final int quantity;
  final double price;

  CartModel(this.image, this.id, this.title, this.quantity, this.price);

  Map<String, dynamic> toMap() {
    return {
      'image': image,
      'id': id,
      'title': title,
      'quantity': quantity,
      'price': price,
    };
  }
}
class ListProduct {
 final List<CartItem> cartItem;
 ListProduct(this.cartItem);
  List<Map<String , dynamic >> convert(){
    List<Map<String,dynamic>> abc = [] ;

    cartItem.forEach((e) {
      int i = 0;
      abc.insert(i, {
        'image': e.image,
        'id' : e.id,
        'title':e.title,
        'quantity' : e.quantity,
        'price' : e.price
      });
      i++;

    });
    return abc;
  }
}