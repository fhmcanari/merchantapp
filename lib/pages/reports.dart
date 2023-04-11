import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';
import '../shared/cached_helper.dart';
import 'drawer_widget.dart';

class Reports extends StatefulWidget {
  const Reports({Key key}) : super(key: key);

  @override
  State<Reports> createState() => _ReportsState();
}

class _ReportsState extends State<Reports> {
  final _key = UniqueKey();
  bool isLoading=true;
  @override
  Widget build(BuildContext context) {
    String token = Cachehelper.getData(key: "token");
    return Scaffold(
      endDrawer:DrawerWidget(),
      backgroundColor: Color(0xfff3f4f6),
      appBar: AppBar(
        backgroundColor: Colors.white,
         elevation: 0,
        centerTitle: true,
        automaticallyImplyLeading: false,
        title: Text('لوحة القيادة',style: TextStyle(
          color: Colors.black,
          fontWeight: FontWeight.bold,
          fontSize: 20
        ),),
        iconTheme: IconThemeData(color: Colors.black),
      ),
      body:SafeArea(
          child: Stack(
            children: <Widget>[
              WebView(
                key: _key,
                initialUrl:'https://storeapp.canariapp.com/partner/${token}/dashboard',
                zoomEnabled: false,
                javascriptMode: JavascriptMode.unrestricted,
                onPageFinished: (finish){
                  setState(() {
                    isLoading = false;
                  });
                },
              ),
              isLoading ?LinearProgressIndicator(color: Colors.red,backgroundColor:Color(0xFFFFCDD2))
                  : Stack(),
            ],
          ),
        ),
    );
  }
}
