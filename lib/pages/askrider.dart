import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';
import '../shared/cached_helper.dart';
import 'drawer_widget.dart';

class Askrider extends StatefulWidget {
  const Askrider({Key key}) : super(key: key);

  @override
  State<Askrider> createState() => _AskriderState();
}

class _AskriderState extends State<Askrider> {
  final _key = UniqueKey();
  bool isLoading=true;
  String token = Cachehelper.getData(key: "token");
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      endDrawer:DrawerWidget(),
      backgroundColor: Color(0xfff3f4f6),
      appBar: AppBar(
        automaticallyImplyLeading: false,
        backgroundColor: Colors.white,
        elevation: 0,
        centerTitle: true,
        title: Text('اطلب Canaries',style: TextStyle(
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
              initialUrl:'https://storeapp.canariapp.com/partner/${token}/askrider',
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
