import 'dart:ffi';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:mycontent/CrudFire.dart';
import 'package:mycontent/Home.dart';
import './CrudFire.dart';
import './Login.dart';
import 'package:mycontent/signup.dart';
import 'package:mycontent/AddContent.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
class Dasboard extends StatefulWidget {
  @override

  State<StatefulWidget> createState(){
    return DashboardState();
  }
}

class DashboardState extends State<Dasboard> {
  User user;
  CrudFire crud = new CrudFire();
  QuerySnapshot contacts;
  final auth = FirebaseAuth.instance;
  Future<Void> getuserData()async{
    User userdata = FirebaseAuth.instance.currentUser;
    setState((){
      user = userdata;
    });
  }
  Future<Void> signout () async{
    auth.signOut();
    Navigator.pushReplacement(context,
        MaterialPageRoute(builder: (context)=>Home())
    );
  }
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getuserData();
    crud.getData().then((data){
      setState(() {
        contacts =data;
      });
    });
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('My Content App'),
          actions:<Widget>[
            IconButton(
              icon: Icon(Icons.add),
              onPressed: (){
                Navigator.push(context,
                  MaterialPageRoute(
                    builder: (context){
                      return AddContent();
                    }
                  )
                );
              },
            ),
            FlatButton(
              color: Colors.white,
              child: Text('SignOut'),
              onPressed: signout,
            )
          ],
        ),

        body:ListView.builder(
          itemCount:contacts.docs.length,
            itemBuilder:(BuildContext context,index) {
              return Container(child: Row(
                  children: <Widget>[
                    ListTile(
                      title: ("$contacts.docs[index].data['name']"),
                      subtitle: contacts.docs[index].data['mobile'],
                    ),
                    FlatButton(onPressed: null, child: Text('Edit'),),
                    FlatButton(onPressed: null, child: Text('Delete'))

              ]
              )
              );
            }));
                      }
  }
