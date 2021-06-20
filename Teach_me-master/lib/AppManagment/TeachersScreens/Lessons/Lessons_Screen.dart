

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:teach_me/AppManagment/Constants/constants.dart';

import 'package:teach_me/UserManagment/StudentManagment/Student.dart';
import 'package:teach_me/AppManagment/routes/pageRouter.dart';

import 'Add_New_Lesson_Screen.dart';
import '../Teacher_Home_Page_Screen.dart';




// ignore: must_be_immutable
class Lessons extends StatefulWidget {
  Student student;
  String location;
  String subject;
  final auth;
  GoogleSignIn googleSignIn;

  DocumentSnapshot isTeacher;
  Lessons(this.isTeacher,this.auth,this.googleSignIn);

  @override
  LessonsDetails createState() => LessonsDetails(isTeacher,this.auth,this.googleSignIn);
}

class LessonsDetails extends State<Lessons> {
  Student student;
  String location;
  String subject;


  bool showvalue=false;
  DocumentSnapshot isTeacher;
  GoogleSignIn googleSignIn;

  final auth ;


  LessonsDetails(this.isTeacher,this.auth,this.googleSignIn);







  Widget build(BuildContext context) {

    // String FullName= this.isTeacher.get(FieldPath(["FullName"]));
    // String Location= this.isTeacher.get(FieldPath(["Location"]));
    // String PhoneNumber= this.isTeacher.get(FieldPath(["PhoneNumber"]));
    // //String Price= this.isTeacher.get(FieldPath(["Price"]));






    //Teacher t = new Teacher("email", "password", "verifyPassword", FullName, "birthDate", PhoneNumber, Location, [], "detailsOnExperience","");
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

                                IconButton(
                                    icon: const Icon(Icons.arrow_back),
                          iconSize: 50,
                          onPressed: () {
                            Navigator.of(context).pushReplacement(SlideRightRoute(
                               page:TeacherHomepage(isTeacher, student, subject, location,this.auth,this.googleSignIn)
                            ));

                          }

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
                                  fontFamily:TitleFont,

                                  fontWeight: FontWeight.bold,
                                  fontSize: 25,
                                  color: Colors.white),
                            ),  ]),



                    ],
                  ),
                ),


                SizedBox(height: 30,),
                Text("Lessons",
                  style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 35,
                      color: Colors.white),
                ),
                SizedBox(height: 10,),
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children:<Widget>[
                    SizedBox(width: 10,),
                   TextButton(onPressed: (){
                     Navigator.of(context).pushReplacement(SlideRightRoute(
                         page: AddNewLesson(isTeacher: isTeacher,googleSignIn: this.googleSignIn,)
                     ));
                   }, child: Text("+ Add New Lesson "))
                  ]
                )
                ,

                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: SingleChildScrollView(
                    child: Container(


                     height: 500,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                          color: Colors.white54
                      ),
                       child:StreamBuilder<QuerySnapshot>(
                         stream: FirebaseFirestore.instance.collection('Meetings').where("TeacherId" ,isEqualTo: isTeacher.id).snapshots(),
                         builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
                           if (!snapshot.hasData) return new Text('Loading...');
                           return new ListView(

                             children: snapshot.data.docs.map((DocumentSnapshot document) {


                               return new ListTile(  contentPadding: EdgeInsets.symmetric(horizontal: 10.0, vertical: 10.0),
                                   onTap: (){
                                     Navigator.of(context).pushReplacement(SlideRightRoute(
                                         page:AddNewLesson(isTeacher: isTeacher,document: document,googleSignIn: this.googleSignIn,)
                                     ));


                                   },
                                   leading: Container(
                                     height: 40.0,
                                     width: 1,
                                     padding: EdgeInsets.all( 12.0),
                                     decoration: new BoxDecoration(
                                         border: new Border(
                                             right: new BorderSide(width: 1.0, color: Colors.grey),


                                     )),


                                   ),
                                   title: Text(
                                     "${document["LessonSubject"]} Lesson ${document["Date"]} ${document["Time"]}",
                                     style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold),
                                   ),
                                   // subtitle: Text("Intermediate", style: TextStyle(color: Colors.white)),

                                   subtitle: Row(
                                     children: <Widget>[

                                       SizedBox(width: .0),
                                       Text("${document["StudentName"]} : ${document["StuPhoneNumber"]}", style: TextStyle(color: Colors.black))

                                     ],
                                   ),
                                   trailing:
                                   IconButton(icon: Icon(Icons.delete), onPressed: (){
                                     FirebaseFirestore.instance.collection("Meetings").doc(document.id).delete();


                                   })
                               );
                             }).toList(),
                           );
                         },
                       )
                      // color: Colors.grey,


                    ),
                  ),
                ),




              ]),
        ),
      ),
    );
  }
}