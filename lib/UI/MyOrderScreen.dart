
import 'package:cafe91asm/provider/cart.dart';
import 'package:cafe91asm/provider/orders.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class MyOrdersScreen extends StatefulWidget {
  final String userId;
  MyOrdersScreen(this.userId);
  @override
  _MyOrdersScreenState createState() => _MyOrdersScreenState();
}

class _MyOrdersScreenState extends State<MyOrdersScreen> {

 bool fetch = false;
 List<OrderItem> ot = [];
 var lt = [];


  @override
  void initState() {
    // TODO: implement initState
    FirebaseFirestore.instance.collection("users").doc(widget.userId).collection("orders").orderBy("dateTime" , descending: true).get().then((value) async {
      //var abc =  value.docs;
      //var list = [];

      final allData = value.docs.map((doc) => doc.data()).toList();
      //print(allData);
      int i = 0 ;
      allData.forEach((element)  {


        final  pro = value.docs.map((doc) => doc.get('products')).toList();
        OrderItem oo ;


        pro.forEach((e) {
          List<CartItem> ctl = [];
          e.forEach((ele){


            CartItem ct = new CartItem(
                id: ele["id"],
                title: ele["title"],
                quantity: ele["quantity"],
                price: ele["price"],
                image: ele["image"]
            );
            ctl.add(ct);


          });

          lt.add(ctl);



        });
       DateTime dateTime = element['dateTime'].toDate();
        oo = new OrderItem(
            id: element["id"],
            orderNum: element["orderNum"],
            amount: element["amount"],
            products: lt[i],
            dateTime: dateTime
        );
        ot.add(oo);
        //print(oo);
        i++;

      });
     // print(ot);
      setState(() {
        fetch = true;
      });

    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    ot.toSet().toList();
    //print(ot.toSet().toList().length);
    return Scaffold(
      appBar: AppBar(title: Text("Recent Orders"),  backgroundColor: Colors.redAccent[100],),
      body: fetch ? ot.isEmpty ? Center(child: Text("No Orders yet!" , style: TextStyle(fontSize: 18 , color: Colors.grey[600]),),)   :Column(
        children: [
          SizedBox(height: 10,),
          Expanded(
            child: ListView.builder(
              //physics: ScrollPhysics(),
              itemCount: ot.length,
              itemBuilder: (context , i){
                return OrderListTile(
                  ot.toList()[i],
                );
              },
            ),
          ),
        ],
      ) : LinearProgressIndicator(),
    );
  }
}


class OrderListTile extends StatefulWidget {
  final OrderItem order;
  OrderListTile(this.order);

  @override
  _OrderListTileState createState() => _OrderListTileState();
}

class _OrderListTileState extends State<OrderListTile> {

  var _expanded = false;
  @override
  Widget build(BuildContext context) {
    //print(widget.order.products.length);
    return Card(
      shadowColor: Colors.redAccent,
      elevation: 1,
      margin:  EdgeInsets.all(13),
      child: Column(
        children: [

          ListTile(

            title: Text('\₹ ${widget.order.amount}'  , style:  TextStyle(color: Colors.green),),
            subtitle: Text( DateFormat('dd MMMM yy   kk:mm a'
            ).format(widget.order.dateTime) + "  , order id: " + widget.order.orderNum.toString(), style: TextStyle(),),
            trailing: Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Spacer(),
                // Container(
                //   height: 7,
                //   width: 7,
                //   decoration: BoxDecoration(
                //     borderRadius: BorderRadius.circular(100),
                //     color: Colors.green
                //   ),
                // ),
                IconButton(
                  icon : Icon(_expanded ? Icons.expand_less: Icons.expand_more),
                  onPressed: (){
                    setState(() {
                      _expanded = !_expanded;
                    });
                  },
                ),

              ],
            ),
          ),
          if(_expanded) Container(
            height: widget.order.products.length*70.0,
          //height  : min(widget.order.products.length*20.0 + 80 , 120),
           //height: widget.order.products.length*60.0 + 80,
            child: ListView(
              physics: BouncingScrollPhysics(),
              shrinkWrap: true,
              scrollDirection: Axis.vertical,
              children: widget.order.products.map((prod) =>
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(left: 10 , right: 30),
                          child: SizedBox(height: 45 , width: 55,
                           child: Image(
                             image: NetworkImage(prod.image),
                           ),
                          ),
                        ),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(prod.title , style: TextStyle(fontSize: 15 ),),
                            Text('₹' + (prod.price*prod.quantity).toString() , style: TextStyle(fontSize: 12.5 ),),
                          ],
                        ),
                        Spacer(),
                        Padding(
                          padding: const EdgeInsets.only(right: 10),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              //Text(prod.title , style: TextStyle(fontSize: 15 ),),
                              //Text( '₹'+(prod.quantity*prod.price).toString() , style: TextStyle(fontSize: 14 ),),
                              Text(   ' x ' +prod.quantity.toString() , style: TextStyle(fontSize: 15 ),),
                            ],
                          ),
                        ),
                        //  Spacer(),

                      ],),
                  )
              ).toList(),
            ),
          )
        ],
      ),
    );
  }
}

