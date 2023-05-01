import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:webview_flutter/webview_flutter.dart';
import '../../shared/cached_helper.dart';


class Create extends StatefulWidget {
  const Create({Key key}) : super(key: key);
  @override
  State<Create> createState() => _CreateState();
}

class _CreateState extends State<Create> {
  final _key = UniqueKey();
  bool isLoading=true;
  bool isCreate = false;
  @override
  Widget build(BuildContext context) {
    String token = Cachehelper.getData(key: "token");
    return Scaffold(
      backgroundColor: Color(0xfff3f4f6),
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        centerTitle: true,
        automaticallyImplyLeading: false,
        title: Text(isCreate?'اضافة طلب':'عرض طلبات مندوب',style:TextStyle(
            color: Colors.black,
            fontWeight: FontWeight.bold,
            fontSize: 20
        ),),
        iconTheme: IconThemeData(color: Colors.black),
      ),
      body:SafeArea(
        child: Stack(
          children: <Widget>[
            !isCreate?
            WebView(
              key: _key,
              initialUrl:'https://storeapp.canariapp.com/partner/${token}/store_dispatch',
              zoomEnabled: false,
              javascriptMode: JavascriptMode.unrestricted,
              javascriptChannels:<JavascriptChannel>{
                JavascriptChannel(
                  name: 'messageHandler',
                  onMessageReceived: (JavascriptMessage message) {
                    Map<String, dynamic> data = jsonDecode(message.message);
                    if(data['payload']=='PHONE_CALL'){
                      launch("tel://${data['action']}");
                    }
                    print(data);

                  },)},
              onPageFinished: (finish){
                setState(() {
                  isLoading = false;
                });
              },
            ):
            Stack(
              children: [
                WebView(
                  key: _key,
                  initialUrl:'https://storeapp.canariapp.com/partner/${token}/store_dispatch/create',
                  zoomEnabled: false,
                  javascriptMode: JavascriptMode.unrestricted,
                  javascriptChannels:<JavascriptChannel>{
                    JavascriptChannel(
                      name: 'messageHandler',
                      onMessageReceived: (JavascriptMessage message) {
                        Map<String, dynamic> data = jsonDecode(message.message);
                        if(data['action']=='CREATED_SUCCESS'){
                          setState(() {
                            isCreate = false;
                          });
                        }

                      },)},
                  onPageFinished: (finish){
                    setState(() {
                      isLoading = false;
                    });
                  },
                ),
              ],
            ),
            isCreate?
            Padding(
              padding: const EdgeInsets.only(top: 10,left: 10),
              child: GestureDetector(
                  onTap: (){
                    setState(() {
                      isCreate = false;
                    });
                  },
                  child: Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(5),
                      color: Color(0xfffafafa),
                    ),

                    child: Padding(
                      padding: const EdgeInsets.only(top: 8,left: 8,right: 8,bottom: 6),
                      child: Text('عرض طلبات مندوب',
                        style:TextStyle(
                            color:Color(0xffff7144),
                            fontSize: 13,
                            fontWeight: FontWeight.bold
                        ),),
                    ),
                  )),
            ):Padding(
              padding: const EdgeInsets.only(top: 10,left: 10),
              child: GestureDetector(
                  onTap: (){
                    setState(() {
                      isCreate = true;
                    });
                  },
                  child: Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(5),
                      color: Color(0xfffafafa),
                    ),

                    child: Padding(
                      padding: const EdgeInsets.only(top: 8,left: 8,right: 8,bottom: 6),
                      child: Text('اضافة طلب',
                        style:TextStyle(
                            color:Color(0xffff7144),
                            fontSize: 13,
                            fontWeight: FontWeight.bold
                        ),),
                    ),
                  )),
            ),
            isLoading ?Center(child: CircularProgressIndicator(color: Colors.red,backgroundColor:Color(0xFFFFCDD2)))
                : Stack(),
          ],
        ),
      ),
    );
  }
}
