import 'package:backofficeapp/pages/deliveries.dart';
import 'package:backofficeapp/pages/homelayout.dart';
import 'package:backofficeapp/pages/reports.dart';
import 'package:backofficeapp/pages/shifts.dart';
import 'package:flutter/material.dart';
import '../shared/cached_helper.dart';
import 'Transaction.dart';


class DrawerWidget extends StatefulWidget {
  const DrawerWidget({Key key}) : super(key: key);

  @override
  State<DrawerWidget> createState() => _DrawerWidgetState();
}

class _DrawerWidgetState extends State<DrawerWidget> {

  @override
  Widget build(BuildContext context) {

    return Directionality(
      textDirection: TextDirection.rtl,
      child: Drawer(
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
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.start,
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

              // MenuItem(context,1,'',),
              // SizedBox(height: 25,),
              // Padding(
              //   padding: const EdgeInsets.only(left: 13),
              //   child: GestureDetector(
              //     onTap: (){
              //
              //       Navigator.of(context).pushAndRemoveUntil(MaterialPageRoute(builder: (context)=>Deliveries()), (route) => route.isFirst);
              //
              //     },
              //     child: Row(
              //       mainAxisAlignment: MainAxisAlignment.start,
              //       crossAxisAlignment: CrossAxisAlignment.end,
              //       children: [
              //         Text('سجل الطلبات',style: TextStyle(fontSize: 16,fontWeight: FontWeight.bold)),
              //       ],
              //     ),
              //   ),
              // ),
              // SizedBox(height: 25,),
              // Padding(
              //   padding: const EdgeInsets.only(left: 13),
              //   child: Row(
              //     mainAxisAlignment: MainAxisAlignment.start,
              //     crossAxisAlignment: CrossAxisAlignment.end,
              //     children: [
              //       GestureDetector(
              //           onTap:(){
              //             Navigator.of(context).pushAndRemoveUntil(MaterialPageRoute(builder: (context)=>Shifts()), (route) => route.isFirst);
              //           },
              //           child: Text('الفواتير',style: TextStyle(fontSize: 16,fontWeight: FontWeight.bold))),
              //     ],
              //   ),
              // ),
              // SizedBox(height: 25,),
              // Padding(
              //   padding: const EdgeInsets.only(left: 15),
              //   child: Row(
              //     mainAxisAlignment: MainAxisAlignment.start,
              //     crossAxisAlignment: CrossAxisAlignment.end,
              //     children: [
              //       GestureDetector(
              //           onTap:(){
              //             Navigator.of(context).pushAndRemoveUntil(MaterialPageRoute(builder: (context)=>Reports()), (route) => route.isFirst);
              //           },
              //           child: Text('لوحة القيادة',style: TextStyle(fontSize: 16,fontWeight: FontWeight.bold))),
              //     ],
              //   ),
              // ),
              //
              // SizedBox(height: 25,),
              // Padding(
              //   padding: const EdgeInsets.only(left: 15),
              //   child: Row(
              //     mainAxisAlignment: MainAxisAlignment.start,
              //     crossAxisAlignment: CrossAxisAlignment.end,
              //     children: [
              //       GestureDetector(
              //           onTap:(){
              //             Navigator.of(context).pushAndRemoveUntil(MaterialPageRoute(builder: (context)=>TransactionScreen()), (route) => route.isFirst);
              //           },
              //           child: Text('تحويلات',style: TextStyle(fontSize: 16,fontWeight: FontWeight.bold))),
              //     ],
              //   ),
              // ),
            ],
          ),
        ),
      ),
    );
  }

  Widget MenuItem(BuildContext context,int id,String title,bool selected) {
    return Padding(
              padding: const EdgeInsets.only(left: 13),
              child: GestureDetector(
                onTap: (){
                  Navigator.of(context).pushAndRemoveUntil(MaterialPageRoute(builder: (context)=>HomeLayout()), (route) => route.isFirst);
                },
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    Text('الطلبات اليوم',style: TextStyle(fontSize: 16,fontWeight: FontWeight.bold,)),
                  ],
                ),
              ),
            );
  }

}



enum DrawerSections {
  homelayout,
  deliveries,
  shift,
  raports,
  transaction,
}