
import 'package:chat_app_firebase/helper/helper_function.dart';
import 'package:chat_app_firebase/pages/auth/register_page.dart';
import 'package:chat_app_firebase/pages/home_page.dart';
import 'package:chat_app_firebase/service/auth_service.dart';
import 'package:chat_app_firebase/service/database_service.dart';
import 'package:chat_app_firebase/widgets/widgets.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {

  final formKey = GlobalKey<FormState>();
  String email = "";
  String password = "";
  bool _isLoading = false;
  AuthService authService = AuthService();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _isLoading ? Center(child: CircularProgressIndicator(color: Theme.of(context).primaryColor,),) : SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 80),
          child: Form(
            key: formKey,
            child: Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  const Text('Secret Chat App', style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold,),),
                  const SizedBox(height: 10,),
                  const Text("Login now to see what they are talking", style: TextStyle(fontSize: 15, fontWeight: FontWeight.w400,),),
                  Image.asset("assets/img3.jpg", width: 600, height: 250, fit: BoxFit.fitWidth,),
                  TextFormField(
                    decoration: textInputDecoration.copyWith(
                      labelText: "Email",
                      prefixIcon: Icon(Icons.email, color: Theme.of(context).primaryColor,),
                    ),
                    onChanged: (val){
                      setState(() {
                        email = val;
                        // print(email);
                      });
                    },
                    /********** for email validation RegEep **********/
                    validator: (val) {
                      return RegExp(r'\S+@\S+\.\S+').hasMatch(val!) ? null : "Please enter a valid email";
                    },
                  ),
                  const SizedBox(height: 10,),
                  TextFormField(
                    obscureText: true,
                    decoration: textInputDecoration.copyWith(
                      labelText: "Password",
                      prefixIcon: Icon(Icons.lock, color: Theme.of(context).primaryColor,),
                    ),
                    validator: (val){
                      if(val!.length<6){
                        return "Password must be at least 6 character";
                      }
                      else{
                        return null;
                      }
                    },
                    onChanged: (val){
                      setState(() {
                        password = val;
                        // print(password);
                      });
                    },
                  ),
                  const SizedBox(height: 10,),
                  SizedBox(
                    width: double.infinity,
                    child: ElevatedButton(
                      onPressed: ()=> login(),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Theme.of(context).primaryColor,
                        elevation: 0,
                        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(30)),
                      ),
                      child: const Text('Sign In', style: TextStyle(color: Colors.white, fontSize: 16),),
                    ),
                  ),
                  const SizedBox(height: 10,),
                  Text.rich(
                    TextSpan(
                      text: "Don't have an account?",
                      style: const TextStyle(color: Colors.black, fontSize: 14,),
                      children: <TextSpan>[
                        TextSpan(
                          text: "Register here",
                          style: const TextStyle(color: Colors.black, decoration: TextDecoration.underline,),
                          recognizer: TapGestureRecognizer()..onTap = (){
                            nextScreenReplace(context, const RegisterPage());
                          },
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }


  login() async{
    if(formKey.currentState!.validate()){
      setState(() {
        _isLoading = true;
      });
      await authService.loginUserWithEmailAndPassword(email, password).then((value) async{
        if(value==true){
          QuerySnapshot snapshot = await DatabaseService(uid: FirebaseAuth.instance.currentUser!.uid).gettingUserData(email);
          // saving the value to our shared preferences
          await HelperFunctions.saveUserLoggedInStatus(true);
          await HelperFunctions.saveUserEmailSF(email);
          await HelperFunctions.saveUserNameSF(snapshot.docs[0]['fullName']);
          nextScreenReplace(context, HomePage(),);
        }
        else{
          showSnackBar(context, Colors.red.withOpacity(0.2), value, "Error");
          setState(() {
            _isLoading = false;
          });
        }
      });
    }
  }

}














