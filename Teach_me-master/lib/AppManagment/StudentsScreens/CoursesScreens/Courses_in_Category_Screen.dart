import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'file:///D:/ameer/teach_me/lib/AppManagment/StudentsScreens/CoursesScreens/Courses_Home_Screen.dart';
import 'package:teach_me/AppManagment/Constants/constants.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:teach_me/DBManagment/Category.dart';
import 'package:teach_me/UserManagment/StudentManagment/Student.dart';
import 'package:teach_me/AppManagment/routes/pageRouter.dart';

import 'Course_Details_Screen.dart';




class CourseCategoryPage extends StatefulWidget {
  String name;
  int coursescount;
  QuerySnapshot<Map<String, dynamic>> catcourses;

  GoogleSignIn googleSignIn;

Student student;


CourseCategoryPage(this.student,this.googleSignIn,this.name,this.coursescount,this.catcourses);

  @override
  _CourseCategoryPageState createState() => _CourseCategoryPageState(this.student,this.googleSignIn,this.name,this.coursescount,this.catcourses);
}

class _CourseCategoryPageState extends State<CourseCategoryPage> {

  GoogleSignIn googleSignIn;
  String name;
  int coursescount;
  QuerySnapshot<Map<String, dynamic>> catcourses;


  Student student;
  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();


  _CourseCategoryPageState(this.student,this.googleSignIn,this.name,this.coursescount,this.catcourses);



  @override
  Widget build(BuildContext context) {


    return Scaffold(
      key: _scaffoldKey,
      body: Container(
        height: MediaQuery.of(context).size.height,
        width:  MediaQuery.of(context).size.width,

        decoration: MainBoxDecorationStyle,
        child: Padding(
          padding: EdgeInsets.only(left: 20,top: 30,right: 20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            // mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              IconButton(
                  icon: const Icon(Icons.arrow_back),
                  iconSize: 30,
                  onPressed: () async{


                    _scaffoldKey.currentState.showSnackBar(
                        new SnackBar(duration: new Duration(seconds: 3), content:
                        new Row(
                          children: <Widget>[
                            new CircularProgressIndicator(),
                            SizedBox(width: 30,),
                            new Text(" Moving to Courses ")
                          ],
                        ),
                        ));

                    var resultcat=  await getcategoriesFromFireBase();

                    Navigator.of(context).pushReplacement(SlideRightRoute(

                        page: CoursesHomePage(student,this.googleSignIn,resultcat)
                    ));







                  }

              ),
              SizedBox(height: 20,),
              Text(
                'Hey ${student.fullName}',
                style: InputTextStyle,
              ),
              Text(
                'Here you can find ${this.name} Courses that can help you with study'
                ,style: InputTextStyle,
              ),
              // Container(
              //   margin: EdgeInsets.symmetric(vertical: 20),
              //   height: 60,
              //   padding: EdgeInsets.symmetric(horizontal: 20,vertical: 16),
              //   width: double.infinity,
              //   decoration: BoxDecoration(
              //       color: Color(0xFFF5F5F7),
              //       borderRadius: BorderRadius.circular(40)
              //   ),
              //   child: Row(
              //     children: <Widget>[
              //       Icon(
              //           Icons.search
              //       ),
              //       SizedBox(width: 20,),
              //       Text("Search for any Course",)
              //     ],
              //   ),
              // ),
              SizedBox(height: 30,),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  Text('Course',style: TextStyle( fontWeight: FontWeight.bold,fontSize: 20
                  ),),
                  Text('See All',style: TextStyle(
                      fontSize:15
                  ),)
                ],
              )
              ,SizedBox(height: 50,),
              Expanded(child: StaggeredGridView.countBuilder(crossAxisCount: 2,itemCount: this.coursescount,crossAxisSpacing: 20,mainAxisSpacing: 20, itemBuilder: (context,index){

                return GestureDetector(
                  onTap: (){

                    Navigator.of(context).pushReplacement(SlideRightRoute(

                        page: CourseDetailsScreen(student,googleSignIn,this.name,this.coursescount,this.catcourses,this.catcourses.docs.elementAt(index).data())
                    ));
                  },
                  child: Container(

                    height: index.isEven?200:240,


                    decoration: BoxDecoration(


                        borderRadius: BorderRadius.circular(10),
                        image: DecorationImage(
                            image: AssetImage('assets/images/download.jpg'),
                            fit: BoxFit.fill
                        )
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(20.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[

                          Text(this.catcourses.docs.elementAt(index).data()["CourseName"],style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 20

                          ),),

                          // Text("${resultcat[index]["Courses"]} Courses",style: TextStyle(
                          //     fontWeight: FontWeight.w600,color: Colors.black87
                          // ),)


                        ],
                      ),
                    ),
                  ),
                );
              }, staggeredTileBuilder: (index)=>StaggeredTile.fit(1)))
            ],

          ),
        ),
      ),
    );
  }
}



