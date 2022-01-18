import 'package:cafe91asm/modal/user.dart';
import 'package:firebase_auth/firebase_auth.dart';


class AuthMethods{

  static String uId;
  static List<String> address = [];
  final FirebaseAuth _auth = FirebaseAuth.instance; // creating instance of firebaseAuth which use to communicate with firebaseAut
  // checking if user is signed in aur not
  AppUser _userFromFirebaseUser(User user){
    print(user.uid);
    uId = user.uid;
    return user !=null ? AppUser(userId: user.uid) : null; // if user is not null it gives

  }



  //method to signIn with email and password
  Future signInWithEmailAndPassword(String email , String password) async{
    try{
      UserCredential result =  await _auth.signInWithEmailAndPassword(
          email:email  ,
          password: password
      );// default method of _auth
      User firebaseUser = result.user;
      print(firebaseUser.uid);


      return _userFromFirebaseUser(firebaseUser);
    }catch(e){
      print(e);
    }
  }
  // method for sign up with Email and password
  Future signUpWithEmailAndPassword (String email , String password) async{
    try{
      UserCredential result =  await _auth.createUserWithEmailAndPassword(email: email , password: password);
      User firebaseUser = result.user;
      if(firebaseUser != null) {
        await firebaseUser.sendEmailVerification();
      }
      return _userFromFirebaseUser(firebaseUser);
    } catch(e){
      print(e.toString());
    }
  }



  // method for resetting pass
  Future resetPassword(String email) async{
    try {

      return _auth.sendPasswordResetEmail(email: email);
    } catch(e){
      print(e.toString());
    }
  }

  //sign out
  Future signOut() async{
    try{
      return await _auth.signOut();
    } catch(e){
      print(e.toString());
    }
  }


  // method for sign in anonymously
  Future signInAnon() async{
    try{
      // AuthResult changed to UserCredentials
      UserCredential result =  await _auth.signInAnonymously() ;// this gonna return authResult , await is used because this takes some time
      // firebaseUser changed to User in new update
      User user  = result.user; //  Returns a User containing additional information and user specific methods.
      return user;

    } catch(e){
      print(e.toString());
      return null;
    }
  }



}