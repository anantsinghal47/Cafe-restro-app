import 'package:cafe91asm/UI/menu.dart';
import 'package:cafe91asm/modal/category.dart';
import 'package:cafe91asm/provider/cart.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
class CategoryPage extends StatefulWidget {
  final String nameId;
  final String id;
  CategoryPage({
    @required this.nameId,
    @required this.id
  });

  @override
  _CategoryPageState createState() => _CategoryPageState();
}

class _CategoryPageState extends State<CategoryPage> {
  bool isEmpty = true;
  var nameCat = [];
  List<Category> nameCategory = [] ;
  @override
  void initState() {
    // TODO: implement initState
    /// TODO: implement initState
    FirebaseFirestore.instance.collection("allCategories").doc(widget.nameId).get().then((value) async{

      var  abc  = await value.data()[widget.nameId];
      nameCat = abc;
      // nameCat.forEach((element) {
      //
      // });
      List<dynamic> fetch =abc;
      print(fetch.length);
      int cnt = 0;
      fetch.forEach((element) {
        Map<String,dynamic> xyz = element;
        print(xyz);

        Category c = new Category(xyz["price"].toDouble(), xyz["description"], xyz["title"], xyz["id"], xyz["image_path"]);
        nameCategory.add(c);
        cnt++;
        print("**"+ cnt.toString() + "**");
      });

      print(nameCategory.length);
      setState(() {
        isEmpty = false;
      });


    }).then((value) => print("fetched"));
    super.initState();
  }
  ScrollController sc = new ScrollController();

  @override
  Widget build(BuildContext context) {
    final cart = Provider.of<Cart>(context , listen: true);
    return Scaffold(
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      floatingActionButton: cart.itemCount != 0 ? Container(
        child: Padding(
          padding: const EdgeInsets.only(left: 30),
          child: Row(
            children: [
              Text(cart.itemCount.toString() + " items in the cart"
                  ,style: TextStyle(color: Colors.white , fontSize: 17 , fontWeight: FontWeight.bold),
              ),
              SizedBox(width: 60,),
              Row(
                children: [

                  // IconButton( iconSize: 19,  icon: Icon(Icons.shopping_bag_outlined , color: Colors.white,), onPressed: (){
                  //   Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => MenuScreen(widget.id, 2)));
                  //
                  // }),
                  TextButton(
                    onPressed: (){
                      Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => MenuScreen(widget.id, 2)));

                    },
                    child: Text("View Cart"
                      ,style: TextStyle(color: Colors.white , fontSize: 16 , fontWeight: FontWeight.bold),
                    ),
                  ),
                ],
              )
            ],
          ),

        ),
        //padding: EdgeInsets.only(bottom: 10),
        margin: EdgeInsets.only(bottom: 0),
        height: 50,
        width: MediaQuery.of(context).size.width,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(0),
          color: Colors.red[300]
        ),
        // /color: Colors.redAccent,
      ) : Container(),
      appBar: AppBar(backgroundColor: Colors.red[300], title: Text(widget.nameId),),
      body: Scrollbar(

        thickness: 7,
        //isAlwaysShown: true,
        showTrackOnHover: true,
        controller: sc,
        child: SingleChildScrollView(
          controller: sc,
          child: Column(
            children: [

              //SizedBox(height: 10,),
              !isEmpty ?ListView.builder(
                physics: BouncingScrollPhysics(),
                shrinkWrap: true,
                  itemCount: nameCategory.length,
                  itemBuilder:  (context , index)
                  {
                    return Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 5),
                      child: SizedBox(
                        height: 220,
                        child: Card(
                          child: Row(
                            children: [

                              //Spacer(),

                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [

                                  SizedBox(height: 12,),
                                  Padding(
                                    padding: const EdgeInsets.only(top:  15 , left: 15 , bottom: 5),
                                    child: Text(nameCategory[index].title , style: TextStyle(fontSize:  20),)
                                  ),
                                  Padding(
                                      padding: const EdgeInsets.only( left: 15 ),

                                      child:SizedBox(
                                        width: 170,
                                        child: TextField(
                                          readOnly: true,

                                          decoration: InputDecoration(
                                              border: InputBorder.none,
                                            enabled: false,
                                            hintStyle: TextStyle(fontSize: 13 , fontWeight: FontWeight.bold),
                                            hintText: nameCategory[index].description,
                                            hintMaxLines: 2
                                          ),
                                        ),
                                      )

                                  ),
                                  Spacer(),
                                  Column(
                                    children: [
                                      Row(
                                        children: [
                                          Padding(
                                            padding: const EdgeInsets.only(left: 15 , top: 5 , bottom: 17),
                                            child: Card(
                                              elevation: 5,
                                              shape: RoundedRectangleBorder(
                                                borderRadius: BorderRadius. circular(20),
                                              ),
                                              child: InkWell(
                                                onTap: (){
                                                  cart.addItem(
                                                      nameCategory[index].id,
                                                      nameCategory[index].title,
                                                      nameCategory[index].price,
                                                      1 ,
                                                      nameCategory[index].image_path
                                                  );




                                                },

                                                child: Container(
                                                  height: 30,
                                                  width: 100,
                                                  decoration: BoxDecoration(
                                                      borderRadius: BorderRadius.circular(20),
                                                      //border: Border.all(color: Color(0xffFFF1AE81) , width: 3 ,),
                                                      gradient: LinearGradient(
                                                        //Color(0xffFFF1AE81) , Color(0xffFFF1AE81),
                                                          colors: [Colors.white , Color(0xff8AD4BEBE)]
                                                        //, Color(0xffFF99A6A8)
                                                      )
                                                  ),
                                                  child: Row(
                                                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                                    children: [
                                                      Center(child: Text("Add ", style: TextStyle(color: Colors.black54 , fontWeight: FontWeight.bold, fontSize: 15),)),
                                                      Icon(Icons.shopping_bag_outlined , color:  Colors.black54 , size: 15, )
                                                    ],
                                                  ),
                                                ),

                                              ),
                                            ),
                                          ),

                                        ],
                                      ),

                                    ],
                                  ),
                                  SizedBox(height: 0,),

                                  // Container(
                                  //
                                  //   decoration: BoxDecoration(
                                  //     color:  Colors.redAccent,
                                  //     borderRadius: BorderRadius.circular(30),
                                  //   ),
                                  //   height: 30,
                                  //   width: 80,
                                  //   child: Center(child: Row(
                                  //     mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                  //     children: [
                                  //       Text(" Add" , style: TextStyle(color: Colors.white , fontWeight: FontWeight.bold),),
                                  //       Icon(Icons.shopping_bag_outlined , color:  Colors.white , size: 15, )
                                  //     ],
                                  //   )),
                                  //
                                  // )



                                ],
                              ),
                              SizedBox(width: 0,),
                              Spacer(),
                              Container(
                                margin: EdgeInsets.only(right: 30 , top: 5 ,bottom: 0),
                                child: Column(
                                  children: [
                                    // SizedBox(
                                    //   height : 100,
                                    //   width: 110,
                                    //   child: Image( image : NetworkImage(nameCategory[index].image_path)),
                                    // ),
                                    SizedBox(height: 17,),
                                    Container(

                                      decoration: BoxDecoration(
                                        color:  Colors.red[400],
                                        borderRadius: BorderRadius.circular(30),
                                      ),
                                      height: 30,
                                      width: 80,
                                      child: Center(child: Row(
                                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                        children: [
                                          Text("₹ "+nameCategory[index].price.toInt().toString() , style: TextStyle(color: Colors.white , fontWeight: FontWeight.bold , fontSize: 17),),

                                        ],
                                      )),

                                    ),
                                    SizedBox(height: 5,),
                                    SizedBox(
                                      height : 100,
                                      width: 110,
                                      child: Image( image : NetworkImage(nameCategory[index].image_path)),
                                    ),

                                    cart.items.containsKey(nameCategory[index].id) ? Padding(
                                      padding: const EdgeInsets.only(left:  8 , top: 5),
                                      child: SizedBox(
                                        height: 25,
                                        width: 90,
                                        child: Row(
                                          children: [
                                            Container(

                                              //padding: const EdgeInsets.only( bottom: 10),
                                                height: 30,
                                                width: 25,

                                                decoration : BoxDecoration(
                                                    color: Color(0xffFFFF7371),
                                                    borderRadius: BorderRadius.only(topLeft: Radius.circular(20)  , bottomLeft:Radius.circular(20) )
                                                ),
                                                child:Container(
                                                  //padding: const EdgeInsets.only(bottom: 40 , right: 0 , top: 0),
                                                  //margin: const EdgeInsets.only(bottom: 10 , right: 0, top: 0),
                                                  child: IconButton(
                                                    padding: EdgeInsets.only(bottom: 0 , right: 0 , top: 0),
                                                    //alignment: Alignment.centerRight,

                                                    onPressed: (){
                                                      if(cart.items[nameCategory[index].id].quantity > 1) {
                                                        cart.addItem(nameCategory[index].id, nameCategory[index].title, nameCategory[index].price, -1, nameCategory[index].image_path);
                                                      }
                                                      else{
                                                        cart.removeItem(nameCategory[index].id);
                                                      }


                                                    },
                                                    icon : Icon(Icons.remove, color: Colors.white,),iconSize: 17, color: Colors.white,),
                                                )
                                            ),
                                            Container(
                                                decoration: BoxDecoration(
                                                    border: Border.all( color: Color(0xffFFFF7371),)
                                                ),
                                                height: 25,
                                                width: 30,
                                                child: Center(child: Text(cart.items[nameCategory[index].id].quantity.toString() , style: TextStyle(fontWeight: FontWeight.bold , color: Colors.black54),))
                                            ),
                                            Container(
                                                height: 30,
                                                width: 25,
                                                decoration : BoxDecoration(
                                                    color: Color(0xffFFFF7371),
                                                    borderRadius: BorderRadius.only(topRight: Radius.circular(20)  , bottomRight:Radius.circular(20) )
                                                ),
                                                child:IconButton(
                                                  padding: EdgeInsets.only(bottom: 0 , right: 0 , top: 0),
                                                  icon : Icon(Icons.add , color: Colors.white,),
                                                  iconSize: 17 , color: Colors.white,
                                                  onPressed: (){
                                                    cart.addItem(nameCategory[index].id, nameCategory[index].title, nameCategory[index].price, 1, nameCategory[index].image_path);
                                                    //cart.addItem(id, title, price, 1, image);
                                                  },
                                                )
                                            ),
                                          ],
                                        ),
                                      ),
                                      // child: SizedBox(
                                      //   height: 40,
                                      //   width: 90,
                                      //   child: Row(
                                      //     children: [
                                      //       Container(
                                      //           decoration : BoxDecoration(
                                      //               color: Colors.redAccent,
                                      //               borderRadius: BorderRadius.only(topLeft: Radius.circular(20)  , bottomLeft:Radius.circular(20) )
                                      //           ),
                                      //           //padding: const EdgeInsets.only(right: 10 , bottom: 5),
                                      //           height: 30,
                                      //           width: 30,
                                      //
                                      //
                                      //           child:IconButton(
                                      //             onPressed: (){
                                      //               if(cart.items[nameCategory[index].id].quantity > 1) {
                                      //                 cart.addItem(nameCategory[index].id, nameCategory[index].title, nameCategory[index].price, -1, nameCategory[index].image_path);
                                      //               }
                                      //               else{
                                      //                 cart.removeItem(nameCategory[index].id);
                                      //               }
                                      //             },
                                      //
                                      //             icon : Icon(Icons.remove , color: Colors.white,),iconSize: 17, color: Colors.white,)
                                      //       ),
                                      //       Container(
                                      //           decoration: BoxDecoration(
                                      //               border: Border.all(color: Colors.redAccent)
                                      //           ),
                                      //           height: 29,
                                      //           width: 30,
                                      //           child: Center(child: Text(cart.items.containsKey(nameCategory[index].id) ? cart.items[nameCategory[index].id].quantity.toString() : "0"))
                                      //       ),
                                      //       Container(
                                      //           height: 30,
                                      //           width: 30,
                                      //           decoration : BoxDecoration(
                                      //               color: Colors.redAccent,
                                      //               borderRadius: BorderRadius.only(topRight: Radius.circular(20)  , bottomRight:Radius.circular(20) )
                                      //           ),
                                      //           child:IconButton(
                                      //             icon : Icon(Icons.add , color: Colors.white,),
                                      //             iconSize: 17 , color: Colors.white,
                                      //             onPressed: (){
                                      //
                                      //
                                      //               cart.addItem(nameCategory[index].id, nameCategory[index].title, nameCategory[index].price, 1, nameCategory[index].image_path);
                                      //             },
                                      //             // onPressed: (){
                                      //             //   if(cart.items[nameCategory[index].id].quantity > 1) {
                                      //             //     cart.addItem(nameCategory[index].id, nameCategory[index].title, nameCategory[index].price, -1, nameCategory[index].image_path);
                                      //             //   }
                                      //             //   else{
                                      //             //     cart.removeItem(nameCategory[index].id);
                                      //             //   }
                                      //             // },
                                      //           )
                                      //       ),
                                      //     ],
                                      //   ),
                                      // ),
                                    ) : Container(height: 40,)
                                  ],
                                ),
                              ),
                              // Padding(
                              //   padding: const EdgeInsets.only(right: 1),
                              //   child: SizedBox(height: 120, width: 8, child: Container(
                              //     decoration: BoxDecoration(
                              //       borderRadius: BorderRadius.circular(10),
                              //       color: Colors.redAccent,
                              //     ),
                              //   ),),
                              // ),

                            ],
                          ),

                        ),
                      ),
                    );
                  }
              ):
                  LinearProgressIndicator(
                      backgroundColor: Colors.redAccent,
                      valueColor: AlwaysStoppedAnimation<Color>(Colors.white)
                  ),
              SizedBox(
                height: 40,
                child: Container(color: Colors.white,),
              )



            ],
          ),
        ),
      ),
    ) ;
  }
}
