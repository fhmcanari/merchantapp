import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';
import '../shared/cached_helper.dart';
import 'drawer_widget.dart';

class Shifts extends StatefulWidget {
  const Shifts({Key key}) : super(key: key);

  @override
  State<Shifts> createState() => _ShiftsState();
}

class _ShiftsState extends State<Shifts> with SingleTickerProviderStateMixin{
  final _key = UniqueKey();
  bool isLoading=true;
  TabController tabcontroller;
  @override
  void initState() {
    tabcontroller  = TabController(length: 2, vsync: this);
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    String token = Cachehelper.getData(key: "token");
    return Scaffold(
      endDrawer:DrawerWidget(),
      backgroundColor: Color(0xfff3f4f6),
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        automaticallyImplyLeading: false,
        centerTitle: true,
        title: Text('الفواتير',style: TextStyle(
            color: Colors.black,
            fontWeight: FontWeight.bold,
            fontSize: 20
        ),),
        iconTheme: IconThemeData(color: Colors.black),
      ),
      body:Stack(
        children: <Widget>[
          WebView(
            key: _key,
            initialUrl:'https://storeapp.canariapp.com/partner/${token}/invoices',
            zoomEnabled: false,
            javascriptMode: JavascriptMode.unrestricted,
            onPageFinished: (finish){
              setState(() {
                isLoading = false;
              });
            },
          ),
          isLoading ? LinearProgressIndicator(color: Colors.red,backgroundColor:Color(0xFFFFCDD2))
              : Stack(),
        ],
      ),
    );
  }
}
