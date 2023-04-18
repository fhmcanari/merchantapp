import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';

import '../shared/cached_helper.dart';
import 'drawer_widget.dart';

class DetailsPage extends StatefulWidget {
  final orderId;
  final action;
  final title;
   DetailsPage({Key key, this.orderId,this.action, this.title}) : super(key: key);

  @override
  State<DetailsPage> createState() => _DetailsPageState();
}

class _DetailsPageState extends State<DetailsPage> {
  bool isLoading=true;
  final _key = UniqueKey();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Color(0xfff3f4f6),
        appBar: AppBar(
          backgroundColor: Colors.white,
          elevation: 0,
          centerTitle: true,
          automaticallyImplyLeading: false,
          title: Text('${widget.title}',style: TextStyle(
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
                initialUrl:'https://storeapp.canariapp.com/partner/${Cachehelper.getData(key: "token")}/${widget.action}/show/${widget.orderId}',
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
              isLoading ?Center(child: CircularProgressIndicator(color: Colors.red,backgroundColor:Color(0xFFFFCDD2)))
                  : Stack(),
            ],
          ),
        ),
      );
  }
}
