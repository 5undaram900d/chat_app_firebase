
import 'package:flutter/material.dart';

const textInputDecoration = InputDecoration(
  labelStyle: TextStyle(color: Colors.black,),
  focusedBorder: OutlineInputBorder(
    borderSide: BorderSide(color: Colors.deepPurpleAccent, width: 2),
  ),
  enabledBorder: OutlineInputBorder(
    borderSide: BorderSide(color: Colors.deepPurpleAccent, width: 2),
  ),
  errorBorder: OutlineInputBorder(
    borderSide: BorderSide(color: Colors.deepPurpleAccent, width: 2),
  ),
);


void nextScreen(context, page){
  Navigator.push(context, MaterialPageRoute(builder: (context)=> page),);
}

void nextScreenReplace(context, page){
  Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=> page),);
}

void showSnackBar(context, color, message, label){
  ScaffoldMessenger.of(context).showSnackBar(
    SnackBar(
      content: Text(message, style: const TextStyle(fontSize: 14),),
      backgroundColor: color,
      duration: const Duration(seconds: 2),
      action: SnackBarAction(label: label, onPressed: (){}, textColor: Colors.white,),
    ),
  );
}