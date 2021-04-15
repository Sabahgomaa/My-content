import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:mycontent/Home.dart';
import 'package:mycontent/Dashboard.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
class SignUp extends StatefulWidget {
  @override

  State<StatefulWidget> createState(){
    return SignUpState();
  }
}

class SignUpState extends State<SignUp> {
  final GlobalKey <FormState> formState = GlobalKey<FormState>();
  String email ,Password;
  Future <void>  Signup() async{
    final formdata = formState.currentState ;
    if(formdata.validate()) {
      formdata.save();
      UserCredential fireauth =
        await FirebaseAuth.instance
            .createUserWithEmailAndPassword(email: email, password: Password);
      fireauth.user.sendEmailVerification();
        Navigator.of(context).pushAndRemoveUntil(
            MaterialPageRoute(builder: (context)=> Dasboard()),
            (Route <dynamic> route)=>false
        );
    }
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Login'),
      ),
      body: ListView(
          children:<Widget>[
            Container(
              padding: EdgeInsets.all(10),
              child: Column(
                children: <Widget>[
                  Form(child: Container(child: Column(
                    children: [
                      TextFormField(
                        obscureText: false,
                        decoration: InputDecoration(
                            icon: Icon(Icons.email),
                            hintText: 'EmailAdress'
                        ),
                        validator:  (val){
                          if(val.isEmpty){
                            return "pleace enter your email";
                          }
                        },
                        onSaved: (val){

                        },
                      ),
                      TextFormField(
                        obscureText: true,
                        decoration: InputDecoration(
                            icon: Icon(Icons.vpn_key),
                            hintText: 'Password'
                        ),
                        validator: (val){
                          if(val.isEmpty){
                            return ("pleace enter your email");
                          }else if (val.length<3){
                            return ('your Password need to be at least');
                          }
                        },
                        onSaved: (val){
                          Password=val;
                        },
                      ),
                      RaisedButton(
                        color:Colors.lightBlue,
                        textColor: Colors.white,
                        onPressed:Signup,
                        child: Text('SignUp') ,
                      )
                    ],
                  ),))
                ],
              ),
            )
          ]
      ),
    );
  }
}

