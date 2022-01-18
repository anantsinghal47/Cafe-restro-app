import 'dart:math';
import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:cafe91asm/DB/CRUD.dart';
import 'package:cafe91asm/DB/auth.dart';
import 'package:cafe91asm/UI/orderConfirmationScreen.dart';
import 'package:cafe91asm/provider/cart.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ProceedToPay extends StatefulWidget {

  final userId;
  final double amount ;
  final DateTime dt;
  final String address;


  ProceedToPay(this.amount , this.dt , this.userId , this.address);
  @override
  _ProceedToPayState createState() => _ProceedToPayState();
}
enum Delivery { Takeaway, Homedelivery}
enum method {cash , UPI}
class _ProceedToPayState extends State<ProceedToPay> {

  bool isTakeAway = true;
  bool delivery = false;

  Delivery _delivery = Delivery.Takeaway;
  method _meth = method.cash;
  @override
  Widget build(BuildContext context) {
    final cartProv = Provider.of<Cart>(context);
    return Scaffold(
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      floatingActionButton: _meth == method.cash ?
      Container(
        color: Colors.red[300],
        height: 50,
        width: MediaQuery.of(context).size.width/2,
          child: Row(
            mainAxisAlignment : MainAxisAlignment.spaceEvenly,
              children: [
        GestureDetector(

            onTap: (){
              AwesomeDialog(

                context: context,
                dialogType: DialogType.NO_HEADER,
                animType: AnimType.BOTTOMSLIDE,
                title: 'Confirm Order',
                desc: 'Press Ok to confirm',
                btnCancelOnPress: () {},
                btnOkOnPress: () {
                  AwesomeDialog(

                    context: context,
                    dialogType: DialogType.SUCCES,
                    animType: AnimType.BOTTOMSLIDE,
                    title: 'Order Confirmed',


                  )..show();
                  Future.delayed(Duration(seconds: 2), () {
                    var rng = new Random();
                    var a = rng.nextInt(1000);
                    var c = isTakeAway ? cartProv.totalPrice : cartProv.totalPrice + 40;
                    //orders.addOrder(cartProv.items.values.toList(), cartProv.totalPrice ,dt.toString() , ON , dt);
                    addItem(
                        userId : widget.userId,
                        id: widget.dt.toString(),
                        orderNum: a,
                        amount: c,
                        // products: orders.orders.map((e) => CartModel(e.products)).toList(),
                        products:ListProduct(cartProv.items.values.toList()).convert(),
                        dateTime: widget.dt
                    );
                    print("Order Placed");




                    // 5 seconds over, navigate to Page2.
                    Navigator.push(context, MaterialPageRoute(
                      // which screen we want to go
                        builder: (context) => OrderConfirmScreen(widget.userId, context ,a.toString() ,c , isTakeAway)));
                  });
                },
              )..show();

            },
            child:
            Text("Place Order" , style: TextStyle(color: Colors.white , fontSize: 18 , fontWeight: FontWeight.bold),))
      ],)) :

      Container(
          color: Colors.red[300],
          height: 50,
          width: MediaQuery.of(context).size.width/2,
          child: Row(
            mainAxisAlignment : MainAxisAlignment.spaceEvenly,
            children: [
              Text("Proceed To Pay" , style: TextStyle(color: Colors.white , fontSize: 18 , fontWeight: FontWeight.bold),)
            ],)),
      appBar: AppBar(backgroundColor: Colors.red[300], title: Text("Payment"),),
      body: Column(
        children: [
          SizedBox(height: 10,),
          Container(
            margin: const EdgeInsets.symmetric(vertical: 10 , horizontal: 5),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Padding(
                  padding: const EdgeInsets.only(left: 20),
                  child: Text("Amount: ₹" + widget.amount.toString() , style: TextStyle(fontSize: 18 ,  color: Colors.black54 , fontWeight: FontWeight.bold),),
                ),
                Padding(
                  padding: const EdgeInsets.only(right: 20),
                  child: Text("Items: " + cartProv.items.values.toList().length.toString(), style: TextStyle(fontSize: 18 , color: Colors.black54 ,  fontWeight: FontWeight.bold),),
                ),
              ],),
          ),
          Padding(
            padding: const EdgeInsets.only(left: 20, bottom: 15 , top: 20),
            child: Row(
              //mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
              Text("Choose Delivery Method" , style: TextStyle(fontSize: 18 ),)

            ],),
          ),
          Column(
            children: [
              ListTile(
                title: const Text('Take Away'),
                leading: Radio(
                  fillColor: MaterialStateProperty.all(Colors.green),
                  value: Delivery.Takeaway,
                  groupValue: _delivery,
                  onChanged: (Delivery value) {
                    setState(() {
                      delivery = false;
                      isTakeAway = true;
                      _delivery = value;
                    });
                  },
                ),
              ),
              ListTile(
                title: const Text('Home delivery'),
                leading: Radio(
                  fillColor: MaterialStateProperty.all(Colors.green),
                  value: Delivery.Homedelivery,
                  groupValue: _delivery,
                  onChanged: (Delivery value) {
                    setState(() {
                      _delivery = value;
                    delivery = true;
                    isTakeAway = false;
                    });
                  },
                ),
              ),
              _delivery == Delivery.Homedelivery ? Padding(
                padding: const EdgeInsets.only(left: 70),
                child: ListTile(
                           title:  Text(widget.address),

    ),
              ) : Container()


            ],
          ),
          SizedBox(height: 20,),
          Padding(
            padding: const EdgeInsets.only(left: 20 , bottom: 15 , top: 10),
            child: Row(
              // /mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Text("Choose Payment Method" , style: TextStyle(fontSize: 18 ),)

              ],),
          ),
          Column(
            children: [
              ListTile(
                title: const Text('Cash'),
                leading: Radio(
                  fillColor: MaterialStateProperty.all(Colors.green),
                  value: method.cash,
                  groupValue: _meth,
                  onChanged: (method value) {
                    setState(() {
                      _meth= value;
                    });
                  },
                ),
              ),
              ListTile(
                title: const Text('UPI and Wallet'),
                leading: Radio(
                  fillColor: MaterialStateProperty.all(Colors.green),
                  value: method.UPI,
                  groupValue: _meth,
                  onChanged: (method value) {
                    setState(() {
                      _meth= value;
                    });
                  },
                ),
              ),
            ],
          ),
          SizedBox(height: 30,),
          // Column(
          //   crossAxisAlignment: CrossAxisAlignment.start,
          //   children: [
          //     _site == BestTutorSite.Takeaway ? Text(" Take Away", style: TextStyle(fontSize: 18 ),  ) :
          //     Text(" Home Delivery" , style: TextStyle(fontSize: 18 ), ),
          //     _meth == method.cash ? Text(" Cash"  , style: TextStyle(fontSize: 18 ),) :
          //     Text(" UPI and Wallets", style: TextStyle(fontSize: 18 ), ),
          //
          //   ],
          // )
        ],
      ),
    );
  }
}
