import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class CrudFire{
bool auth(){
  return FirebaseAuth.instance.currentUser!=null? true:false;
}
Future <void> create(data)async{
  if(auth()){
    //FirebaseFirestore.instance.collection('content').add(data);
    FirebaseFirestore.instance.runTransaction((Transaction ctrans) async {
      DocumentReference reference =await FirebaseFirestore.instance.collection('contacts').add(data);
    } );
  }
}
getData ()async{
  return await FirebaseFirestore.instance.collection('contacts').get();
}

}