import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';
import '../shared/cached_helper.dart';
import 'drawer_widget.dart';

class Deliveries extends StatefulWidget {
  const Deliveries({Key key}) : super(key: key);

  @override
  State<Deliveries> createState() => _DeliveriesState();
}

class _DeliveriesState extends State<Deliveries> {
  final _key = UniqueKey();
  bool isLoading=true;
  String token = Cachehelper.getData(key: "token");
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      endDrawer:DrawerWidget(),
      backgroundColor: Color(0xfff3f4f6),
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        automaticallyImplyLeading: false,
        centerTitle: true,
        title: Text('سجل الطلبات',style: TextStyle(
            color: Colors.black,
            fontWeight: FontWeight.bold,
            fontSize: 20
        ),),
        iconTheme: IconThemeData(color: Colors.black),
      ),
      body: SafeArea(
        child: Stack(
          children: <Widget>[
            WebView(
              key: _key,
              initialUrl:'https://storeapp.canariapp.com/partner/${token}/orders',
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
