import 'package:flutter/material.dart';
import './Home.dart';
import './AddContent.dart';
import 'package:firebase_core/firebase_core.dart';
void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(
    MaterialApp(
      title: "My Comtent App",
      home: Home(),
      theme: ThemeData.light(),
    )
  );
}