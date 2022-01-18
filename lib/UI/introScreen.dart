import 'package:cafe91asm/DB/auth.dart';
import 'package:cafe91asm/DB/database.dart';
import 'package:cafe91asm/DB/sharedPreferences.dart';
import 'package:cafe91asm/UI/menu.dart';
import 'package:cafe91asm/modal/constants.dart';
import 'package:cafe91asm/modal/product.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
class IntroScreen extends StatefulWidget {

  final String userID;
  final String fullName;
  final String mob;
  IntroScreen ( this.fullName , this.mob , this.userID);
  @override
  _IntroScreenState createState() => _IntroScreenState();
}

class _IntroScreenState extends State<IntroScreen> {
  TextEditingController house = new TextEditingController();
  TextEditingController street = new TextEditingController();
  TextEditingController locality = new TextEditingController();
  TextEditingController cityPincode = new TextEditingController();
  void addToDb(String address) async {

    var list = [address];
    //var list2 = [url];
    FirebaseFirestore.instance.collection("users").doc(widget.userID).update({
      'address' : FieldValue.arrayUnion(list)

    }).then((value) => print("complete"));


  }


  bool isLoading = false;
  List<Product> namesItem = [];
  static var allNames = [];
  @override
  void initState() {
    getUserInfo();
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


    }).then((value) => print(namesItem));

    super.initState();

  }

  getUserInfo() async {
    isLoading = true;
    Constants.myName = await HelperFunctions.getUserNameSharedPreference();
    setState(() {
      isLoading = false;
    });
    print("${Constants.myName}");
  }


  @override
  Widget build(BuildContext context) {
    return isLoading ? CircularProgressIndicator(): Scaffold(
      backgroundColor: Colors.redAccent[200],
      body: Container(
        child: SingleChildScrollView(
          child: Column(
            children: [
              SizedBox(height: 40,),
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                GestureDetector(
                  onTap: () async{
                    FirebaseFirestore.instance.collection("users").doc(widget.userID).set(
                      {
                        "name":widget.fullName,
                        "email":widget.userID,
                        "mobile num" : widget.mob,
                      }
                    ).then((value) => print("success"));
                    AuthMethods.address.add("");
                    String e = widget.userID;
                    DatabaseMethods databaseMethods = new DatabaseMethods();
                    await  databaseMethods.uploadUserInfo(  {
                      "name":widget.fullName,
                      "email":widget.userID,
                      "mobile num" : widget.mob,
                    },  e );
                    AuthMethods.address.clear();
                    //AuthMethods.address.add( house.text + ", " + street.text + ", " + locality.text + ", " + cityPincode.text );
                    FirebaseFirestore.instance.collection("users").doc(widget.userID).update(
                        {
                          "address" :  AuthMethods.address
                        }
                    );
                    Navigator.of(context).push(MaterialPageRoute(
                        builder: (context) => MenuScreen(widget.userID , 0) ));
                  },
                  child: Padding(
                    padding: const EdgeInsets.only(right: 20 , top: 10),
                    child: Row(
                      children: [
                        Text("SKIP" , style: TextStyle(color: Colors.white , fontSize: 18 , fontWeight: FontWeight.bold),),
                        Icon(Icons.keyboard_arrow_right , color: Colors.white, size: 18,)
                      ],
                    ),
                  ),
                ),
                  //SizedBox(height: 10,),

              ],),
              SizedBox(height: 0,),
              Center(
                child: SizedBox(
                height: 250,
                width: 200,
                child: Image(
                  image: AssetImage(
                      'assets/images/cafelogo.png'
                  ),
                ),
              ),
              ),
              SizedBox(height: 0,),
              Text(
                  "Welcome ${Constants.myName.split(' ')[0]}!",
                style: TextStyle(color: Colors.white , fontSize: 40),
              ),
              SizedBox(height: 10,),
              Text(
                "Unlock the world of regular\n and rescued food by setting\n up your delivery address.",
                style: TextStyle(color: Colors.grey[300] , fontSize: 20 , ),
              ),
              SizedBox(height: 50),
              Text(
                  "SELECT LOCATION",
                style: TextStyle(color: Colors.white , fontSize: 18),
              ),
              SizedBox(height: 10,),
              Column(
                children: [
                 Container(

                   decoration: BoxDecoration(
                     color: Colors.white,
                     borderRadius: BorderRadius.circular(30),
                   ),
                   height: 70,
                   width: 314,
                   child: Row(
                     children: [
                       SizedBox(width: 20,),
                       Icon(Icons.search),
                       SizedBox(width: 10,),
                       Text("Locate Me" , style: TextStyle(color: Color(0xffFF460A) , fontWeight: FontWeight.bold , fontSize: 17),)
                     ],
                   ),
                 ),
                  SizedBox(height: 15,),
                  GestureDetector(
                    onTap: () async {

                      showModalBottomSheet(
                          context: context,
                          builder: (context) {
                            return SingleChildScrollView(
                              child: Container(
                                color: Colors.white,
                                height: 400,
                                child: Column(
                                  mainAxisSize: MainAxisSize.max,
                                  children: <Widget>[
                                    SizedBox(
                                      height : 40,
                                      child: Center(
                                        child:
                                        Padding(
                                          padding: const EdgeInsets.all(10.0),
                                          child: Text("Address details" , style: TextStyle(fontSize: 18),),
                                        ),),
                                    ),

                                    Container(

                                      decoration: BoxDecoration(
                                          color : Colors.white,
                                          borderRadius: BorderRadius.circular(10)
                                      ),


                                      margin : EdgeInsets.only(top: 10 , right: 20 , left: 20),
                                      padding: EdgeInsets.only(left: 33 , right: 33),
                                      child: SizedBox(

                                        height: 50,
                                        width: 277,
                                        child: Center(
                                          child: TextField(
                                            // validator: (val){
                                            //   if (val.isEmpty)
                                            //   {
                                            //     return  "Full Name cannot be empty";
                                            //   }
                                            //   else{
                                            //     return null;
                                            //   }
                                            // },
                                             controller: house,
                                            decoration: InputDecoration(
                                              //focusColor: Colors.grey,
                                              //hoverColor: Colors.grey,
                                                focusedBorder: InputBorder.none,
                                                enabledBorder: InputBorder.none,
                                                hintText: "House number",
                                                hintStyle: TextStyle(color: Colors.redAccent)
                                            ),
                                          ),
                                        ),
                                      ),
                                    ),
                                    Container(

                                      decoration: BoxDecoration(
                                          color : Colors.white,
                                          borderRadius: BorderRadius.circular(10)
                                      ),


                                      margin : EdgeInsets.only(top: 10 , right: 20 , left: 20),
                                      padding: EdgeInsets.only(left: 33 , right: 33),
                                      child: SizedBox(

                                        height: 50,
                                        width: 277,
                                        child: Center(
                                          child: TextField(
                                            // validator: (val){
                                            //   if (val.isEmpty)
                                            //   {
                                            //     return  "Full Name cannot be empty";
                                            //   }
                                            //   else{
                                            //     return null;
                                            //   }
                                            // },
                                            controller: street,
                                            decoration: InputDecoration(
                                              //focusColor: Colors.grey,
                                              //hoverColor: Colors.grey,
                                                focusedBorder: InputBorder.none,
                                                enabledBorder: InputBorder.none,
                                                hintText: "Street",
                                                hintStyle: TextStyle(color: Colors.redAccent)
                                            ),
                                          ),
                                        ),
                                      ),
                                    ),
                                    Container(

                                      decoration: BoxDecoration(
                                          color : Colors.white,
                                          borderRadius: BorderRadius.circular(10)
                                      ),


                                      margin : EdgeInsets.only(top: 10 , right: 20 , left: 20),
                                      padding: EdgeInsets.only(left: 33 , right: 33),
                                      child: SizedBox(

                                        height: 50,
                                        width: 277,
                                        child: Center(
                                          child: TextField(
                                            // validator: (val){
                                            //   if (val.isEmpty)
                                            //   {
                                            //     return  "Full Name cannot be empty";
                                            //   }
                                            //   else{
                                            //     return null;
                                            //   }
                                            // },
                                            controller: locality,
                                            decoration: InputDecoration(
                                              //focusColor: Colors.grey,
                                              //hoverColor: Colors.grey,
                                                focusedBorder: InputBorder.none,
                                                enabledBorder: InputBorder.none,
                                                hintText: "Locality",
                                                hintStyle: TextStyle(color: Colors.redAccent)
                                            ),
                                          ),
                                        ),
                                      ),
                                    ),
                                    Container(

                                      decoration: BoxDecoration(
                                          color : Colors.white,
                                          borderRadius: BorderRadius.circular(10)
                                      ),


                                      margin : EdgeInsets.only(top: 10 , right: 20 , left: 20),
                                      padding: EdgeInsets.only(left: 33 , right: 33),
                                      child: SizedBox(

                                        height: 50,
                                        width: 277,
                                        child: Center(
                                          child: TextField(
                                            // validator: (val){
                                            //   if (val.isEmpty)
                                            //   {
                                            //     return  "Full Name cannot be empty";
                                            //   }
                                            //   else{
                                            //     return null;
                                            //   }
                                            // },
                                            // controller: fullNameSignUp,
                                            controller: cityPincode,
                                            decoration: InputDecoration(
                                              //focusColor: Colors.grey,
                                              //hoverColor: Colors.grey,
                                                focusedBorder: InputBorder.none,
                                                enabledBorder: InputBorder.none,
                                                hintText: "City,Pincode",
                                                hintStyle: TextStyle(color: Colors.redAccent)
                                            ),
                                          ),
                                        ),
                                      ),
                                    ),
                                    ElevatedButton(
                                      child: Text("Submit and continue"),
                                      onPressed: () async{

                                        List<String> addresses = [house.text + ", " + street.text + ", " + locality.text + ", " + cityPincode.text];
                                        Map<String , String> userInfoMap = {
                                          "name":widget.fullName,
                                          "email":widget.userID,
                                          "mobile num" : widget.mob,
                                          //"address": addresses[0]

                                        };
                                        String e = widget.userID;
                                        DatabaseMethods databaseMethods = new DatabaseMethods();
                                        await  databaseMethods.uploadUserInfo(userInfoMap ,  e );
                                        AuthMethods.address.clear();
                                        AuthMethods.address.add( house.text + ", " + street.text + ", " + locality.text + ", " + cityPincode.text );
                                        FirebaseFirestore.instance.collection("users").doc(widget.userID).update(
                                          {
                                            "address" :  AuthMethods.address
                                          }
                                        );

                                        //addToDb(addresses[0]);
                                        Navigator.of(context).push(MaterialPageRoute(
                                            builder: (context) => MenuScreen(widget.userID , 0) ));
                                      },
                                    )

                                  ],
                                ),
                              ),
                            );
                          });




                    },
                    child: Container(

                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(30),
                      ),
                      height: 70,
                      width: 314,
                      child: Row(
                        children: [
                          SizedBox(width: 20,),
                          Icon(Icons.location_on_outlined),
                          SizedBox(width: 10,),
                          Text("Enter address manually" , style: TextStyle(color: Color(0xffFF460A) , fontWeight: FontWeight.bold , fontSize: 17),)
                        ],
                      ),
                    ),
                  )
                ],
              )


            ],
          ),
        ),
      ),
    );
  }
}
