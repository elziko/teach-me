

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';

class ShowVideoFromCourse extends StatefulWidget {
  String videoid;
  Map<String, dynamic> course;

  ShowVideoFromCourse(this.videoid,this.course);
  @override
  _ShowVideoFromCourseState createState() => _ShowVideoFromCourseState();
}

class _ShowVideoFromCourseState extends State<ShowVideoFromCourse> {





  @override
  Widget build(BuildContext context) {


   YoutubePlayerController _controller = YoutubePlayerController(
      initialVideoId: this.widget.videoid,
      flags: YoutubePlayerFlags(
          autoPlay :false
      ),
    );
return YoutubePlayerBuilder(player: YoutubePlayer(controller: _controller,), builder: (context,player){
    return Scaffold(
      body:  Container(
       
        width: double.infinity,
        child:
           Center(child: Column(
             mainAxisAlignment: MainAxisAlignment.center,
             children: <Widget>[
               TextButton(onPressed: (){
                 Navigator.pop(context);
               }, child: Text("Back",style: TextStyle(
                 fontSize: 30,
                 color: Colors.black,
                 fontWeight: FontWeight.bold
               ),)),
               SizedBox(height: 20,),
               player
             ],










           ))

      )
    );});
  }
}
