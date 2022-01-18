import 'package:cloud_firestore/cloud_firestore.dart';

class DatabaseMethods{

  // whenever user signedUp we have to upload its info to firestore
  // basically we are uploading a userMap which a map of key : value pair
  uploadUserInfo(userMap , username){
    FirebaseFirestore.instance.collection("users").doc(username).set(userMap).catchError((e){
      print(e.toString());
    });
  }
  // for searching the users
  getUserByUsername(String username) async{
    return await FirebaseFirestore.instance.collection("users").where("name", isEqualTo: username ).get();
  }
  getUserByEmail(String email) async{
    return await FirebaseFirestore.instance.collection("users").where("email", isEqualTo: email ).get();
  }
  checkUserByEmail(String email) async{
    DocumentSnapshot document =  await FirebaseFirestore.instance.collection("users").doc(email).get();
    if(document.exists){
      print("email exist");
      return true;

    }
    else{
      return false;
    }
  }

}