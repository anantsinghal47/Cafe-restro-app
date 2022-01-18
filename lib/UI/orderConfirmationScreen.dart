import 'package:cafe91asm/UI/MyOrderScreen.dart';
import 'package:cafe91asm/UI/menu.dart';
import 'package:cafe91asm/provider/cart.dart';
import 'package:flutter/material.dart';

import 'package:provider/provider.dart';
import 'package:screenshot/screenshot.dart';
import 'package:share/share.dart';
import 'package:syncfusion_flutter_barcodes/barcodes.dart';

class OrderConfirmScreen extends StatefulWidget {
  final String userId;
  final BuildContext ctx;
  // ignore: non_constant_identifier_names
  final String OrderNum;
  final double orderPrice;
  final isTakeAway;
  OrderConfirmScreen(this.userId , this.ctx , this.OrderNum , this.orderPrice , this.isTakeAway);
  @override
  _OrderConfirmScreenState createState() => _OrderConfirmScreenState();
}

class _OrderConfirmScreenState extends State<OrderConfirmScreen> {

  ScreenshotController _screenshotController = ScreenshotController();
  void _takeScreenshot() async{
    final imageFile = await _screenshotController.capture();
    Share.shareFiles([imageFile.path] , text: "Your order receipt");

  }
  bool showQr = true;
  @override
  Widget build(BuildContext context) {
    final cart = Provider.of<Cart>(context);
    return Scaffold(
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      floatingActionButton:  SizedBox(
          width: MediaQuery.of(context).size.width,
          height: 55,
          child:
          ElevatedButton(
            style: ButtonStyle(backgroundColor:MaterialStateProperty.all(Colors.orange),),
            onPressed: (){
              cart.clear();
              Navigator.pushReplacement(
                  context, MaterialPageRoute(
                  builder: (ctx) => MenuScreen(
                      widget.userId, 0)
              )
              );
            }, child: Text("Back To Home" ,
            style: TextStyle(fontWeight: FontWeight.bold , fontSize: 18),) ,
          )
      ),
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        child: Container(color: Colors.white,
          child: Screenshot(

            controller: _screenshotController,
            child: Container(
              color: Colors.white,
              child: Column(

                children: [
                  SizedBox(height: 50,),
                  Row(
                    //mainAxisAlignment: ,
                    children: [
                    Padding(
                      padding: const EdgeInsets.only(left: 5),
                      child: IconButton(icon: Icon(Icons.chevron_left , color: Colors.black,), onPressed: () {
                        cart.clear();
                        Navigator.pushReplacement(widget.ctx, MaterialPageRoute(builder: (ctx) => MenuScreen(widget.userId, 0)));
                        //Navigator.pop(widget.ctx);
                      }),
                    ),
                    SizedBox(width: 20,),
                    Text("Order Confirmation" , style: TextStyle(fontSize: 22, color: Colors.black),),
                      SizedBox(width: 20),
                      Padding(
                        padding: const EdgeInsets.only(left: 30),
                        child: IconButton(icon: Icon(Icons.share_rounded , color: Colors.black,), onPressed: _takeScreenshot),
                      ),
                  ],),
                  SizedBox(height: 10,),
                  SizedBox(
                    height: 140,
                    width: 170,
                    child: Image(image: AssetImage("assets/images/confirm.jpeg"),),
                  ),
                  SizedBox(height: 20,),
                  Center(child: Text("Order id: " + widget.OrderNum , style: TextStyle(color: Colors.black54),),),

                  Card(
                    elevation: 0,
                    child: SizedBox(
                      child: Column(
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Padding(
                                padding: const EdgeInsets.all(12.0),
                                child: Text("Sub Total",style: TextStyle(  fontWeight: FontWeight.bold ),),
                              ),
                              Padding(
                                padding: const EdgeInsets.all(12.0),
                                child: Text("₹" + widget.orderPrice.toString() ,style: TextStyle(  fontWeight: FontWeight.bold , color: Colors.blueGrey),),
                              )
                            ],
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Padding(
                                padding: const EdgeInsets.all(12.0),
                                child: Text("Discounts",style: TextStyle(  fontWeight: FontWeight.bold ),),
                              ),
                              Padding(
                                padding: const EdgeInsets.all(12.0),
                                child: Text("₹" + "0" ,style: TextStyle(  fontWeight: FontWeight.bold , color: Colors.blueGrey),),
                              )
                            ],
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Padding(
                                padding: const EdgeInsets.all(12.0),
                                child: Text("Delivery Charges",style: TextStyle(  fontWeight: FontWeight.bold ),),
                              ),
                              Padding(
                                padding: const EdgeInsets.all(12.0),
                                child: !widget.isTakeAway ? Text("₹" + "40",style: TextStyle(  fontWeight: FontWeight.bold , color: Colors.blueGrey), )
                                  : Text("₹" + "0",style: TextStyle(  fontWeight: FontWeight.bold , color: Colors.blueGrey), ),
                              )
                            ],
                          ),
                          SizedBox(height: 0,),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Padding(
                                padding: const EdgeInsets.all(12.0),
                                child: Text("Total",style: TextStyle(  fontWeight: FontWeight.bold),),
                              ),
                              Padding(
                                padding: const EdgeInsets.all(12.0),
                                child: !widget.isTakeAway ? Text("₹" + ((widget.orderPrice + 40)).toString() , style: TextStyle(color: Colors.orange , fontWeight: FontWeight.bold),):
                                Text("₹" + (widget.orderPrice ).toString() , style: TextStyle(color: Colors.orange , fontWeight: FontWeight.bold),),
                              )
                            ],
                          ),
                          // SizedBox(height: 20,),
                          // SizedBox(
                          //   width: 250,
                          //     height: 45,
                          //     child:
                          //     ElevatedButton(
                          //       style: ButtonStyle(backgroundColor:MaterialStateProperty.all(Colors.blueGrey),),
                          //       onPressed: (){}, child: Text("Order Details" ,
                          //       style: TextStyle(fontWeight: FontWeight.bold , fontSize: 18),) ,
                          //       )
                          // ),
                          // SizedBox(height: 15,),
                          // TextButton(onPressed: (){
                          //   setState(() {
                          //     showQr = !showQr;
                          //   });
                          // }, child: !showQr ?  Text("Show QR CODE") : Text("Close QR CODE")),
                          // //Spacer(),
                          // showQr ?SizedBox(
                          //   height: 99,
                          //
                          //   child: SfBarcodeGenerator(
                          //     value: 'order id : 101 , payment : COD',
                          //     symbology: QRCode(),
                          //     showValue: false,
                          //   ),
                          // )   : SizedBox(height: 100,),
                          // //SizedBox(height: 10,),
                          // Spacer(),
                          // SizedBox(
                          //     width: MediaQuery.of(context).size.width,
                          //     height: 45,
                          //     child:
                          //     ElevatedButton(
                          //       style: ButtonStyle(backgroundColor:MaterialStateProperty.all(Colors.orange),),
                          //       onPressed: (){}, child: Text("Back To Home" ,
                          //       style: TextStyle(fontWeight: FontWeight.bold , fontSize: 18),) ,
                          //     )
                          // ),




                        ],
                      ),
                    ),
                  ),
                  SizedBox(height: 20,),
                  SizedBox(
                      width: 250,
                      height: 45,
                      child:
                      ElevatedButton(
                        style: ButtonStyle(backgroundColor:MaterialStateProperty.all(Colors.blueGrey),),
                        onPressed: (){
                          Navigator.push(context, MaterialPageRoute(builder: (context) => MyOrdersScreen(widget.userId)));
                        }, child: Text("Order Details" ,
                        style: TextStyle(fontWeight: FontWeight.bold , fontSize: 18),) ,
                      )
                  ),
                  SizedBox(height: 15,),
                  TextButton(onPressed: (){
                    setState(() {
                      showQr = !showQr;
                    });
                  }, child: !showQr ?  Text("Show QR CODE") : Text("Close QR CODE")),
                  //Spacer(),
                  showQr ?SizedBox(
                    height: 99,

                    child: SfBarcodeGenerator(
                      value: 'order id : ' + widget.OrderNum  + ' total: ' + widget.orderPrice.toString(),
                      symbology: QRCode(),
                      showValue: false,
                    ),
                  )   : SizedBox(height: 100,),
                  SizedBox(height: 42,),
                  //Spacer(),
                  // SizedBox(
                  //     width: MediaQuery.of(context).size.width,
                  //     height: 45,
                  //     child:
                  //     ElevatedButton(
                  //       style: ButtonStyle(backgroundColor:MaterialStateProperty.all(Colors.orange),),
                  //       onPressed: (){
                  //         Navigator.pushReplacement(
                  //         widget.ctx, MaterialPageRoute(
                  //             builder: (ctx) => MenuScreen(
                  //             widget.userId, 0)
                  //         )
                  //         );
                  //         }, child: Text("Back To Home" ,
                  //       style: TextStyle(fontWeight: FontWeight.bold , fontSize: 18),) ,
                  //     )
                  // ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
