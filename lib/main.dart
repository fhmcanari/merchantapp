import 'package:backofficeapp/pages/homelayout.dart';
import 'package:backofficeapp/pages/login.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'shared/cached_helper.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  Cachehelper.init();
  await Firebase.initializeApp();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    String token = Cachehelper.getData(key: "token");

    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'canari merchant',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home:token==null?Login():HomeLayout(),
    );
  }
}

