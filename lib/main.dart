import 'package:firebase_core/firebase_core.dart';
import 'package:firebasepractice/AddProduct.dart';
import 'package:firebasepractice/GoogleMapExample.dart';
import 'package:firebasepractice/ViewProduct.dart';
import 'package:flutter/material.dart';

Future<void> main()  async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(

        primarySwatch: Colors.blue,
      ),
      home: GoogleMapExample(),
    );
  }
}


