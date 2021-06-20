import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'file:///D:/ameer/teach_me/lib/AppManagment/StudentsScreens/CoursesScreens/Courses_in_Category_Screen.dart';
import 'file:///D:/ameer/teach_me/lib/AppManagment/StudentsScreens/CoursesScreens/Show_Video_From_Course_Screen.dart';

import 'package:teach_me/UserManagment/StudentManagment/Student.dart';
import 'package:teach_me/AppManagment/routes/pageRouter.dart';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';

// ignore: must_be_immutable
class CourseDetailsScreen extends StatefulWidget {

  String name;
  int coursescount;
  Student student;
  GoogleSignIn googleSignIn;
  QuerySnapshot<Map<String, dynamic>> resultcat;
  Map<String, dynamic> course;



  CourseDetailsScreen(this.student,this.googleSignIn,this.name,this.coursescount,this.resultcat,this.course);



  @override
  _CourseDetailsScreenState createState() => _CourseDetailsScreenState();
}

class _CourseDetailsScreenState extends State<CourseDetailsScreen> {
  bool _ispressed=false;
  YoutubePlayerController _controller;









  @override
  void setState(fn) {
    // TODO: implement setState
    super.setState(fn);

  }

  @override
  Widget build(BuildContext context) {



      return Scaffold(
        body: Container(
      height: MediaQuery.of(context).size.height,
      width:  MediaQuery.of(context).size.width,

      decoration: BoxDecoration(
        color: Color(0xFF90CAF9),
        image: DecorationImage(


          image: AssetImage('assets/images/download.jpg'),
          alignment: Alignment.topRight


        )
      ),
      child:   YoutubePlayerBuilder(onEnterFullScreen: (){

      },player: YoutubePlayer(controller: _controller,), builder:(context,player){ return Column(
        children: [
          Padding(
            padding: EdgeInsets.only(left: 20,top: 50,right: 20),
            child: Column(
              children: <Widget>[
                Row(
                  children: <Widget>[
                    IconButton(
                        icon: const Icon(Icons.arrow_back),
                        iconSize: 50,
                        onPressed: () {
                          Navigator.of(context).pushReplacement(SlideRightRoute(
                              page:CourseCategoryPage(widget.student,widget.googleSignIn,this.widget.name,this.widget.coursescount, widget.resultcat)
                          ));

                        }

                    ),

                  ],
                ),
                SizedBox(height: 46,),

                   Text(this.widget.course["CourseName"],style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,fontSize: 30
                  ),),

                Row(
                  children: <Widget>[
                    Icon(
                        Icons.person
                    ),
                    SizedBox(width: 2,),
                    Text('10K'),
                    SizedBox(width: 15,),
                    Icon(Icons.star_border),
                    Text("4.5")
                  ],

                ),
                SizedBox(height: 20,),
                Row(
                  children: [
                    RichText(text: TextSpan(

                      children:[
                        TextSpan(
                            text: "\$50",
                            style: TextStyle(fontSize: 32)
                        ),
                        TextSpan(
                            text: "\$70",style: TextStyle(
                            color: Colors.black87.withOpacity(0.5),
                            decoration: TextDecoration.lineThrough
                        )
                        )
                      ] ,

                    )),
                  ],
                )
              ],
            ),
          ),
          Expanded(
            child: Container(
              height:double.infinity,

              width: double.infinity,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(50),
                color: Colors.white
              ),
              child: Padding(padding: EdgeInsets.all(30),child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Text("Course content",style: TextStyle(
                    fontWeight: FontWeight.bold,fontSize: 20
                  ),),
                  SizedBox(height: 20,),
                Flexible(
                  flex: 1,
                  child: this.widget.course["videoscount"]==0?Center(child: Text("No Video Found")):ListView.builder(
                    itemCount: this.widget.course["videoscount"],
                         // shrinkWrap: true,
                        itemBuilder: (context, position) {





                        int number=0;
                        String videoId;
                        videoId = YoutubePlayer.convertUrlToId(this.widget.course["Videos"][position]);










                          return Column(
                            children: [
                              Container(
                                decoration: BoxDecoration(
                                  border:Border(bottom: BorderSide(
                                    color: Colors.black26,
                                    width: 1.0,
                                  ))
                                ),

                                child: Padding(


                                  padding: const EdgeInsets.all(8.0),
                                  child: Row(
                                      mainAxisAlignment: MainAxisAlignment.spaceBetween, children:<Widget>[
                                      Row(
                                        children: [
                                          Text("${position<9?number:''}${position+1}",style: TextStyle(
                                              fontWeight: FontWeight.bold,fontSize: 32
                                          ),
                                          ),
                                          SizedBox(width: 20,),
                                          Column(
                                            crossAxisAlignment: CrossAxisAlignment.start,
                                            mainAxisAlignment: MainAxisAlignment.start,

                                            children: <Widget>[
                                              Text("${this.widget.course["Titles"][position]}")
                                              ,
                                              Text("5.25 mins",style: TextStyle(
                                                  fontSize: 15,
                                                  color: Colors.black26
                                              ),),
                                            ],
                                          ),
                                        ],
                                      ),



                                      GestureDetector(
                                        onTap: (){
                                          Navigator.of(context).push(
                                              SlideRightRoute(
                                                  page: ShowVideoFromCourse(videoId,this.widget.course)
                                              ));


                                        },
                                        child: Container(
                                          width: 40,
                                          height: 40,
                                          decoration: BoxDecoration(
                                              shape:BoxShape.circle
                                              ,color: Colors.greenAccent.withOpacity(true?1:0.5)
                                          ),
                                          child: Icon(Icons.play_arrow,color: Colors.white,),
                                        ),
                                      )

                                    ],
                                  ),
                                ),
                              ),
                               // _ispressed?YoutubePlayer(controller: _controller,liveUIColor: Colors.amber,):Container

                              //  YoutubePlayer(controller: _controller,liveUIColor: Colors.amber,
                              // //   progressIndicatorColor: Colors.white,
                              // ),

                              Container(
                                decoration: BoxDecoration(
                                    border:Border(bottom: BorderSide(
                                      color: Colors.black26,
                                      width: 1.0,
                                    ))
                                ),
                                height: 10,
                              ),
                            ],
                          );
                        },
                  ) )


                 //    ListView.builder(
                 //      // shrinkWrap: true,
                 //     itemBuilder: (context, position) {
                 //       return Card(
                 //         child: Padding(
                 //           padding: const EdgeInsets.all(16.0),
                 //           child: Text(position.toString(), style: TextStyle(fontSize: 22.0),),
                 //         ),
                 //       );
                 //     },
                 //            )
                 //
                 //
                 //
                 //
                 //
                 //


                  // StaggeredGridView.countBuilder(crossAxisCount: 1,itemCount: this.course["videocount"],mainAxisSpacing: 20, itemBuilder: (context,index){
                  //
                  //   return GestureDetector(
                  //     onTap: (){
                  //
                  //       Navigator.of(context).pushReplacement(SlideRightRoute(
                  //
                  //           // page: CourseDetailsScreen(student,googleSignIn,this.name,this.coursescount,this.catcourses,this.catcourses.docs.elementAt(index).data())
                  //       ));
                  //     },
                  //     child:  CourseContent(number: "${++index}",duration: 3.25,title: this.course["Titles"][index],),
                  //
                  //   );
                  // }, staggeredTileBuilder: (index)=>StaggeredTile.fit(1)),
                  // SingleChildScrollView(
                  //   child: ListView.separated(
                  //     itemBuilder: (context, position) {
                  //       return ListTile(onTap: (){
                  //         setState(() {_ispressed=!_ispressed;});
                  //       },leading: CourseContent(number: "${++position}",duration: 3.25,title: this.widget.course["Titles"][position],));
                  //     },
                  //     separatorBuilder: (context, position) {
                  //       return Container();
                  //     },
                  //     itemCount: 1,
                  //   ),
                  // ),


                  //
                  // CourseContent(number: "01",duration: 5.25,title: "Welcome to the Course",isDone: true,),
                  // SizedBox(height: 5,),
                  //
                  //
                  //
                  //
                  // CourseContent(number: "02",duration: 3.25,title: "Welcome to second",),
                  // SizedBox(height: 5,),
                  // CourseContent(number: "03",duration: 4.55,title: "Welcome to the third",),
                  // SizedBox(height: 5,),
                  // CourseContent(number: "04",duration: 5.55,title: "Welcome to the four",),
                  // SizedBox(height: 5,),
                  // CourseContent(number: "05",duration: 2.25,title: "Welcome to the intro",),
                  // SizedBox(height: 5,),
                  // CourseContent(number: "01",duration: 5.25,title: "Welcome to the Course",isDone: true,),
                  // SizedBox(height: 5,),
                  // CourseContent(number: "02",duration: 3.25,title: "Welcome to second",),
                  // SizedBox(height: 5,),
                  // CourseContent(number: "03",duration: 4.55,title: "Welcome to the third",),
                  // SizedBox(height: 5,),
                  // CourseContent(number: "04",duration: 5.55,title: "Welcome to the four",),
                  // SizedBox(height: 5,),
                  // CourseContent(number: "05",duration: 2.25,title: "Welcome to the intro",),
                  // CourseContent(number: "01",duration: 5.25,title: "Welcome to the Course",isDone: true,),
                  // SizedBox(height: 5,),
                  // CourseContent(number: "02",duration: 3.25,title: "Welcome to second",),
                  // SizedBox(height: 5,),
                  // CourseContent(number: "03",duration: 4.55,title: "Welcome to the third",),
                  // SizedBox(height: 5,),
                  // CourseContent(number: "04",duration: 5.55,title: "Welcome to the four",),
                  // SizedBox(height: 5,),
                  // CourseContent(number: "05",duration: 2.25,title: "Welcome to the intro",),
                ],

              ),),
            ),
          ),
          // Positioned(
          //   right: 0,
          //   left: 0,
          //   bottom: 0,
          //   child: Container(
          //     padding: EdgeInsets.all(20),
          //
          //     height: 100,
          //     width: double.infinity,
          //     decoration: BoxDecoration(
          //         color: Colors.white,
          //         borderRadius: BorderRadius.circular(40),
          //         boxShadow: [BoxShadow(
          //             offset: Offset(0,4),
          //             blurRadius: 50,
          //             color: Colors.black26
          //         )]
          //     ),
          //     child: Row(
          //       children: <Widget>[
          //         Container(
          //           padding: EdgeInsets.all(14),
          //           height: 56,
          //           width: 80,
          //           decoration: BoxDecoration(
          //               color: Color(0xFFFFEDEE),
          //               borderRadius: BorderRadius.circular(40)
          //           ),
          //           child: Icon(Icons.shopping_bag_outlined),
          //         ),
          //         SizedBox(width: 20,),
          //         Expanded(
          //             child:Container(
          //               alignment: Alignment.center,
          //               height: 56,
          //               decoration: BoxDecoration(
          //                   borderRadius: BorderRadius.circular(40)
          //                       ,color: Colors.pinkAccent
          //               ),
          //               child: Text(
          //                 "Enroll Now",style: TextStyle(
          //                   color: Colors.white,
          //                   fontWeight: FontWeight.bold
          //               ),
          //               ),
          //             ))
          //       ],
          //     ),
          //   ),
          // )

        ],
      );}),

    ));
  }
}


class CourseContent extends StatelessWidget {
  final String number;
  final double duration;
  final String title;
  final bool isDone;

  const CourseContent({Key key, this.number, this.duration, this.title,this.isDone=false}) : super(key: key);





  @override
  Widget build(BuildContext context) {
    return Row(
      children:<Widget>[
        Text(number,style: TextStyle(
            fontWeight: FontWeight.bold,fontSize: 32
        ),
        ),SizedBox(width: 20,),
        RichText(text:TextSpan(
            children: [
              TextSpan(text: "$duration mins\n",style: TextStyle(
                  fontSize: 15,
                  color: Colors.black26
              )),TextSpan(text: title),

            ]
        ),),
        Spacer(),
        Container(
          margin: EdgeInsets.only(left: 20),
          width: 40,
          height: 40,
          decoration: BoxDecoration(
              shape:BoxShape.circle
              ,color: Colors.greenAccent.withOpacity(isDone?1:0.5)
          ),
          child: Icon(Icons.play_arrow,color: Colors.white,),
        )

      ],
    );
  }
}
