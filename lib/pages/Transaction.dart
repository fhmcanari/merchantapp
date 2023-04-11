import 'dart:convert';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';
import '../shared/cached_helper.dart';
import 'drawer_widget.dart';


class TransactionScreen extends StatefulWidget {
  const TransactionScreen({Key key}) : super(key: key);

  @override
  State<TransactionScreen> createState() => _TransactionScreenState();
}

class _TransactionScreenState extends State<TransactionScreen> {
  final _key = UniqueKey();
  bool isLoading=true;
  @override
  Widget build(BuildContext context) {
    String token = Cachehelper.getData(key: "token");
    return Scaffold(
      endDrawer:DrawerWidget(),
      appBar: AppBar(
        elevation: 0,
        centerTitle: true,
        automaticallyImplyLeading: false,
        backgroundColor: Colors.white,
        title: Text('تحويلات',style: TextStyle(
            color: Colors.black,
            fontWeight: FontWeight.bold
        ),),
        iconTheme: IconThemeData(color: Colors.black),
      ),
      body: SafeArea(
        child: Stack(
          children: <Widget>[
            WebView(
              key: _key,
              initialUrl:'https://storeapp.canariapp.com/partner/${token}/transactions',
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
