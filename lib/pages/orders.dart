import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:webview_flutter/webview_flutter.dart';
import '../main.dart';
import '../shared/cached_helper.dart';
import 'drawer_widget.dart';

class Orders extends StatefulWidget {
  const Orders({Key key}) : super(key: key);

  @override
  State<Orders> createState() => _OrdersState();
}

class _OrdersState extends State<Orders> {
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
        title: Text('سجل الطلبات',style: TextStyle(
            color: Colors.black,
            fontWeight: FontWeight.bold,
            fontSize: 20
        ),),
        iconTheme: IconThemeData(color: Colors.black),
      ),
      body:
      SafeArea(
        child: Stack(
          children: <Widget>[
            WebView(
              key: _key,
              initialUrl:'https://storeapp.canariapp.com/partner/${token}/orders',
              zoomEnabled: false,
              javascriptMode: JavascriptMode.unrestricted,
              javascriptChannels:<JavascriptChannel>{
                JavascriptChannel(
                  name: 'messageHandler',
                  onMessageReceived: (JavascriptMessage message) {
                     Map<String, dynamic> data = jsonDecode(message.message);
                    print(data);
                    setState(() {

                    });
                  },)},
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
