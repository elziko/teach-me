

import 'dart:ui';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'file:///D:/ameer/teach_me/lib/AppManagment/TeachersScreens/Edit_Profile_For_Teacher_Screen.dart';
import 'file:///D:/ameer/teach_me/lib/AppManagment/TeachersScreens/Lessons/Lessons_Screen.dart';
import 'file:///D:/ameer/teach_me/lib/AppManagment/TeachersScreens/Search_.For_Student_Screen.dart';
import 'file:///D:/ameer/teach_me/lib/AppManagment/StudentsScreens/Student_Activity_Home_Screen.dart';
import 'file:///D:/ameer/teach_me/lib/AppManagment/StudentsScreens/Search_for_Teacher_Screens/Search_For_Teacher_Result_Second_Screen.dart';
import 'package:teach_me/AppManagment/Constants/constants.dart';
import 'package:teach_me/UserManagment/StudentManagment/Student.dart';




// ignore: must_be_immutable
class TeacherHomepage extends StatefulWidget {

  DocumentSnapshot isTeacher;
  String subject,location;
  Student student;
  final auth;
  GoogleSignIn googleSignIn;
  TeacherHomepage(this.isTeacher,this.student,this.subject,this.location,this.auth,this.googleSignIn);



  @override
  HomepageteacherState createState() => HomepageteacherState(isTeacher,student,subject,location,this.auth,this.googleSignIn);
}

class HomepageteacherState extends State<TeacherHomepage> {

  bool showvalue=false;
  DocumentSnapshot isTeacher;
  String subject,location;
  Student student;
  final _auth ;
  GoogleSignIn googleSignIn;



  HomepageteacherState(this.isTeacher,this.student,this.subject,this.location,this._auth,this.googleSignIn);







  Widget build(BuildContext context) {
     print(this.isTeacher["FullName"]);
    // print(this.isTeacher["Location"]);
    // print(this.isTeacher["subjects"]);
    // print(this.isTeacher["CanGo"]);
    // print(this.isTeacher["PhoneNumber"]);



  // Teacher t = new Teacher("email", "password", "verifyPassword", FullName, "birthDate", PhoneNumber, Location, [], "detailsOnExperience","");
    // This method is rerun every time setState is called, for instance as done
    // by the _incrementCounter method above.
    //
    // The Flutter framework has been optimized to make rerunning build methods
    // fast, so that you can just rebuild anything that needs updating rather
    // than having to individually change instances of widgets.
    return Scaffold(
      body: Container(
        height: MediaQuery.of(context).size.height,
        width:  MediaQuery.of(context).size.width,

        decoration: MainBoxDecorationStyle,

        child: Padding(
          padding: const EdgeInsets.all(5.0),

          // Center is a layout widget. It takes a single child and positions it
          // in the middle of the parent.
          child: SingleChildScrollView(
            child: Column(
              // Column is also a layout widget. It takes a list of children and
              // arranges them vertically. By default, it sizes itself to fit its
              // children horizontally, and tries to be as tall as its parent.
              //
              // Invoke "debug painting" (press "p" in the console, choose the
              // "Toggle Debug Paint" action from the Flutter Inspector in Android
              // Studio, or the "Toggle Debug Paint" command in Visual Studio Code)
              // to see the wireframe for each widget.
              //
              // Column has various properties to control how it sizes itself and
              // how it positions its children. Here we use mainAxisAlignment to
              // center the children vertically; the main axis here is the vertical
              // axis because Columns are vertical (the cross axis would be
              // horizontal).
              //mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Padding(
                    padding: const EdgeInsets.all(15.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        Row(
                          children:[
                            student!=null?showButton(context):showLogoutButton(context),

                            Text(student!=null?"Back To Results":"",

                                style: TextStyle(
                                  fontSize: 12
                                ),
                            ),
                          ]
                        ),

                        Column(
                            children: [
                              SizedBox(
                                height: 11,
                              ),
                              Image.asset("assets/images/newlogologo.jpeg",matchTextDirection: true,height: 80,width: 120),
                              Text(
                                'TeachMe',
                                style: TextStyle(
                                    fontFamily: 'Kaushan',

                                    fontWeight: FontWeight.bold,
                                    fontSize: 25,
                                    color: Colors.white),
                              ),  ]),



                      ],
                    ),
                  ),


                  SizedBox(height: 30,),
                  Text(this.isTeacher["FullName"]!=null?this.isTeacher["FullName"]:"name",
                      style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 35,
                      color: Colors.white),
                   ),
                  SizedBox(height: 10,),


                  /////////
                  ///
                  /// problem with the Text down below!!!! |
                  ///                                     \/
                  ///                                     |
                  ///                                    \/
                  /// //


                  // Text("${this.isTeacher["subjects"]!=null?this.isTeacher["subjects"]:""} Teacher ",
                  //   style: TextStyle(
                  //       fontWeight: FontWeight.normal,
                  //       fontSize: 15,
                  //       color: Colors.white),
                  // ),
                  SingleChildScrollView(
                    child: Container(

                      height: 440 ,
                     width: 300,
                     decoration: BoxDecoration(
                       borderRadius: BorderRadius.circular(10),
                       color: Colors.white54
                     ),

                     // color: Colors.grey,

                      child: Column(

                        children: [
                          RatingBarIndicator(

                            rating: this.isTeacher["Rating"]!=null? this.isTeacher["Rating"]:0.0,
                            itemBuilder: (context, index) => Icon(
                              Icons.star,
                              color: Colors.amber,
                            ),
                            itemCount: 5,
                            itemSize: 50.0,
                            direction: Axis.horizontal,
                          ),
                          SizedBox(height: 30,),

                          Text('Still have no lessons',
                                style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 15,
                                color: Colors.black),),


                          Text(
                            "City : ${this.isTeacher["Location"]!=null?this.isTeacher["Location"]:""}",
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 20
                            ),
                          ),
                          SizedBox(height: 7,),

                          Text(
                              "PhoneNumber :  ${this.isTeacher["PhoneNumber"]!=null?this.isTeacher["PhoneNumber"]:""}",
                            style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 20
                            ),
                          ),
                          SizedBox(height: 7,),
                          // Text(
                          //     "More About Me : ${this.isTeacher["More"]!=null?this.isTeacher["More"]:""}",
                          //   style: TextStyle(
                          //       fontWeight: FontWeight.bold,
                          //       fontSize: 20
                          //   ),
                          // ),
                          SizedBox(height: 100,)
                          ,   Row(
                              children:<Widget>[
                                Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Text(
                                      'Can Go To Student ?'
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.all(15.0),
                                  child: Container(


                                      child: Row(

                                        children: [

                                          // ignore: deprecated_member_use


                                          /////////
                                          ///
                                          /// problem with the Text down below!!!! |
                                          ///                                     \/
                                          ///                                     |
                                          ///                                    \/
                                          /// //

                                      // //       Text(
                                      // // this.isTeacher["CanGo"]==null?"": this.isTeacher["CanGo"] ? "Can" :
                                      // //       "Can't"
                                      // // ,
                                      //
                                      //       //   style: TextStyle(
                                      //       // fontSize: 30,
                                      //       // color: this.isTeacher["CanGo"]==null?"":this.isTeacher["CanGo"] ? Colors.green : Colors.red)
                                      //          ),



                                 ],
                                      )
                                  ),
                                ),
                              ]

                          ),

                        ],
                      ),
                    ),
                  ),SizedBox(height: 50,),
                  student!=null?Container():Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          TextButton(
                            style: TextButton.styleFrom(
                              primary: Colors.blue,
                              backgroundColor: Colors.white70,

                            ),
                            onPressed: () {
                              Navigator.of(context).pushReplacement(CupertinoPageRoute(
                                  builder: (context) => SearchForStudent(isTeacher,this._auth,this.googleSignIn)
                              ));
                            },
                            child: Text('Search',
                              style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 20,),),
                          ),

                          TextButton(
                            style: TextButton.styleFrom(
                              primary: Colors.blue,

                              backgroundColor: Colors.white70,
                            ),
                            onPressed: () {

                              Navigator.of(context).pushReplacement(CupertinoPageRoute(
                                  builder: (context) => Lessons(isTeacher,this._auth,this.googleSignIn)
                              ));
                            },
                            child: Text('Lessons',
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 20,),),
                          ),

                          TextButton(
                            style: TextButton.styleFrom(
                              primary: Colors.blue,

                              backgroundColor: Colors.white70,
                            ),
                            onPressed: () {
                              Navigator.of(context).pushReplacement(CupertinoPageRoute(
                                  builder: (context) => EditProfileForTeacher(isTeacher: isTeacher,googleSignIn: this.googleSignIn,)
                              ));

                            },
                            child: Text('Edit Profile',
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 20,),),
                          ),



                        ],
                      )
                     // SizedBox(height: 70,),







                ]),
          ),
        ),
      ),
    );
  }
  showLogoutButton(BuildContext context){
    return  IconButton(
        icon: const Icon(Icons.logout),
        iconSize: 50,
      onPressed: ()=>showDialog(
        context: context,
        builder: (context) => SureLogout(auth:this._auth,googleSignin: this.googleSignIn,),

      ),

    );

  }

  Widget showButton(BuildContext context ){
    return  IconButton(
        icon: const Icon(Icons.arrow_back),
        iconSize: 50,
        onPressed: () {
          Navigator.of(context).pushReplacement(CupertinoPageRoute(
              builder: (context) => SearchForTeacherViewTeachers(s: student,selectedSubject: subject, selectedLocation: location)
          ));
        }

    );

  }



}




