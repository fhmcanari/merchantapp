import 'dart:async';
import 'dart:typed_data';
import 'package:audioplayers/audioplayers.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'homelayout.dart';
import 'order_details.dart';


class Summry extends StatefulWidget {
  final order_ref;
  const Summry({Key key, this.order_ref,}) : super(key: key);

  @override
  State<Summry> createState() => _SummryState();
}

class _SummryState extends State<Summry> {

  AudioPlayer audioPlayer = AudioPlayer();
  String audioasset = "assets/iphone.mp3";
  bool isplaying = false;
  bool audioplayed = false;
  Uint8List audiobytes;

  void playAudio() async{
    int timesPlayed = 0;
    const timestoPlay = 3;
     await audioPlayer.playBytes(audiobytes).then((player) {
      audioPlayer.onPlayerCompletion.listen((event) {
        timesPlayed++;
        if (timesPlayed >= timestoPlay) {
          timesPlayed = 0;
          audioPlayer.stop();
        } else {
          audioPlayer.resume();
        }
      });
    });

  }




  void stopAudio() async{
    int result = await audioPlayer.stop();
    if(result == 1){ //play success
      print("audio is stoping");
    }else{
      print("Error while stop audio.");
    }
  }

  @override
  void dispose() {
    audioPlayer.dispose();
    super.dispose();
  }

  static const maxSeconds = 20;
  int seconds = maxSeconds;
  Timer timer;


  void start(){
   timer = Timer.periodic(Duration(seconds:1), (_) {
     if(seconds>0){
       seconds--;
       setState(() {

       });
     }else if(seconds==0){
       if (this.mounted) {
         setState(() {
           stop();
           stopAudio();
           Navigator.of(context).pushAndRemoveUntil(MaterialPageRoute(builder: (context)=>HomeLayout()), (route) => false);
         });
       }
     }
   });
  }

  void stop(){
    if (this.mounted) {
      setState(() {
        timer.cancel();
      });
    }
  }



  @override
  void initState() {
    start();
    Future.delayed(Duration.zero, () async {
      ByteData bytes = await rootBundle.load(audioasset);
      audiobytes = bytes.buffer.asUint8List(bytes.offsetInBytes, bytes.lengthInBytes);
    }).then((value) {
      playAudio();
    });

    super.initState();
  }


  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Text('طلب جديد',style: TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 35,
            color: Colors.white
        ),),
        SizedBox(height: 40,),
        Container(
          height: 200,
          width: 200,
          decoration: BoxDecoration(
              color: Color(0xFFe41f40),
            shape: BoxShape.circle,
            boxShadow: [
              BoxShadow(
                color: Colors.redAccent,
                spreadRadius: 3,
                blurRadius: 2,
                offset: Offset(1,2),
              )
            ]
          ),
          child: Stack(
            fit: StackFit.expand,
            children: [
              CircularProgressIndicator(
                value: 1 - seconds / maxSeconds,
                valueColor:AlwaysStoppedAnimation(Color(0xFFfb133a)),
                backgroundColor: Colors.redAccent,
              ),
              Center(
                child: Text('${seconds}',style: TextStyle(
                    fontWeight: FontWeight.bold,
                    color:Colors.white,
                    fontSize: 40
                ),),
              ),
            ],
          ),
        ),
        SizedBox(height: 50,),
        Padding(
          padding: const EdgeInsets.only(left: 30,right: 30),
          child: GestureDetector(
            onTap: (){
              stopAudio();
              stop();
              Navigator.of(context).pushAndRemoveUntil(MaterialPageRoute(builder: (context)=>OrderDetails(
                order_ref: widget.order_ref,
              )), (route) => route.isFirst);
            },
            child: Container(
              height: 60,
              width: 200,
              child: Center(child: Text('عرض طلب',style: TextStyle(color: Colors.white,fontWeight: FontWeight.bold,fontSize: 22),textAlign:TextAlign.center)),
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(8),
                  border: Border.all(
                      color: Colors.white,
                      width: 1.8
                  )
              ),

            ),
          ),
        ),
      ],
    );
  }
}


