import 'dart:ffi';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import './Login.dart';
import './signup.dart';


class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  User user;
  Future<Void> getuserData()async{
   User userdata = FirebaseAuth.instance.currentUser;
    setState((){
      user = userdata;
    });
  }
  final auth = FirebaseAuth.instance;
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
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('My Content App'),
        ),
        body: Container(
            child: Column(
                children: <Widget>[
                  user == null ?
                  Text('Welcome To My App') :
                  Text('Your Email is ${user.email}'),
                  Center(
                      child: user == null ? Container(
                        child:Column(
                          children:<Widget>[
                        FlatButton(
                            child: Text('Login To See Your Contacts'),
                            color: Colors.lightBlue,
                            onPressed: () {
                              Navigator.push(context,
                                  MaterialPageRoute(
                                      builder: (context) => Login()
                                  ));
                            }
                        ),
                      ]) ): Container(
                          child: Column(
                              children: <Widget>[
                                Text('welcome To Your Contacts List'),
                                Container(
                                  child: Column(
                                    children:<Widget>[
                                    FlatButton(
                                      child: Text('Login To See Your Contacts'),
                                      color: Colors.lightBlue,
                                      onPressed: () {
                                        Navigator.push(context,
                                            MaterialPageRoute(
                                                builder: (context) =>SignUp()
                                            ));
                                      }
                                  ),
                               ] )
                                )]
                          )))]
            )
        )
    );
  }
}