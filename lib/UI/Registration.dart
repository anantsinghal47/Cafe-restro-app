import 'package:cafe91asm/DB/auth.dart';
import 'package:cafe91asm/DB/database.dart';
import 'package:cafe91asm/DB/sharedPreferences.dart';
import 'package:cafe91asm/UI/introScreen.dart';
import 'package:cafe91asm/UI/menu.dart';
import 'package:cafe91asm/modal/currentUser.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';


class Register extends StatefulWidget {
  @override
  _RegisterState createState() => _RegisterState();
}

class _RegisterState extends State<Register> {

  List<String> address = [];
  CurrentUser user1 = new CurrentUser("null");
  TextEditingController userNameMobEmailSignIn = new TextEditingController();
  TextEditingController passwordSignIn = new TextEditingController();
  TextEditingController fullNameSignUp = new TextEditingController();
  TextEditingController passSignUp = new TextEditingController();
  TextEditingController passReset = new TextEditingController();
  TextEditingController confirmPassSignUp = new TextEditingController();
  TextEditingController mobNumSignUp = new TextEditingController();
  TextEditingController emailSignUp = new TextEditingController();
  TextEditingController userNameMob = new TextEditingController();
  final formKey = GlobalKey<FormState>();
  final formKey2 = GlobalKey<FormState>();
  bool isLoading = false;
  bool isLoadingSignIn = false;
  bool isIncorrect = false;
  bool isAnimate = false ;
  bool isEmailUsed = false ;
  bool isEmailNotExist = false ;
  AuthMethods authMethods = new AuthMethods();
  DatabaseMethods databaseMethods = new DatabaseMethods();
  QuerySnapshot snapshotUserInfo;
  signMeUp() async {

    if(formKey.currentState.validate()){
      bool a = await databaseMethods.checkUserByEmail(emailSignUp.text);
      if(!a){
        setState(() {
          isEmailUsed = false;
        });
        List<String> abcff = [];
        Map<String , String> userInfoMap = {
          "name":fullNameSignUp.text,
          "email":emailSignUp.text,
          "mobile num" : mobNumSignUp.text,
        };
        HelperFunctions.saveUserEmailPreference(emailSignUp.text);
        HelperFunctions.saveUsernamePreference(fullNameSignUp.text);
        setState(() {
          isLoading=true;
        });
        authMethods.signUpWithEmailAndPassword(emailSignUp.text, passSignUp.text).then((val){
          print("$val");

        });

        // uploading userInfo simultaneously
        databaseMethods.uploadUserInfo(userInfoMap , emailSignUp.text );
        // this replaces the screen in which we are to route
        print("please sign in to continue");
        setState(() {
          isAnimate = true;
          isIncorrect = false;
        });
        Future.delayed(Duration(seconds: 1), () {
          print(isAnimate);
          // 5 seconds over, navigate to Page2.
          Navigator.push(context, MaterialPageRoute(
            // which screen we want to go
              builder: (context) => IntroScreen( fullNameSignUp.text , mobNumSignUp.text  , emailSignUp.text)));
        });

      }
      else{
        print("email already exists");
        setState(() {
          isEmailUsed = true;
        });


      }


      // setState(() {
      //   isAnimate = false;
      // });


    }
  }
  signMeIn() async {


    if(formKey2.currentState.validate()){
      bool a = await databaseMethods.checkUserByEmail(userNameMobEmailSignIn.text);
      if(a){
        setState(() {
          isEmailNotExist = false;
        });

        HelperFunctions.saveUserEmailPreference(userNameMobEmailSignIn.text);
        //HelperFunctions.saveUsernamePreference(password.text);

        setState(() {
          isLoadingSignIn = true;
        });

        databaseMethods.getUserByEmail(userNameMobEmailSignIn.text).then((val){
          snapshotUserInfo=val;
          HelperFunctions.saveUsernamePreference((snapshotUserInfo.docs[0].data() as Map)["name"]);
          print("${(snapshotUserInfo.docs[0].data() as Map)["name"]}");
        }
        );
        authMethods.signInWithEmailAndPassword(userNameMobEmailSignIn.text, passwordSignIn.text).then((val){
          print("$val");
          if(val != null){
            HelperFunctions.saveUserLoggedInSharedPreference(true);
            setState(() {
              isAnimate = true;
              isIncorrect = false;
            });
            user1.id = userNameMobEmailSignIn.text;
            print(user1.id);


            FirebaseFirestore.instance.collection("users").doc(userNameMobEmailSignIn.text).get().then((value) async{
              //address = await value.data()["address"];
              var  abcd  = await value.data()["address"];

              print(abcd);
              try{


                List<String> strings = List<String>.from(abcd);

                address = strings;
                print("address : " + address.toString());
                AuthMethods.address = address;
                print(AuthMethods.address);
              }
              catch(e)
              {
                e.toString();
              }

            });
            // 5 seconds over, navigate to Page2.
            Navigator.push(context, MaterialPageRoute(
              // which screen we want to go
                builder: (context) => MenuScreen(userNameMobEmailSignIn.text, 0)));
            //Future.delayed(Duration(milliseconds: 400), () {


              // FirebaseFirestore.instance.collection("users").doc(userNameMobEmailSignIn.text).get().then((value) async{
              //   //address = await value.data()["address"];
              //   var  abcd  = await value.data()["address"];
              //   try{
              //
              //     List<String> strings = List<String>.from(abcd);
              //     address = strings;
              //     AuthMethods.address = strings;
              //   }
              //   catch(e)
              //   {
              //     e.toString();
              //   }
              //
              // });
              // // 5 seconds over, navigate to Page2.
              // Navigator.push(context, MaterialPageRoute(
              //   // which screen we want to go
              //     builder: (context) => MenuScreen(userNameMobEmailSignIn.text, 0)));
            //});
            // setState(() {
            //   isAnimate = false;
            // });

          }
          else{
            print("incorrect : $isIncorrect");
            setState(() {
              isIncorrect = true;
            });
          }

        });
      }
      else{
        setState(() {
          isEmailNotExist = true;
          print("Account Not Exist");
        });

      }


    }

  }



  bool onTapLogin = true;
  bool isFill = false;
  bool onTapForgot = false;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(toolbarHeight: 0.2, backgroundColor:  Colors.grey[200],),
      backgroundColor: Colors.grey[200],
      body: SingleChildScrollView(
        scrollDirection: Axis.vertical,
        //dragStartBehavior: DragStartBehavior.start,

        child: Column(
          children: [
            //SizedBox(height: 5, child: Container(color: Color(0xffFA4A0C)),),
            Container(
              decoration: BoxDecoration(
                boxShadow: [
                  BoxShadow(
                    color: Colors.grey[300],
                    blurRadius: .0, // soften the shadow
                    spreadRadius: 1.0, //extend the shadow
                    offset: Offset(
                      0, // Move to right 10  horizontally
                      0, // Move to bottom 10 Vertically
                    ),
                  )
                ],
                borderRadius: BorderRadius.only(bottomLeft: Radius.circular(40) , bottomRight: Radius.circular(40)),
                  color: Colors.white,
                // border: Border(
                //   //bottom: BorderSide(width: 5),
                // )
              ),

              height: 230,
              child: Column(
                children: [
                  SizedBox(height: 10,),
                  Center(child: SizedBox(
                    height: 180,
                      width: 300,
                      child: Image(
                        image: AssetImage(
                            'assets/images/cafelogo.png'
                        ),
                      ),
                  ),
                  ),
                  //SizedBox(height: 10,),
                  Row(
                    mainAxisAlignment:MainAxisAlignment.spaceEvenly,
                    children: [
                      GestureDetector(
                        onTap: (){
                          setState(() {
                            onTapLogin = true;
                            onTapForgot = false;
                          });
                        },
                        child: Column(children: [
                          SizedBox(
                            width: 130,
                              child: Center(child: Text("Login" , style: TextStyle(fontSize: 18 , fontWeight: FontWeight.bold),))),
                          SizedBox(height: 12,),
                          onTapLogin || onTapForgot ? Container(
                            child: Text(""),
                            decoration: BoxDecoration(
                              color: Color(0xffFA4A0C)
                            ),
                            height: 3,
                            width: 120  ,
                          ) : Container()
                        ],),
                      ),
                      //SizedBox(width: 10,),
                      GestureDetector(
                        onTap: (){
                          setState(() {
                            onTapLogin = false;
                          });
                        },
                        child: Column(
                          children: [
                            SizedBox(
                              width: 130,
                                child: Center(child: Text("Sign-Up" , style: TextStyle(fontSize: 18 , fontWeight: FontWeight.bold),))),
                            SizedBox(height: 12,),
                           !onTapLogin && !onTapForgot?  Container(
                              child: Text(""),
                              decoration: BoxDecoration(
                                  color: Color(0xffFA4A0C)
                              ),
                              height: 3,
                              width: 120,
                            ) : Container()
                          ],
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),

            onTapLogin && !onTapForgot? Container(
              height: 551,
              color: Colors.grey[200],
              child: Column(
                children: [
                 Form(
                   key: formKey,
                   child: Column(
                     children: [
                       Form(
                           key:formKey2,
                           child: Column(
                            children: [
                            Container(

                             decoration: BoxDecoration(
                                 color : Colors.white,
                                 borderRadius: BorderRadius.circular(10)
                             ),

                             margin : EdgeInsets.only(top: 33 , right: 20 , left: 20),
                             padding: EdgeInsets.only(left: 33 , right: 33),
                             child: SizedBox(

                               height: 60,
                               width: 277,
                               child: Center(
                                 child: TextFormField(
                                   onFieldSubmitted: (abc){},
                                   validator: (val){
                                     if (val.isEmpty )
                                     {
                                       return  "Email cannot be empty";
                                     }
                                     else if(!RegExp(r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+").hasMatch(val))
                                     {
                                       return  "Enter valid email address";
                                     }

                                     else{
                                       return null;
                                     }
                                   },

                                   controller: userNameMobEmailSignIn,
                                   decoration: InputDecoration(
                                     //focusColor: Colors.grey,
                                     //hoverColor: Colors.grey,
                                       focusedBorder: InputBorder.none,
                                       enabledBorder: InputBorder.none,
                                       hintText: "Enter Email",
                                       hintStyle: TextStyle(color: Colors.grey[400])
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

                              margin : EdgeInsets.only(top: 20 , right: 20 , left: 20),
                             padding: EdgeInsets.only(left: 33 , right: 33),
                             child: SizedBox(

                               height: 60,
                               width: 277,
                               child: Center(
                                 child: TextFormField(
                                   onFieldSubmitted: (abc){
                                     signMeIn();
                                   },
                                   validator: (val){
                                     // min 6
                                     if(val.isEmpty)
                                       {
                                        return "Password cannot be empty";
                                       }
                                     else if ( val.length < 6) {
                                       return "Enter must be 6 characters long";
                                     }
                                     else{
                                       return null;
                                     }
                                   },
                                   obscureText: true,
                                   controller: passwordSignIn,
                                   decoration: InputDecoration(
                                       focusedBorder: InputBorder.none,
                                       enabledBorder: InputBorder.none,
                                       hintText: "Password",
                                       hintStyle: TextStyle(color: Colors.grey[400])
                                   ),
                                 ),
                               ),
                             ),
                           ),
                         ],
                       ))
                     ],
                   ),
                 ),
                  Row(

                    children: [
                      Padding(
                        padding: const EdgeInsets.only(left: 33),
                        child: TextButton(
                            onPressed: (){
                              setState(() {
                                onTapLogin = false;
                                onTapForgot = true;
                              });
                            },
                            child: Text(
                              "Forgot Password?" ,
                              style: TextStyle(color: Color(0xffFA4A0C) , fontWeight: FontWeight.bold ),
                            ),
                        ),
                      ),
                    ],
                  ),
                  //SizedBox(height: 10,),
                  !isEmailNotExist ? Column(children: [
                    isAnimate ? SizedBox(
                        height: 20,
                        width: 20,
                        //width: 320,
                        child: CircularProgressIndicator(backgroundColor: Colors.redAccent, valueColor: AlwaysStoppedAnimation<Color>(Colors.white))) : Container(),
                    isIncorrect ? SizedBox(height: 20, child: Text("Invalid Credentials ! Try Again" ,
                      style: TextStyle(color: Colors.redAccent , fontWeight: FontWeight.w700),),) :
                    SizedBox(height: 20,),
                  ],) : SizedBox(height: 20, child: Text("Account does not exist !" ,
                    style: TextStyle(color: Colors.redAccent , fontWeight: FontWeight.w700),),),

                 SizedBox(height: 10,),
                  Column(
                    //mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      GestureDetector(
                        onTap: (){
                          signMeIn();
                        },
                        child: Container(
                          decoration: BoxDecoration(
                              color: Color(0xffF8774A),
                              borderRadius: BorderRadius.circular(30)
                          ),
                          child: Center(child: TextButton(
                            onPressed: (){
                              signMeIn();
                            },
                            child: Text(
                              "Login" ,
                              style: TextStyle(
                                  color: Colors.white ,
                                  fontSize: 17 ,
                                  fontWeight: FontWeight.bold
                              ),
                            ),
                          ),
                          ),
                          height: 56,
                          width: 321,
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Container(
                          child: Text(
                            "Or",
                          style: TextStyle(
                              color: Colors.black ,
                              fontWeight:FontWeight.w700,
                            fontSize: 18
                          ),
                        ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(bottom: 8),
                        child: Container(
                          decoration: BoxDecoration(
                              color: Color(0xff1877F2),
                              borderRadius: BorderRadius.circular(30)
                          ),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                           IconButton(icon:  FaIcon(FontAwesomeIcons.facebook , color: Colors.white,), onPressed: (){}),
                              SizedBox(width: 10,),
                              Center(child: Text(
                                "Login With Facebook" ,
                                style: TextStyle(
                                    color: Colors.white ,
                                    fontSize: 17 ,
                                    fontWeight: FontWeight.bold
                                ),
                              ),
                              ),
                            ],
                          ),
                          height: 56,
                          width: 321,
                        ),
                      ),

                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Container(
                          decoration: BoxDecoration(
                              color: Color(0xffFFFFFF),
                              borderRadius: BorderRadius.circular(30)
                          ),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              IconButton(icon:  FaIcon(FontAwesomeIcons.google ,color: Colors.red[300], ), onPressed: (){}),
                              SizedBox(width: 0,),
                              Center(child: Text(
                                "Login With Google" ,
                                style: TextStyle(
                                    color: Colors.black,
                                    fontSize: 17 ,
                                    fontWeight: FontWeight.bold
                                ),
                              ),
                              ),
                            ],
                          ),
                          height: 56,
                          width: 321,
                        ),
                      ),

                    ],
                  )
                ],
              ),
            ) : !onTapForgot ?
                //register screen
            Container(
              height: 551,
              color: Colors.grey[200],
              child: Column(
                children: [
                  SizedBox(height: 20,),

                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Text("Register" , style:  TextStyle(fontSize: 36 , color: Color(0xffF8774A) , fontWeight: FontWeight.bold),),
                      Row(
                        children: [
                          Card(
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10)
                            ),
                            child: IconButton(icon: FaIcon(FontAwesomeIcons.google , color: Colors.red[300],), onPressed: (){},),
                          ),
                          Card(
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(10)
                            ),
                            child: IconButton(icon: FaIcon(FontAwesomeIcons.facebook , color: Colors.blue,),onPressed: (){}),
                          )
                        ],
                      )
                    ],
                  ),
                  Form(
                    key:formKey,
                    child:Column(
                      children: [
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
                              child: TextFormField(
                                validator: (val){
                                  if (val.isEmpty)
                                  {
                                    return  "Full Name cannot be empty";
                                  }
                                  else{
                                    return null;
                                  }
                                },
                                controller: fullNameSignUp,
                                decoration: InputDecoration(
                                  //focusColor: Colors.grey,
                                  //hoverColor: Colors.grey,
                                    focusedBorder: InputBorder.none,
                                    enabledBorder: InputBorder.none,
                                    hintText: "Full Name",
                                    hintStyle: TextStyle(color: Colors.grey[400])
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

                          margin : EdgeInsets.only(top: 15 ,  right: 20 , left: 20),
                          padding: EdgeInsets.only(left: 33 , right: 33),
                          child: SizedBox(

                            height: 50,
                            width: 277,
                            child: Center(
                              child: TextFormField(

                                validator: (val){
                                  if (val.isEmpty )
                                  {
                                    return  "Email cannot be empty";
                                  }
                                  else if(!RegExp(r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+").hasMatch(val))
                                    {
                                      return  "Enter valid email address";
                                    }

                                  else{
                                    return null;
                                  }
                                },
                                controller: emailSignUp,
                                decoration: InputDecoration(
                                    focusedBorder: InputBorder.none,
                                    enabledBorder: InputBorder.none,
                                    hintText: "Email Address",
                                    hintStyle: TextStyle(color: Colors.grey[400])
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

                          margin : EdgeInsets.only(top: 15 ,  right: 20 , left: 20),
                          padding: EdgeInsets.only(left: 33 , right: 33),
                          child: SizedBox(

                            height: 50,
                            width: 277,
                            child: Center(
                              child: TextFormField(

                                validator: (val){
                                  if (val.isEmpty )
                                  {
                                    return  "Mobile Number cannot be empty";
                                  }
                                  else if (val.length != 10)
                                    {
                                      return "Must be 10 digit long";
                                    }

                                  else{
                                    return null;
                                  }
                                },
                                controller: mobNumSignUp,
                                decoration: InputDecoration(
                                    focusedBorder: InputBorder.none,
                                    enabledBorder: InputBorder.none,
                                    hintText: "+91 Mobile Number",
                                    hintStyle: TextStyle(color: Colors.grey[400])
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

                          margin : EdgeInsets.only(top: 15 , right: 20 , left: 20),
                          padding: EdgeInsets.only(left: 33 , right: 33),
                          child: SizedBox(

                            height: 50,
                            width: 277,
                            child: Center(
                              child: TextFormField(
                                validator: (value){
                                  // password must be 6+ for firebase authentication
                                  if (value.isEmpty) {
                                    return "Please Enter New Password";
                                  } else if (value.length < 6) {
                                    return "Password must be atleast 6 characters long";
                                  }  else {
                                    return null;
                                  }
                                },
                                obscureText: true,
                                controller: passSignUp,
                                decoration: InputDecoration(
                                  //focusColor: Colors.grey,
                                  //hoverColor: Colors.grey,

                                    focusedBorder: InputBorder.none,
                                    enabledBorder: InputBorder.none,
                                    hintText: "Password",
                                    hintStyle: TextStyle(color: Colors.grey[400])
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

                          margin : EdgeInsets.only(top: 15 , right: 20 , left: 20),
                          padding: EdgeInsets.only(left: 33 , right: 33),
                          child: SizedBox(

                            height: 50,
                            width: 277,
                            child: Center(
                              child: TextFormField(

                                validator: (value){
                                  // password must be 6+ for firebase authentication
                                  if (value.isEmpty) {
                                    return "Please Re-Enter New Password";
                                  } else if (value.length < 6) {
                                    return "Password must be atleast 6 characters long";
                                  } else if (value != passSignUp.text) {
                                    return "Password must be same as above";
                                  } else {
                                    return null;
                                  }
                                  //return val.length> 6 ? null : "password must contain 6+ characters";
                                },
                                obscureText: true,
                                controller: confirmPassSignUp,
                                decoration: InputDecoration(
                                    focusedBorder: InputBorder.none,
                                    enabledBorder: InputBorder.none,
                                    hintText: "Confirm Password",
                                    hintStyle: TextStyle(color: Colors.grey[400])
                                ),
                              ),
                            ),
                          ),
                        ),
                      ],
                    )
                  ),

                  SizedBox(height: 20,),
                Container(
                   margin: EdgeInsets.only(right: 40 , left: 30),
                   child: Column(
                     children: [
                       Container(
                         child: Row(
                            //mainAxisAlignment: MainAxisAlignment.spaceAround,
                            children: [
                              //SizedBox(width: 30,),
                              GestureDetector(
                                onTap: (){
                                  signMeUp();
                                },
                                child: Container(
                                  decoration: BoxDecoration(
                                      color: Color(0xffF8774A),
                                      borderRadius: BorderRadius.circular(30)
                                  ),
                                  child: Center(child: Text(
                                    "Sign-up" ,
                                    style: TextStyle(
                                        color: Colors.white ,
                                        fontSize: 17 ,
                                        fontWeight: FontWeight.bold
                                    ),
                                  ),
                                  ),
                                  height: 58,
                                  width: 183,
                                ),
                              ),
                              GestureDetector(
                                onTap: (){
                                  setState(() {
                                    onTapLogin = true;
                                    onTapForgot = false;
                                  });
                                },
                                child: Padding(
                                  padding: const EdgeInsets.only(left: 20),
                                  child: Container(
                                    child: Text(
                                      "Already\na Member?",
                                      style: TextStyle(color: Color(0xffB2B2B2) , fontSize: 15),
                                    ),
                                  ),
                                ),
                              )

                            ],
                          ),
                       ),
                       SizedBox(height: 20,),
                      !isEmailUsed ? Column(
                         children: [
                           isAnimate ? Row(
                             mainAxisAlignment :  MainAxisAlignment.spaceEvenly,
                             children: [
                               Text("Hold up! We are setting up your Account " , style: TextStyle(fontSize: 14 , color:Color(0xffF8774A) ),),


                             ],) : Container(),
                           SizedBox(height: 10,),
                           isAnimate ?  SizedBox(
                               height: 20,
                               width: 20,
                               //width: 320,
                               child: CircularProgressIndicator(backgroundColor: Colors.redAccent, valueColor: AlwaysStoppedAnimation<Color>(Colors.white),))
                               : Container(),
                         ],
                       ) : Row(
                        mainAxisAlignment :  MainAxisAlignment.spaceEvenly,
                        children: [
                          Text("Email already Exist" , style: TextStyle(fontSize: 14 , color:Color(0xffF8774A) ),),


                        ],)
                     ],
                   ),
                 )
                ],
              ),
            ) : Container(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(top : 30.0 , left:  30 ,),
                      child: Row(
                        children: [
                          IconButton(
                              icon: Icon(Icons.arrow_back_ios , color: Colors.grey[500],), onPressed: (){
                                setState(() {
                                  onTapLogin = true;
                                  onTapForgot = false;
                                });
                          }
                          ),
                        ],
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(left: 40 , top: 10),
                      child: SizedBox(
                        child: Text("Forgot\nPassword?" , style: TextStyle(fontSize: 36 , color: Color(0xffF8774A) , fontWeight: FontWeight.bold),),
                      ),
                    ),
                    Center(
                      child: Container(

                        decoration: BoxDecoration(
                            color : Colors.white,
                            borderRadius: BorderRadius.circular(10)
                        ),

                        margin : EdgeInsets.only(top: 33),
                        padding: EdgeInsets.only(left: 30),
                        child: SizedBox(

                          height: 58,
                          width: 310,
                          child: Row(
                            children: [
                              Padding(
                                padding: const EdgeInsets.only(bottom:8.0 , right: 10),
                                child: Text("\u2709" , style: TextStyle(fontSize: 30 , color: Colors.grey[700]),),
                              ),
                              Flexible(
                                child: Center(
                                  child: TextFormField(

                                    onTap: (){

                                      FocusScope.of(context).unfocus();
                                    },
                                    // onEditingComplete: (){
                                    //   isFill = true;
                                    // },
                                    controller: passReset,
                                    decoration: InputDecoration(
                                      //focusColor: Colors.grey,
                                      //hoverColor: Colors.grey,
                                        focusedBorder: InputBorder.none,
                                        enabledBorder: InputBorder.none,
                                        hintText: "  Enter your email address",
                                        hintStyle: TextStyle(color: Color(0xff676767) , fontSize: 13)
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(20.0),
                      child: Center(
                          child: Text(
                            "*we will send you a message to set or reset your\nnew password" ,
                            style: TextStyle(color: Color(0xff676767)),
                      )),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(top: 60),
                      child: Center(
                          child: GestureDetector(
                            onTap: () async {
                              bool a = await databaseMethods.checkUserByEmail(passReset.text);
                              if(a){
                                authMethods.resetPassword(passReset.text);
                                final snackBar = SnackBar(
                                  backgroundColor: Colors.grey[200],
                                  content: const Text('Reset Code sent to registered email' , style: TextStyle(color: Colors.black),),
                                  action: SnackBarAction(
                                    label: 'Close ',
                                    onPressed: () {
                                      // Some code to undo the change.
                                    },
                                  ),
                                );

                                // Find the ScaffoldMessenger in the widget tree
                                // and use it to show a SnackBar.
                                ScaffoldMessenger.of(context).showSnackBar(snackBar);
                              }
                              else{
                                final snackBar = SnackBar(
                                  backgroundColor: Colors.grey[200],
                                  content: Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      const Text('Account does not exist' , style: TextStyle(color: Colors.red),),
                                    ],
                                  ),
                                  // action: SnackBarAction(
                                  //   label: 'Close ',
                                  //   onPressed: () {
                                  //     // Some code to undo the change.
                                  //   },
                                  // ),
                                );
                                ScaffoldMessenger.of(context).showSnackBar(snackBar);


                              }

                            },
                            child: Text(
                              "Send Code" ,
                              style: TextStyle(color: Color(0xffB2B2B2)  , fontSize: 24 , fontWeight: FontWeight.bold),
                            ),
                          )),
                    )
                  ],
                ),
            )

          ],
        ),
      ),
    );
  }
}
