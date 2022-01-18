
import 'package:cafe91asm/DB/auth.dart';
import 'package:cafe91asm/DB/sharedPreferences.dart';
import 'package:cafe91asm/UI/CategoryPage.dart';
import 'package:cafe91asm/UI/ProceedToPay.dart';
import 'package:cafe91asm/UI/Registration.dart';
import 'package:cafe91asm/UI/addressScreen.dart';
import 'package:cafe91asm/modal/product.dart';
import 'package:cafe91asm/provider/cart.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:provider/provider.dart';

import '../custom_navigation_bar.dart';
import 'MyOrderScreen.dart';

class MenuScreen extends StatefulWidget {
  static const routeName = '/cart';


 final  int index;
  final String userId ;
  MenuScreen(this.userId , this.index);
  @override
  _MenuScreenState createState() => _MenuScreenState();
}

class _MenuScreenState extends State<MenuScreen> {
  String name = "";
  String email = "";
  String mob = "";
  List<String> address = [];

  int _currentIndex ;
  final _inactiveColor = Colors.grey;
  bool isLogout = false;


   Widget getBody() {


    List<Widget> pages = [
      isLoad ? Center(child: LinearProgressIndicator()) :Column(
        children: [
          SizedBox(height: 20,),
          Row(
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 10),
                child: Icon(Icons.home_outlined ,  size: 36,),
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text("Home" , style: TextStyle(fontWeight:  FontWeight.bold , fontSize: 17 ),),
                  address.isNotEmpty ? Text( address[0],style: TextStyle(fontWeight:  FontWeight.bold , fontSize: 13, color: Color(0xffB2B2B2)), ):
                  Text( "",style: TextStyle(fontWeight:  FontWeight.bold , fontSize: 13, color: Color(0xffB2B2B2)), ),

                ],

              ),
              Spacer(),
              Container(
                margin: EdgeInsets.only(right:  5),
                child: IconButton(
                    icon: Icon(Icons.logout), onPressed: (){

                      _showMyDialog(context);


                }),
              )

            ],
          ),
          SizedBox(height: 10,),
          Row(
            children: [
              Container(

                decoration: BoxDecoration(
                    color : Color(0xffF4F4F4),
                    borderRadius: BorderRadius.circular(10)
                ),

                margin : EdgeInsets.only(  left: 20, right: 20),
                padding: EdgeInsets.only( left : 30 ),
                child: SizedBox(

                  height: 49,
                  width: 230,
                  child: Row(
                    children: [
                      Padding(
                          padding: const EdgeInsets.only(bottom:0.0 , right: 10),
                          child: Icon(Icons.search_rounded)
                      ),
                      Flexible(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            TextFormField(

                              //controller:,
                              decoration: InputDecoration(
                                //focusColor: Colors.grey,
                                //hoverColor: Colors.grey,
                                  focusedBorder: InputBorder.none,
                                  enabledBorder: InputBorder.none,
                                  hintText: "Search food ",
                                  hintStyle: TextStyle(color: Colors.black54 , fontWeight: FontWeight.bold , fontSize: 18)
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              Card(
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10)
                ),
                child: IconButton(icon: FaIcon(FontAwesomeIcons.filter , color: Colors.green[300],), onPressed: (){},iconSize: 15,),
              ),

            ],
          ),
          SizedBox(height: 30),
          Padding(
            padding: const EdgeInsets.only(left: 38),
            child: Container(
              child: Row(
                children: [
                  Text("Quick add" , style: TextStyle(fontWeight: FontWeight.bold ),),
                  Icon(Icons.keyboard_arrow_right)
                ],
              ),
            ),
          ),
          isEmptyQuickAdd ? Container(
            //height: 50,
            child: Center(
              child: SizedBox(
                height: 10,
                width: 10,
                child: CircularProgressIndicator(
                  backgroundColor: Colors.redAccent,
                  valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
                ),
              ),
            ),
          ) :
          Container(
            height: 230,
            child: ListView.builder(
              scrollDirection: Axis.horizontal,
              shrinkWrap:  true,
              physics: ScrollPhysics(),
              itemCount: namesItem.length,
              itemBuilder: (context , index){
                return Container(
                  height: 200,
                  padding: EdgeInsets.only(left: 20 , right:30 ),
                  child: Container(

                    height: 300,
                    width: 320,
                    child: Column(
                      //mainAxisSize: MainAxisSize.max,
                      children: [
                        Stack(
                          children: [
                            Container(
                              height: 220,
                            ),
                            Positioned(
                              top: 15,
                              child: Container(
                                padding: EdgeInsets.only(left: 10 , right: 10),
                                height: 160,
                                width: 320,
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(30),
                                    gradient: LinearGradient(
                                      // Color(0xffFFF1AE81)
                                      // Color(0xffFF341006)
                                      //Colors.brown,Color(0xffFF341006)
                                        colors: [  Colors.redAccent[100] , Colors.redAccent[200]]
                                      //, Color(0xffFF99A6A8)
                                    )
                                ),
                                child: Padding(
                                  padding: const EdgeInsets.only( top: 10),
                                  child: Column(

                                    children: [
                                      Padding(
                                        padding: const EdgeInsets.symmetric(horizontal: 10 , ),
                                        child: Row(children: [
                                          SizedBox(width: 3,),
                                          Expanded(
                                              child: Text(
                                                  namesItem[index].title , style: TextStyle(
                                                  fontWeight: FontWeight.bold ,
                                                  fontSize: 22 , color: Colors.white)
                                              )
                                          ),
                                          SizedBox(width: 0,),
                                          Container(
                                            height: 40,
                                            width: 40,
                                            decoration: BoxDecoration(
                                              borderRadius: BorderRadius.circular(100),
                                              //border: Border.all(color: Colors.grey),
                                              color: Colors.white54,
                                            ),
                                            child: IconButton(
                                              icon: Icon(Icons.favorite , color: namesItem[index].isFav ?   Colors.red[400] : Colors.white54),
                                              onPressed: (){

                                              },
                                            ),
                                          )
                                          //SizedBox(height: 10,),
                                        ],
                                        ),
                                      ),

                                      Padding(
                                        padding: const EdgeInsets.symmetric(horizontal: 0),
                                        child: Column(
                                          children: [
                                            Padding(
                                              padding: const EdgeInsets.only(left: 10 , top: 5),
                                              child: Row(children: [
                                                Text(namesItem[index].description, style: TextStyle(fontWeight: FontWeight.bold , fontSize: 16 , color: Colors.white)),
                                              ],),
                                            ),
                                            SizedBox(height: 10,),
                                            Row(children: [
                                              Padding(
                                                padding: const EdgeInsets.only(left: 10),
                                                child: Text("\₹ ${namesItem[index].price.toInt().toString()}", style: TextStyle(fontWeight: FontWeight.bold , fontSize: 20 , color: Colors.white)),
                                              ),
                                              Spacer(),
                                            ],
                                            ),
                                          ],
                                        ),
                                      )
                                    ],
                                  ),
                                ),
                              ),
                            ),
                            Positioned(
                              left: 190,
                              top: 120,
                              child: Container(
                                //padding: EdgeInsets.all(0.5),
                                height: 75,
                                width: 100,
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.only(topRight: Radius.circular(20) , bottomLeft:Radius.circular(20) , topLeft: Radius.circular(20), bottomRight: Radius.circular(20)),
                                    color: Colors.white,
                                    //Color(0xffFFF1AE81)
                                    border: Border.all(color: Colors.red[300] , width: 1 ,)
                                ),
                                child: Container(
                                  decoration: BoxDecoration(
                                    image: DecorationImage(
                                      fit: BoxFit.cover,
                                      image: NetworkImage(namesItem[index].imgPath)
                                    ),
                                    borderRadius: BorderRadius.circular(19)
                                  ),

                                )
                              ),
                            ),
                            20> 0 ? Positioned(
                              top: 150,
                              left: 40,
                              child: Card(
                                elevation: 5,
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius. circular(20),
                                ),
                                child: InkWell(
                                  onTap: (){
                                    final cart = Provider.of<Cart>(context , listen: false);
                                    cart.addItem(namesItem[index].id, namesItem[index].title, namesItem[index].price, 1 , namesItem[index].imgPath);
                                    Future.delayed(Duration(milliseconds: 10)).then((_) {
                                      final snackBar = SnackBar(
                                        backgroundColor: Colors.redAccent,
                                        content: Text(namesItem[index].title  + " added to cart!" , style:  TextStyle(color: Colors.white , fontSize: 14), ),
                                        duration: Duration(milliseconds: 200),
                                      );
                                      // ignore: deprecated_member_use
                                      Scaffold.of(context).showSnackBar(snackBar);
                                    } );

                                    // ignore: deprecated_member_use
                                    Scaffold.of(context).hideCurrentSnackBar();




                                  },

                                  child: Container(
                                    height: 40,
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
                                    child: Center(child: Text("Add", style: TextStyle(color: Colors.black54 , fontWeight: FontWeight.bold, fontSize: 18),)),
                                  ),
                                ),
                              ),
                            ) : Container(),
                          ],
                        ),
                      ],
                    ),

                  ),
                );
              },
            )
          ),
          isEmptyQuickAdd ? SizedBox(height: 120,):
          Container(
              padding : EdgeInsets.symmetric(horizontal: 100, vertical: 0),
              child: Text(" Swipe for great servings" , style: TextStyle(fontSize: 12),
              )
          ),
          SizedBox(height: 25,),
          Row(
            children: [
              Container( padding : EdgeInsets.only(left: 30, top: 0 , right: 5),
                  child: Text("Food catalogue" ,
                    style: TextStyle(fontSize: 17,fontWeight: FontWeight.bold),
                  )
              ),
              Icon(Icons.keyboard_arrow_right)
            ],
          ),
          SizedBox(height: 10,),
          isEmptyCat ? Padding(
            padding: const EdgeInsets.only(top:200),
            child: Center(child: CircularProgressIndicator(
              backgroundColor: Colors.redAccent, valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
            )),
          ) : Container(
            child: GridView.builder(
              itemCount: categories.length,
              shrinkWrap: true,
              physics: ScrollPhysics(),
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                      childAspectRatio: 1.12,
                    crossAxisCount: 2,
                    crossAxisSpacing: 15.0,
                    mainAxisSpacing: 0.0,
                  //childAspectRatio:

                ),
              itemBuilder: (BuildContext context, int index){
                return GestureDetector(
                  onTap: (){
                    Navigator.push(context, MaterialPageRoute(builder: (context) => CategoryPage(nameId: categories[index].name , id : widget.userId)));
                  },
                  child: Padding(
                    padding: const EdgeInsets.only(left: 15 , right: 15 , top: 10 , bottom: 10),
                    child: Card(
                     // color: Color(0xffFFFFEBEB),
                     //color: Color(0xffFFFFEEEE),
                      //color: Colors.redAccent,
                      //shadowColor: Colors.redAccent[100],
                      elevation: 0.8,
                      shape: RoundedRectangleBorder(
                        side: BorderSide(color: Color(0xffFFFF8A80 )  , width:  0.5),
                        borderRadius: BorderRadius.circular(20)
                      ),
                      child: Column(
                        children: [
                          SizedBox(
                            height : 100,
                            child: Container(
                             margin: EdgeInsets.symmetric(horizontal: 10 , vertical: 0
                              ),
                              decoration: BoxDecoration(

                                borderRadius: BorderRadius.circular(30)
                              ),
                                child: Padding(
                                  padding: const EdgeInsets.only(left:  8 , right:  8 , top: 3),
                                  child: Image.network( categories[index].image , fit: BoxFit.contain,),
                                )
                            ),
                          ),

                          Padding(
                            padding: const EdgeInsets.only(bottom: 0 , top: 0),
                            child: Text(categories[index].name , style: TextStyle(fontSize: 18 ,  color: Colors.brown , fontWeight: FontWeight.bold),),
                          )
                        ],
                      ),
                    ),
                  ),
                );
              },
            ),
          )


        ],
      ),
     Column(
       children: [
         SizedBox(
           height: MediaQuery.of(context).size.height,
             child: MyOrdersScreen(widget.userId)),
       ],
     ),
      cart(context),
      // Column(
      //   children: [
      //     CartScreen()
      //   ],
      // ),
      Container(
        color: Colors.grey[200],
        alignment: Alignment.center,
        child: SingleChildScrollView(

          child: profile(widget.userId)
        ),
      ),
    ];
    return IndexedStack(
      index: _currentIndex,
      children: pages,
    );
  }
  Widget _buildBottomBar(){
    final cart1 = Provider.of<Cart>(context);
    return CustomAnimatedBottomBar(
      containerHeight: _currentIndex == 2 && cart1.itemCount > 0 ? 0 : 50,
      backgroundColor: Colors.white,
      selectedIndex: _currentIndex,
      showElevation: true,
      itemCornerRadius: 24,
      curve: Curves.easeIn,
      onItemSelected: (index) => setState(() => _currentIndex = index),
      items: <BottomNavyBarItem>[
        BottomNavyBarItem(
          icon: Icon(Icons.home_filled),
          title: Text('Home'),
          activeColor: Color(0xffFF6838),
          inactiveColor: _inactiveColor,
          textAlign: TextAlign.center,
        ),
        BottomNavyBarItem(
          icon: Icon(Icons.fastfood),
          title: Text('Orders'),
          activeColor: Color(0xffFF6838),
          inactiveColor: _inactiveColor,
          textAlign: TextAlign.center,
        ),
        BottomNavyBarItem(

          title: Text(
            'Cart',
          ),
          activeColor: Color(0xffFF6838),
          inactiveColor: _inactiveColor,
          textAlign: TextAlign.center,
          icon:Consumer<Cart>(builder: (_ , cart , ch) => Badge(
            child: ch,
            value: cart.itemCount.toString(),

          ),
              child: Icon(Icons.shopping_bag_outlined  )
          ),
        ),
        BottomNavyBarItem(
          icon: Icon(Icons.person_outline_rounded),
          title: Text('Account'),
          activeColor: Color(0xffFF6838),
          inactiveColor: _inactiveColor,
          textAlign: TextAlign.center,
        ),
      ],
    );
  }
  List<Product> namesItem = [];
  static var allNames = [];

  List<Category> categories = [];
  static var allCategories = [];
  bool isEmptyQuickAdd = true;
  bool isEmptyCat = true;
  bool isLoad = true;
  @override
  void initState()  {

    // TODO: implement initState
    _currentIndex = widget.index;
    allCategories.clear();
    categories.clear();
    allNames.clear();
    namesItem.clear();
    print(widget.userId);
    FirebaseFirestore.instance.collection("menu").doc("bestseller").get().then((value) async{
      var  abcd  = await value.data()["bestfood"];
      allNames = abcd;

      allNames.forEach((element) async {
        Map<String, dynamic> data = element;
        Product p1 = new Product(
            id: data["id"] ,
            title: data["title"] ,
            category: data["category"] ,
            description: data["description"],
            imgPath: data["image_path"],
            price: data["price"].toDouble(),
            isFav: data["isFav"]
        );
        namesItem.add(p1);

      });
      //namesItem.sort();
        // 5 seconds over, navigate to Page2.



    }).then((value){
      setState(() {
        isEmptyQuickAdd = false;
      });
    });
    FirebaseFirestore.instance.collection("menu").doc("category").get().then((value) async{
      var  abcd  = await value.data()["catArray"];
      allCategories = abcd;

      allCategories.forEach((element) async {
        Map<String, dynamic> data = element;
        Category p1 = new Category(
            name: data["name"] ,
            image: data["image"] ,

        );
        categories.add(p1);

      });
      //namesItem.sort();


    }).then((value){
      setState(() {
        isEmptyCat = false;
      });
    });
    FirebaseFirestore.instance.collection("users").doc(widget.userId).get().then((value) async{
       name = await value.data()["name"];
      email = await value.data()["email"];
      mob = await value.data()["mobile num"];
       var  abcd  = await value.data()["address"];
       try{

         List<String> strings = List<String>.from(abcd);
         address = strings;
       }
       catch(e)
       {
         e.toString();
       }

      setState(() {
        isLoad = false;
      });
    });

    super.initState();


    super.initState();





  }
  // ignore: non_constant_identifier_names
  DateTime pre_backpress = DateTime.now();
  @override
  Widget build(BuildContext context) {
    final cartProv = Provider.of<Cart>(context);
    return WillPopScope(
      onWillPop: () async{

        final timegap = DateTime.now().difference(pre_backpress);
        final cantExit = timegap >= Duration(seconds: 2);
        pre_backpress = DateTime.now();
        if(cantExit){
          //show snackbar

          final snack = SnackBar(content: Text('Press Back button again to Exit App'),duration: Duration(seconds: 2),backgroundColor: Colors.redAccent,);
          ScaffoldMessenger.of(context).showSnackBar(snack);
          return false; // false will do nothing when back press
        }else{
          return true;   // true will exit the app
        }
      },
      child: Scaffold(
        floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
        floatingActionButton: _currentIndex == 2 && cartProv.itemCount != 0 ?
        Container(
          height: 60,
          padding: const EdgeInsets.only(top:8.0 , bottom: 0) ,
          margin: const EdgeInsets.only(bottom: 0),
          child: Container(
            decoration: BoxDecoration(
              //borderRadius: BorderRadius.circular(20),
              color: Colors.red[300],
            ),

            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Text("Proceed to pay" ,
                  style: TextStyle(color: Colors.white , fontSize: 18 , fontWeight: FontWeight.bold),),
                IconButton(icon: Icon(Icons.payment_outlined , color: Colors.white,), onPressed: (){}),
                Text(
                    "₹"+cartProv.totalPrice.toString(),
                  style: TextStyle(color: Colors.white , fontSize: 18 , fontWeight: FontWeight.bold),

                ),
                IconButton(icon: Icon(Icons.keyboard_arrow_right , color: Colors.white,), onPressed: (){
                 // final orders = Provider.of<Orders>(context ,listen: false);
                  DateTime dt = DateTime.now();
                  //int ON = 0;

                  //orders.addOrder(cartProv.items.values.toList(), cartProv.totalPrice ,dt.toString() , ON , dt);
                  if(address.isNotEmpty)
                    {
                      print(address);
                      Navigator.push(context, MaterialPageRoute(builder: (context) => ProceedToPay(cartProv.totalPrice , dt ,widget.userId , address[0])));
                    }
                  else{
                    Navigator.push(context, MaterialPageRoute(builder: (context) => AddressScreen(widget.userId)));

                  }


                })
              ],
            ),
          ),
        )
            : Container(),
        appBar: _currentIndex != 2 && _currentIndex != 1? AppBar(toolbarHeight: 0.2, backgroundColor:  Colors.grey[200],) :
        _currentIndex != 1?  AppBar(backgroundColor: Colors.red[300], title: Text("Your Cart"), centerTitle: true,
           leading:  cartProv.itemCount == 0 ? Container() :   IconButton(icon: Icon(Icons.arrow_back_rounded , color: Colors.white,),onPressed: (){
             Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => MenuScreen(widget.userId, 0)));
           }, ),) : AppBar(toolbarHeight: 0, backgroundColor: Colors.red[300],),
      backgroundColor: Colors.white,
        bottomNavigationBar: _buildBottomBar(),
        body: RefreshIndicator(
          onRefresh: () async{
            await Future.delayed(Duration(seconds:  1));


            return initState();


          },
          child: SingleChildScrollView(
            physics: BouncingScrollPhysics(),
            scrollDirection: Axis.vertical,
            child: getBody()
          ),
        ) ,
      ),
    );
  }

}
// ignore: camel_case_types
class profile extends StatefulWidget {
  final String userId ;
  profile(this.userId);
  @override
  _profileState createState() => _profileState();
}

// ignore: camel_case_types
class _profileState extends State<profile> {

  bool isLoad = true;
  String name;
  String mob ;
  String email;

  List<String> address= [];
  void initState()  {

    // TODO: implement initState
    print(widget.userId);
    FirebaseFirestore.instance.collection("users").doc(widget.userId).get().then((value) async{
      name = await value.data()["name"];
      email = await value.data()["email"];
      mob = await value.data()["mobile num"];
      //address = await value.data()["address"];
      var  abcd  = await value.data()["address"];
      try{

        List<String> strings = List<String>.from(abcd);
        address = strings;
      }
      catch(e)
      {
        e.toString();
      }
      setState(() {
        isLoad = false;
      });
    });
    super.initState();


  }



  @override
  Widget build(BuildContext context) {
    return !isLoad ? Column(

      children: [
        SizedBox(height: 40,),
        Row(
          children: [
            Padding(
              padding: const EdgeInsets.only(left: 40),
              child: Text("Personal details", style: TextStyle(fontWeight: FontWeight.bold , fontSize: 18),),
            ),
            Spacer(),
            Padding(
              padding: const EdgeInsets.only(right: 40),
              child: Text("Edit" , style: TextStyle(color:  Color(0xffFA4A0C) , fontSize: 16), ),
            )
          ],
        ),
        SizedBox(height: 5,),
        Container(
          margin: const EdgeInsets.only(left: 17 , right: 17),
          child: SizedBox(
              width: 390,
              height: 155,
              child: Card(
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20)
                ),
                child: Row(
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(left: 28 , right: 20),
                      child: SizedBox(
                        width: 90,
                        height: 90,
                        child: Container(
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(30),
                            color: Colors.grey[200],
                          ),
                           child: Image(image: AssetImage("assets/images/stack.jpeg" ), ),
                        ),
                      ),
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        SizedBox(height: 40,),
                        Container(
                          padding: const EdgeInsets.only(bottom: 8),

                          child: Text(name ,style: TextStyle(fontWeight: FontWeight.bold , fontSize: 18),),
                        ),
                        Text(  email,style: TextStyle(fontWeight: FontWeight.w600 , fontSize: 12),),

                        address.isNotEmpty ? Text( address[0],style: TextStyle(fontWeight: FontWeight.w600 , fontSize: 11),):
                        Text( " ",style: TextStyle(fontWeight: FontWeight.w600 , fontSize: 11),),
                        Text( "+91 "+mob ,style: TextStyle(fontWeight: FontWeight.w600 , fontSize: 11),),
                      ],
                    ),
                  ],
                ),
              )
          ),
        ),
        SizedBox(height: 25,),
        Column(
          children: [
            Container(
              padding: const EdgeInsets.only(bottom: 15),
              margin: const EdgeInsets.only(left: 20 , right: 20),
              child: Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(20),
                  color: Colors.white,
                ),

                width: 350,
                height: 50,
                child: Row(
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(left: 20),
                      child: Text("My Orders" , style: TextStyle(fontWeight: FontWeight.bold , fontSize: 18),),
                    ),
                    Spacer(),
                    IconButton(icon: Icon(Icons.keyboard_arrow_right), onPressed:(){
                      Navigator.push(context, MaterialPageRoute(builder: (context) => MyOrdersScreen(widget.userId )));
                    }),
                    SizedBox(width: 10,)
                  ],
                ),
              ),
            ),
            Container(
              padding: const EdgeInsets.only(bottom: 15),
              margin: const EdgeInsets.only(left: 20 , right: 20),
              child: Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(20),
                  color: Colors.white,
                ),

                width: 350,
                height: 50,
                child: Row(
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(left: 20),
                      child: Text("My Addresses" , style: TextStyle(fontWeight: FontWeight.bold , fontSize: 18),),
                    ),
                    Spacer(),
                    IconButton(icon: Icon(Icons.keyboard_arrow_right), onPressed:(){
                      Navigator.push(context, MaterialPageRoute(builder: (context) => AddressScreen(widget.userId )));
                    }),
                    SizedBox(width: 10,)
                  ],
                ),
              ),
            ),
            Container(
              padding: const EdgeInsets.only(bottom: 15),
              margin: const EdgeInsets.only(left: 20 , right: 20),
              child: Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(20),
                  color: Colors.white,
                ),

                width: 350,
                height: 50,
                child: Row(
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(left: 20),
                      child: Text("My Favourites" , style: TextStyle(fontWeight: FontWeight.bold , fontSize: 18),),
                    ),
                    Spacer(),
                    IconButton(icon: Icon(Icons.keyboard_arrow_right), onPressed:(){}),
                    SizedBox(width: 10,)
                  ],
                ),
              ),
            ),
            Container(
              padding: const EdgeInsets.only(bottom: 15),
              margin: const EdgeInsets.only(left: 20 , right: 20),
              child: Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(20),
                  color: Colors.white,
                ),

                width: 350,
                height: 50,
                child: Row(
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(left: 20),
                      child: Text("Help" , style: TextStyle(fontWeight: FontWeight.bold , fontSize: 18),),
                    ),
                    Spacer(),
                    IconButton(icon: Icon(Icons.keyboard_arrow_right), onPressed:(){}),
                    SizedBox(width: 10,)
                  ],
                ),
              ),
            ),

            SizedBox(height: 0,),

          ],

        ),
        Row(
          children: [
            SizedBox(width: 30,),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: const EdgeInsets.only(left: 2 , right:  8 , top:  0 , bottom: 0),
                  child: TextButton(child: Text(
                      "Send feedback"
    , style: TextStyle(color: Colors.black),) ,
                    onPressed: (){},
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 2 , right:  8 , top:  0 , bottom: 0),
                  child: TextButton(child: Text("Report an emergency" , style: TextStyle(color: Colors.black),) , onPressed: (){},),
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 2 , right:  8 , top:  0 , bottom: 0),
                  child: TextButton(child: Text("Rate us on play store", style: TextStyle(color: Colors.black),) , onPressed: (){},),
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 2 , right:  8 , top:  0 , bottom: 0),
                  child: TextButton(child: Text("About us", style: TextStyle(color: Colors.black),) , onPressed: (){},),
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 2 , right:  8 , top:  0 , bottom: 0),
                  child: TextButton(child: Text("Log out", style: TextStyle(color: Colors.orange),) , onPressed: (){
                    _showMyDialog(context);
                  },),
                ),

              ],
            ),
          ],
        ),
        SizedBox(height: 60,),
        Container(
          child: Center(child: Text("Update" , style:  TextStyle(color: Colors.white , fontSize: 18 , fontWeight: FontWeight.bold),)),
          height: 49,
          width: 300,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(30),
            color: Color(0xffF8774A),

          ),
        ),
        SizedBox(height: 20,)




      ],
    ) : CircularProgressIndicator();
  }
}




Future<void> _showMyDialog(BuildContext context ) async {
  bool isLogout = false;
  return showDialog<void>(
    context: context,
    //barrierDismissible: false, // user must tap button!
    builder: (BuildContext context) {
      return AlertDialog(
        title: const Text('Logout Account' , style: TextStyle(fontFamily: "Nonito"),),
        content: SingleChildScrollView(
          child: ListBody(
            children: <Widget>[
              //Text('This is a demo alert dialog.'),
              Text('Do you want to logged out ?', style: TextStyle(fontFamily: "Nonito" , fontSize: 17)),
               !isLogout ? Container() : CircularProgressIndicator()
            ],
          ),
        ),
        actions: <Widget>[
          TextButton(
            child:  Text('Confirm logout', style: TextStyle(fontFamily: "Nonito" , color: Colors.orange , fontWeight: FontWeight.bold , fontSize: 17)),
            onPressed: () {
              AuthMethods authMethods = new AuthMethods();
              authMethods.signOut();
              HelperFunctions.saveUserLoggedInSharedPreference(false);
              //Constants.myName="";

              Future.delayed(Duration(seconds: 1), () {
                isLogout = true;
                //print(isAnimate);
                // 5 seconds over, navigate to Page2.
                Navigator.of(context).pushAndRemoveUntil(
                    MaterialPageRoute(builder: (context) => Register(),
                    ), (route) => false);
              });
              print("you were signed out , you are in sign in screen");

            },
          ),
        ],
      );
    },
  );
}
Widget cart(BuildContext context){

  final cart = Provider.of<Cart>(context);
  return cart.itemCount != 0 ?Column(

    children: [
      SizedBox(height: 20,),
      Column(
        children: [

          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
            Padding(
              padding: const EdgeInsets.only(left: 20),
              child: Text("Items: " + cart.itemCount.toString() , style: TextStyle(fontSize: 18 ,  color: Colors.black54 , fontWeight: FontWeight.bold),),
            ),
            Padding(
              padding: const EdgeInsets.only(right: 20),
              child: Text("Total: ₹" + cart.totalPrice.toInt().toString(), style: TextStyle(fontSize: 18 , color: Colors.black54 ,  fontWeight: FontWeight.bold),),
            ),
          ],),
          ListView.builder(
              physics: ScrollPhysics(),
              shrinkWrap: true,
              itemCount: cart.items.length,
              itemBuilder: (context , i)  => CartItem(
                cart.items.values.toList()[i].id,
                cart.items.keys.toList()[i],
                cart.items.values.toList()[i].title,
                cart.items.values.toList()[i].price,
                cart.items.values.toList()[i].quantity,
                cart.items.values.toList()[i].image,

              )
          ),
           SizedBox(height: 60,)
        ],
      ),
    ],
  ) : Column(
    children: [
      SizedBox(height: 300,),
      Center(child: Text("Nothing in the Cart!" ,style: TextStyle(fontSize: 20 , color: Colors.black54),),),
    ],
  );
}

class CartItem extends StatelessWidget {
  final String image;
  final String id;
  final String productId;
  final String title;
  final double price;
  final int quantity;
  CartItem(this.id , this.productId , this.title , this.price , this.quantity , this.image);
  @override
  Widget build(BuildContext context) {
    final cart = Provider.of<Cart>(context ,listen: false);
    return Dismissible(
      direction: DismissDirection.endToStart,
      onDismissed: (direction){
        cart.removeItem(productId);
      },
      key: ValueKey(id),
      background: Container(
        alignment: Alignment.centerRight,
        padding: EdgeInsets.only(left: 20 , right: 20),
        margin: EdgeInsets.symmetric(horizontal: 0, vertical: 4),
        color: Colors.redAccent,
        child: Icon(
          Icons.delete,
          color: Colors.white,
          size: 30,
        ),
      ),
      child: Card(
        shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20)
        ),
        margin: EdgeInsets.symmetric(horizontal: 10 , vertical: 2),
        child:Container(
          height: 120,
          //padding: EdgeInsets.all(0),
          child: Row(
            children: [
              CircleAvatar(
                  maxRadius: 50,
                  backgroundColor: Colors.white,
                  child: SizedBox(
                    height: 90,
                    width: 90,
                    child: image!= null ? Image(image: NetworkImage(image),) : CircularProgressIndicator(),
                  )

              ),
            Padding(
              padding: const EdgeInsets.only(top: 30 , left: 15),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(title, style:  TextStyle(fontSize: 17 , fontWeight: FontWeight.bold , color: Colors.black54),),

                  SizedBox(height: 15,),
                  SizedBox(
                    height: 20,
                    width: 90,
                    child: Row(
                      children: [
                        Container(

                          //padding: const EdgeInsets.only( bottom: 10),
                            height: 25,
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
                                  if(quantity > 1) {
                                    cart.addItem(id, title, price, -1, image);
                                  }
                                  else{
                                    cart.removeItem(productId);
                                  }


                                },
                                icon : Icon(Icons.remove, color: Colors.white,),iconSize: 17, color: Colors.white,),
                            )
                        ),
                        Container(
                            decoration: BoxDecoration(
                                border: Border.all(color: Color(0xffFFFF7371),)
                            ),
                            height: 25,
                            width: 30,
                            child: Center(child: Text(quantity.toString() , style: TextStyle(fontWeight: FontWeight.bold , color: Colors.black54),))
                        ),
                        Container(
                            height: 25,
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
                                cart.addItem(id, title, price, 1, image);
                              },
                            )
                        ),
                      ],
                    ),
                  )


                ],
              ),
            ),
            Spacer(),
            Padding(
              padding: const EdgeInsets.only(top: 40 , left: 10 , right: 15 , bottom: 30),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text( ' x $quantity ' ,  style:  TextStyle( fontSize: 15, color: Colors.black54 , fontWeight: FontWeight.bold)),
                  Spacer(),
                  Text(
                    '₹${price.toInt()*quantity}' ,
                    style:  TextStyle(
                        fontSize: 15,
                        color: Colors.green,
                        fontWeight: FontWeight.bold
                        //fontFamily: 'QuickSand'
                    ),
                  ),



                ],
              ),
            )



            ],
          )
        ),
      ),
    );
  }
}


class Badge extends StatelessWidget {
  const Badge({
    Key key,
    @required this.child,
    @required this.value,
    this.color,
  }) : super(key: key);

  final Widget child;
  final String value;
  final Color color;

  @override
  Widget build(BuildContext context) {
    return Container(

      //color: Colors.redAccent,
      padding: EdgeInsets.only(top: 0),
      child: Stack(
        alignment: value == '0' ? Alignment.center : Alignment.centerLeft,
        children: [
          child,
          Positioned(
            right: 0,
            top: 0,
            left: 22,
            bottom: 0,
            child: value != '0' ? Container(
              // height: 20,
              // width: 2,
              decoration : BoxDecoration(
                //color: Colors.redAccent
              ),
              child: Text(
                value,
                textAlign: TextAlign.center,
                style: TextStyle(
                  //backgroundColor: Colors.redAccent,
                    fontSize: 15,
                    color: Color(0xffFF6838),
                    fontWeight: FontWeight.bold
                ),
              ),
            ):Container(),
          )
        ],
      ),
    );
  }
}
