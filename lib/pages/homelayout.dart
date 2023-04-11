import 'dart:async';
import 'dart:convert';
import 'dart:typed_data';
import 'package:backofficeapp/pages/summry.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:webview_flutter/webview_flutter.dart';
import '../shared/cached_helper.dart';
import 'drawer_widget.dart';
import 'package:audioplayers/audioplayers.dart';
Future<void>firebaseMessagingBackgroundHandler(RemoteMessage message)async{
  if (message.notification!=null) {
      print('firebaseMessagingBackgroundHandler');
      // showLocalNotification('Yay you did it!','Congrats on your first local notification');
  }
}

class HomeLayout extends StatefulWidget {
  const HomeLayout({Key key}) : super(key: key);
  @override
  State<HomeLayout> createState() => _HomeLayoutState();
}
class _HomeLayoutState extends State<HomeLayout> {
  var fbm = FirebaseMessaging.instance;
  final _key = UniqueKey();
  bool isLoading=true;
  String token = Cachehelper.getData(key: "token");

  @override
  void initState() {
    FirebaseMessaging.instance.getInitialMessage();

    FirebaseMessaging.onMessage.listen((message){
      if (message.notification!=null){
         Map<String, dynamic> jsonMap = jsonDecode(message.data['payload']);
          final order_ref = jsonMap['id'];
        print(message.notification.body);
        print(message.data);

        showModalBottomSheet(
          backgroundColor: Color(0xFFfb133a),
            enableDrag: false,
            isDismissible: false,
            isScrollControlled: true,
            context: context, builder: (context){
          return Summry(order_ref: order_ref,);
            });
        // showLocalNotification('Yay you did it!','Congrats on your first local notification');
      }
    },);

    FirebaseMessaging.onMessageOpenedApp.listen((message) {
      if (message.notification!=null){
        Map<String, dynamic> jsonMap = jsonDecode(message.data['payload']);
        final order_ref = jsonMap['id'];
        showModalBottomSheet(
            backgroundColor: Color(0xFFfb133a),
            enableDrag: false,
            isDismissible: false,
            isScrollControlled: true,
            context: context, builder: (context){
          return Summry(order_ref: order_ref,);
        });
        // Navigator.of(context).pushAndRemoveUntil(MaterialPageRoute(builder: (context)=>HomeLayout()), (route) => route.isFirst);
        // showLocalNotification('Yay you did it!','Congrats on your first local notification');
      }
    });


    fbm.getToken();
    super.initState();
  }


  @override
  Widget build(BuildContext context){
    return Scaffold(
      endDrawer:DrawerWidget(),
      appBar: AppBar(
        automaticallyImplyLeading: false,
        backgroundColor: Colors.white,
        elevation: 0,
        centerTitle: true,
        title: Text('الطلبات اليوم',style: TextStyle(
            color: Colors.black,
            fontWeight: FontWeight.bold,
            fontSize: 20
        ),),
        iconTheme: IconThemeData(color: Colors.black),
      ),
      body: SafeArea(
        child:
        Stack(
          children: <Widget>[
           
            WebView(
              key: _key,
              initialUrl:'https://storeapp.canariapp.com/partner/${token}/oms',
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
