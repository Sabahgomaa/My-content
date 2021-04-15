import 'dart:ffi';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:mycontent/Home.dart';
import './CrudFire.dart';
import './Login.dart';
import './signup.dart';
import './Dashboard.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
class AddContent extends StatefulWidget {
  @override

  State<StatefulWidget> createState(){
    return AddContentState();
  }
}

class AddContentState extends State<AddContent> {
  CrudFire crud = new CrudFire();
  final GlobalKey<FormState> formstate = GlobalKey<FormState>();
  String _name,_email,_mobile;
  User user;
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
  addContent(){
    if(formstate.currentState.validate()){
      formstate.currentState.save();
      crud.create({
        'name':_name,
        'email':_email,
        'mbile':_mobile,
      });
      Navigator.push(context,
        MaterialPageRoute(
          builder: (context)=>Dasboard()
        )
      );
    }
  }
   @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getuserData();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('My Content App'),
          actions:<Widget>[
            FlatButton(
              color: Colors.white,
              child: Text('SignOut'),
              onPressed: signout,
            )
          ],
        ),

        body: Container(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Form(
                    key: formstate,
                      child: Column(
                        children: <Widget>[
                          TextFormField(
                            decoration: InputDecoration(
                              icon: Icon(Icons.person),
                              hintText: 'Name'
                            ),
                            validator: (val){
                              if(val.isEmpty){
                                return 'Enter Name Of Content';
                              }
                            },
                            onSaved: (val){
                              _name= val;
                            },
                          ),
                          TextFormField(
                            decoration: InputDecoration(
                                icon: Icon(Icons.email),
                                hintText: 'Email Address'
                            ),
                            validator: (val){
                              if(val.isEmpty){
                                return 'Enter Email Of Content';
                              }
                            },
                            onSaved: (val){
                              _email= val;
                            },
                          ),TextFormField(
                            decoration: InputDecoration(
                                icon: Icon(Icons.phone),
                                hintText: 'Mobile'
                            ),
                            validator: (val){
                              if(val.isEmpty){
                                return 'Enter Mobile Of Content';
                              }else if(val.length>14){
                                return 'your Mobile need to be atleast 14 Number';
                              }
                            },
                            onSaved: (val){
                              _mobile= val;
                            },
                          ),
                          RaisedButton(
                            color: Colors.lightBlueAccent,
                              textColor: Colors.white,
                              onPressed: addContent,
                            child: Text('Add New Content'),
                          )
                        ],
                      )),
                  ]
            )
        )
    );
  }
}