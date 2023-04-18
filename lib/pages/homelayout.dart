import 'dart:async';
import 'dart:convert';
import 'dart:typed_data';
import 'package:backofficeapp/pages/detailsPage.dart';
import 'package:backofficeapp/pages/order_details.dart';
import 'package:backofficeapp/pages/reports.dart';
import 'package:backofficeapp/pages/shifts.dart';
import 'package:backofficeapp/pages/summry.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:webview_flutter/webview_flutter.dart';
import '../shared/cached_helper.dart';
import 'Transaction.dart';
import 'deliveries.dart';
import 'drawer_widget.dart';
import 'orders.dart';
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
  var currentPage = DrawerSections.homelayout;
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
    var container;
    if (currentPage == DrawerSections.homelayout) {
      container = Orders();
    } else if (currentPage == DrawerSections.deliveries) {
      container = Deliveries();
    } else if (currentPage == DrawerSections.raports) {
      container = Reports();
    } else if (currentPage == DrawerSections.shift) {
      container = Shifts();
    } else if (currentPage == DrawerSections.transaction) {
      container = TransactionScreen();
    }
    return Scaffold(
      endDrawer:Drawer(
        child: Padding(
          padding: const EdgeInsets.only(left: 15,right: 20),
          child: ListView(
            padding: EdgeInsets.only(top: 100),
            children: [
              // SizedBox(height: 80,),
              Padding(
                padding: const EdgeInsets.only(left: 10),
                child: Align(
                  alignment: Alignment.topRight,
                  child: CircleAvatar(
                    maxRadius: 30,
                    backgroundColor: Colors.grey[300],
                    backgroundImage:NetworkImage('${Cachehelper.getData(key: "logo")}'),
                  ),
                ),
              ),
              SizedBox(height: 10),
              Padding(
                padding: const EdgeInsets.only(left: 15),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    Text('${Cachehelper.getData(key: "name")}',style: TextStyle(fontWeight: FontWeight.bold,fontSize: 16),),
                    Text('${Cachehelper.getData(key: "email")}',style: TextStyle(fontWeight: FontWeight.bold,fontSize: 11,color: Colors.grey),),
                  ],),
              ),
              SizedBox(height: 20,),
              Padding(
                padding: const EdgeInsets.only(right: 0),
                child: Container(
                  height: 0.4,
                  width: double.infinity,
                  color: Color(0xFFD1D1D1),
                ),
              ),
              SizedBox(height: 30,),
              MyDrawerList(),
            ],
          ),
        ),
      ),
      body:container
    );
  }
  Widget MyDrawerList() {
    return Container(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          menuItem(1, "الطلبات اليوم",
              currentPage == DrawerSections.homelayout ? true : false),
          SizedBox(height: 10,),
          menuItem(2, "سجل الطلبات",
              currentPage == DrawerSections.deliveries ? true : false),
          SizedBox(height: 10,),
          menuItem(4, "لوحة القيادة",
              currentPage == DrawerSections.raports ? true : false),
          menuItem(3, "الفواتير",
              currentPage == DrawerSections.shift ? true : false),
          SizedBox(height: 10,),
          menuItem(5, "تحويلات",
              currentPage == DrawerSections.transaction ? true : false),
        ],
      ),
    );
  }
  Widget menuItem(int id, String title, bool selected) {
    return Container(
      height:50,
      decoration: BoxDecoration(
        color: selected ?  Color(0xFFfb133a) : Colors.grey[50],
        borderRadius: BorderRadius.circular(5),
      ),

      child: InkWell(
        onTap: () {
          Navigator.pop(context);
          setState(() {
            if (id == 1) {
              currentPage = DrawerSections.homelayout;
            } else if (id == 2) {
              currentPage = DrawerSections.deliveries;
            } else if (id == 3) {
              currentPage = DrawerSections.shift;
            } else if (id == 4) {
              currentPage = DrawerSections.raports;
            } else if (id == 5) {
              currentPage = DrawerSections.transaction;
            }
          });
        },
        child:Padding(
          padding: const EdgeInsets.only(left: 15,right: 15),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.end,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Text(title,style: TextStyle(fontSize: 16,fontWeight: FontWeight.bold,color:  selected ?  Colors.white : Colors.black)),
            ],
          ),
        ),
      ),
    );
  }
}
