
import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';

import '../shared/cached_helper.dart';
import 'homelayout.dart';

class OrderDetails extends StatefulWidget {
  final order_ref;
  const OrderDetails({Key key, this.order_ref}) : super(key: key);

  @override
  State<OrderDetails> createState() => _OrderDetailsState();
}

class _OrderDetailsState extends State<OrderDetails> {
  final _key = UniqueKey();
  bool locationCollected = false;
  bool isLoading = true;
  String token = Cachehelper.getData(key: "token");
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
      backgroundColor: Colors.white,
      elevation: 0,
      centerTitle: true,
      title: Text('استلام الطلب',style: TextStyle(
          color: Colors.black,
          fontWeight: FontWeight.bold,
          fontSize: 20
      ),),
      leading: InkWell(
        onTap: (){
          if (this.mounted) {
            setState(() {
              Navigator.of(context).pushAndRemoveUntil(MaterialPageRoute(builder: (context)=>HomeLayout()), (route) => false);
            });
          }
        },
        child: Icon(Icons.arrow_back,color: Colors.black),
      ),
    ),
      body: SafeArea(
        child: Stack(
          children: <Widget>[
            WebView(
              key: _key,
              initialUrl:"https://storeapp.canariapp.com/partner/${token}/oms/show/${widget.order_ref}",
              zoomEnabled: false,
              javascriptMode: JavascriptMode.unrestricted,
              javascriptChannels:<JavascriptChannel>{
                JavascriptChannel(
                  name: 'messageHandler',
                  onMessageReceived: (JavascriptMessage message) {
                  },)},
              onPageFinished: (finish){
                setState(() {
                  isLoading = false;
                });
              },
            ),
            isLoading?Center(child: CircularProgressIndicator(color: Colors.red,backgroundColor:Color(0xFFFFCDD2)))
                : Stack(children: [

            ]),

          ],
        ),
      ),
    );
  }
}
