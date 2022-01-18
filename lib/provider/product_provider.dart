import 'package:flutter/material.dart';
import 'package:cafe91asm/modal/product.dart';



class Products with ChangeNotifier  {
  List<Product> _items = [
    //best sellers index 0 to 4
    // Product(category: 'samosa', id: 'p1', title: "Cheese Samosa", price: 20, imgPath: 'assets/images/samosa.jpg', description: 'crispy potato samosa', isFav: false),
    // Product(category: 'pizza',id: 'p2', title: "Paneer Pizza", price: 200, imgPath: 'assets/images/pizz1.jpg', description: 'Double Cheese Pizza',isFav: false),
    // Product(category: 'ck',id: 'p3', title: "Chole Kulche", price: 15, imgPath: 'assets/images/ck2.jpg', description: 'hot chick pea',isFav: false),
    // Product(category: 'chai',id: 'p4', title: "Chocolaty Chai", price: 40, imgPath: 'assets/images/pizz1.jpg', description: 'choco tea ',isFav: false),
    // Product(category: 'pasta',id: 'p5', title: "Red Sauce Pasta", price: 60, imgPath: 'assets/images/ps4.jpg', description: 'pasta',isFav: false),
    // //pastas index 5 to 7
    // Product(category: 'pasta',id: 'p5', title: "Red Sauce Pasta", price: 60, imgPath: 'assets/images/ps4.jpg', description: 'pasta',isFav: false),
    // Product(category: 'pasta',id: 'p5.1', title: "White Sauce Pasta", price: 100, imgPath: 'assets/images/ps4.jpg', description: 'pasta',isFav: false),
    // Product(category: 'pasta',id: 'p5.2', title: "Tandoori  Pasta", price: 120, imgPath: 'assets/images/ps4.jpg', description: 'pasta',isFav: false),
    // //samosa index 8 to 10
    // Product(category: 'samosa', id: 'p1', title: "Cheese Samosa", price: 20, imgPath: 'assets/images/samosa.jpg', description: 'crispy potato samosa', isFav: false),
    // Product(category: 'samosa', id: 'p1.1', title: "Aaloo paneer Samosa", price: 10, imgPath: 'assets/images/samosa.jpg', description: 'crispy potato samosa', isFav: false),
    // Product(category: 'samosa', id: 'p1.2', title: "Chinese Samosa", price: 30, imgPath: 'assets/images/samosa.jpg', description: 'crispy potato samosa', isFav: false),
    // //pizzas index 11 to 13
    // Product(category: 'pizza',id: 'p2', title: "Paneer Pizza", price: 200, imgPath: 'assets/images/pizz1.jpg', description: 'Double Cheese Pizza',isFav: false),
    // Product(category: 'pizza',id: 'p2.1', title: "Cheese Pizza", price: 180, imgPath: 'assets/images/pizz1.jpg', description: 'Double Cheese Pizza',isFav: false),
    // Product(category: 'pizza',id: 'p2.2', title: "Onion Pizza", price: 180, imgPath: 'assets/images/pizz1.jpg', description: 'Double Cheese Pizza',isFav: false),
    // //shakes index 14 to 16
    // Product(category: 'shakes',id: 'p6', title: "Pineapple shake", price: 50, imgPath: 'assets/images/shk.jpg', description: 'smoothies',isFav: false),
    // Product(category: 'shakes',id: 'p6.1', title: "Chocolate shake", price: 50, imgPath: 'assets/images/shk.jpg', description: 'smoothies',isFav: false),
    // Product(category: 'shakes',id: 'p6.2', title: "Oreo shake", price: 80, imgPath: 'assets/images/shk.jpg', description: 'smoothies',isFav: false),
    // //maggi index 17 to 19
    // Product(category: 'maggie',id: 'p7', title: "veg maggie", price: 30, imgPath: "assets/images/mg.jpg", description: 'maggie',isFav: false),
    // Product(category: 'maggie',id: 'p7.1', title: "cheese maggie", price: 40, imgPath: "assets/images/mg.jpg", description: 'maggie',isFav: false),
    // Product(category: 'maggie',id: 'p7.2', title: "paneer maggie", price: 40, imgPath: "assets/images/mg.jpg", description: 'maggie',isFav: false),




  ];

  List<Product> get items{
    return [..._items]; // copy of items
  }
  Product findById(String id){
    return _items.firstWhere((prod) => prod.id == id);
  }
  void addProduct(){
    //_items.add(value);
    notifyListeners();
  }
}

// class Maggie with ChangeNotifier{
//   List<Product> _maggie = [
//     Product(category: 'maggie',id: 'p7', title: "veg maggie", price: 30, imgPath: "assets/images/mg.jpg", description: 'maggie',isFav: false),
//     Product(category: 'maggie',id: 'p7.1', title: "cheese maggie", price: 40, imgPath: "assets/images/mg.jpg", description: 'maggie',isFav: false),
//     Product(category: 'maggie',id: 'p7.2', title: "paneer maggie", price: 40, imgPath: "assets/images/mg.jpg", description: 'maggie',isFav: false),
//   ];
//
//   List<Product> get maggie{
//     return [..._maggie]; // copy of items
//   }
// }