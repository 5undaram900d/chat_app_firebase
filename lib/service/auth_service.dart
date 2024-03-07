
import 'package:chat_app_firebase/helper/helper_function.dart';
import 'package:chat_app_firebase/service/database_service.dart';
import 'package:firebase_auth/firebase_auth.dart';

class AuthService {
  final FirebaseAuth firebaseAuth = FirebaseAuth.instance;

  //login
  Future loginUserWithEmailAndPassword(String email, String password)async{
    try{
      User user = (await firebaseAuth.signInWithEmailAndPassword(email: email, password: password)).user!;

      if(user!=null){
        return true;
      }
    } on FirebaseAuthException catch (e){
      // print(e);
      return e.message;
    }
  }

  //register
  Future registerUserWithEmailAndPassword(String fullName, String email, String password)async{
    try{
      User user = (await firebaseAuth.createUserWithEmailAndPassword(email: email, password: password)).user!;

      if(user!=null){
        //call our database service to update the user data
        await DatabaseService(uid: user.uid).savingUserData(fullName, email);
        return true;
      }
    } on FirebaseAuthException catch (e){
      // print(e);
      return e.message;
    }
  }

  //sign-out
  Future signOut() async{
    try{
      await HelperFunctions.saveUserLoggedInStatus(false);
      await HelperFunctions.saveUserEmailSF("");
      await HelperFunctions.saveUserNameSF("");
      await firebaseAuth.signOut();
    } catch (e){
      return null;
    }
  }

}