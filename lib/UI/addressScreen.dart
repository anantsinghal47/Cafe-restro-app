import 'package:cafe91asm/DB/auth.dart';
import 'package:cafe91asm/DB/auth.dart';
import 'package:cafe91asm/UI/menu.dart';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class AddressScreen extends StatefulWidget {
  final String userId;
  //final List<String> address;
  AddressScreen(this.userId );
  @override
  _AddressScreenState createState() => _AddressScreenState();
}

class _AddressScreenState extends State<AddressScreen> {

  void addToDb(String address) async {

    var list = [address];
    //var list2 = [url];
    FirebaseFirestore.instance.collection("users").doc(widget.userId).update({
      'address' : FieldValue.arrayUnion(list)

    }).then((value) => print("complete"));


  }

  TextEditingController house = new TextEditingController();
  TextEditingController street = new TextEditingController();
  TextEditingController locality = new TextEditingController();
  TextEditingController cityPincode = new TextEditingController();
  List<String> address = [];
  bool isLoad = true;


  @override
  void initState() {
    // TODO: implement initState
    FirebaseFirestore.instance.collection("users").doc(widget.userId).get().then((value) async{
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
  }
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Scaffold(
        appBar: AppBar(title: Text("Address Book"),),
        body: isLoad ? LinearProgressIndicator() : ListView(
          shrinkWrap:  true,
          children: [
            Card(
              child: Row(
                children: [
                  IconButton(icon: Icon(Icons.add), onPressed: (){

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
                                  SizedBox(height: 20,),
                                  ElevatedButton(
                                    style: ButtonStyle(
                                      backgroundColor: MaterialStateProperty.all(Colors.red[300])
                                    ),
                                    child: Text("Add address"),
                                    onPressed: () async{

                                      List<String> addresses = [house.text + ", " + street.text + ", " + locality.text + ", " + cityPincode.text];
                                     // AuthMethods.address = addresses;
                                    addToDb(addresses[0]);
  
                                      //AuthMethods.address.add( house.text + ", " + street.text + ", " + locality.text + ", " + cityPincode.text) ;

                                      initState();

                                      Navigator.pushAndRemoveUntil(
                                          context,
                                          MaterialPageRoute(builder: (BuildContext context) => MenuScreen(widget.userId,3)),
                                          ModalRoute.withName('/')
                                      );
                                    },
                                  )

                                ],
                              ),
                            ),
                          );
                        });

                }),
                 Text("Add New Address")
                ],
              ),
            ),
            SizedBox(height: 20,),
            ListView.builder(
              shrinkWrap: true,
              itemCount: address.length,
              itemBuilder: (context , i){
                return AddressTile(
                  address[i],
                  i
                );
              },
            )

          ],
        ),
      ),
    );
  }
}

Widget AddressTile(String address , i)
{
  int idd = i +1 ;
  return GestureDetector(
    onTap: (){

    },
    child: Padding(
      padding: const EdgeInsets.all(8.0),
      child: Container(
        decoration: BoxDecoration(
          //border: Border.all(color: idd == 1 ?  Colors.redAccent : Colors.white)
        ),
        child: SizedBox(
          height: 100,
          child: Card(
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Text("Address " +  idd.toString()),

                  Text(address , style: TextStyle(fontSize: 17),),
                ],
              ),
            ),
          ),
        ),
      ),
    ),
  );
}