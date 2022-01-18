// import 'package:cafe91asm/modal/product.dart';
// import 'package:cafe91asm/provider/cart.dart';
// import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:flutter/material.dart';
// import 'package:provider/provider.dart';
//
// class CartScreen extends StatefulWidget {
//   @override
//   _CartScreenState createState() => _CartScreenState();
// }
//
// class _CartScreenState extends State<CartScreen> {
//
//
//   @override
//
//   Widget build(BuildContext context) {
//     final cart = Provider.of<Cart>(context);
//     return Scaffold(
//
//         body : cart.itemCount != 0 ?
//     );
//   }
// }
//
// class CartItem extends StatelessWidget {
//   final String image;
//   final String id;
//   final String productId;
//   final String title;
//   final double price;
//   final int quantity;
//   CartItem(this.id , this.productId , this.title , this.price , this.quantity , this.image);
//   @override
//   Widget build(BuildContext context) {
//     final cart = Provider.of<Cart>(context ,listen: false);
//     return Dismissible(
//       direction: DismissDirection.startToEnd,
//       onDismissed: (direction){
//         cart.removeItem(productId);
//       },
//       key: ValueKey(id),
//       background: Container(
//         alignment: Alignment.centerLeft,
//         padding: EdgeInsets.only(left: 20),
//         margin: EdgeInsets.symmetric(horizontal: 0, vertical: 4),
//         color: Colors.redAccent,
//         child: Icon(
//           Icons.delete,
//           color: Colors.white,
//           size: 30,
//         ),
//       ),
//       child: Card(
//         shape: RoundedRectangleBorder(
//             borderRadius: BorderRadius.circular(20)
//         ),
//         margin: EdgeInsets.symmetric(horizontal: 10 , vertical: 2),
//         child:Container(
//           height: 120,
//           //padding: EdgeInsets.all(0),
//           child: ListTile(
//             leading: CircleAvatar(
//               maxRadius: 50,
//               backgroundColor: Colors.white,
//                child: SizedBox(
//                  height: 100,
//                  width: 100,
//                  child: image!= null ? Image(image: NetworkImage(image),) : CircularProgressIndicator(),
//                )
//     //Text(
//               //   '\₹${price*quantity}'
//               //   , style:  TextStyle(
//               //     fontSize: 15,
//               //     fontWeight: FontWeight.bold ,
//               //     color: Colors.white,
//               //     fontFamily: 'QuickSand'
//               // ),
//               // ),
//             ),
//             title: Text(
//               title,
//               style:  TextStyle(
//                   fontSize: 15 ,
//                   fontWeight: FontWeight.bold ,
//                   color: Colors.black54
//               ),
//             ),
//
//             subtitle: Text(
//               'Total: \₹${price*quantity}' ,
//               style:  TextStyle(
//                   color: Colors.black54,
//                   fontFamily: 'QuickSand'
//               ),
//             ),
//             trailing: Column(
//               children: [
//                 Text( ' x $quantity ' ,  style:  TextStyle( fontSize: 15, color: Colors.black54)),
//
//               ],
//             ),
//           ),
//         ),
//       ),
//     );
//   }
// }
