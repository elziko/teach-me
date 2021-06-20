import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';

import 'file:///D:/ameer/teach_me/lib/AppManagment/TeachersScreens/Teacher_Home_Page_Screen.dart';
import 'package:teach_me/AppManagment/Constants/constants.dart';

import 'package:teach_me/UserManagment/StudentManagment/Student.dart';



// ignore: must_be_immutable
class SearchForStudent extends StatefulWidget {
  DocumentSnapshot isTeacher;
  String subject, location;
  Student student;
  final auth;
  GoogleSignIn googleSignin;

  SearchForStudent(this.isTeacher,this.auth,this.googleSignin);

  @override
  SearchForStudentState createState() =>
      SearchForStudentState(isTeacher,this.auth,this.googleSignin);
}

class SearchForStudentState extends State<SearchForStudent> {
  bool showvalue = false;
  DocumentSnapshot isTeacher;
  String subject, location;
  Student student;
  final auth ;
  String selectedName;
  GoogleSignIn googleSignin;

  SearchForStudentState(
      this.isTeacher,this.auth,this.googleSignin);

  Widget build(BuildContext context) {
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
                      Row(children: [
                        IconButton(
                            icon: const Icon(Icons.arrow_back),
                            iconSize: 50,
                            onPressed: () {
                              Navigator.of(context).pushReplacement(
                                  CupertinoPageRoute(
                                      builder: (context) =>TeacherHomepage(isTeacher, student, subject, location,this.auth,this.googleSignin)
                                          ));
                            }),
                        Text(
                          "Back To Home page",
                          style: TextStyle(fontSize: 12),
                        ),
                      ]),
                      Column(children: [
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
                        ),
                      ]),
                    ],
                  ),
                ),
                SizedBox(
                  height: 30,
                ),
                Container(
                    height: 50,
                    width: 250,
                    child:TextField(
                      textAlign: TextAlign.center,
                      textAlignVertical: TextAlignVertical.bottom,

                      onChanged: (value) {
                        setState(() {
                          selectedName=value;

                        });
                      },
                      decoration: InputDecoration(
                        prefixIcon:IconButton(
                          icon: Icon(Icons.search),
                          onPressed: (){
                          },
                        ),

                        contentPadding: new EdgeInsets.symmetric(vertical: 25.0, horizontal: 10.0),
                        fillColor: Colors.white60,
                        filled: true,
                        border: OutlineInputBorder(
                            borderRadius: new BorderRadius.circular(15.0)
                        ),

                        hintText: "Type The Student Name",


                        hintStyle: TextStyle(
                          color: const Color(0xCB101010),
                          fontSize:16,
                          fontWeight: FontWeight.w700,
                          fontStyle: FontStyle.normal,
                          fontFamily: 'NothingYouCouldDo'
                        ),



                      ),
                    )
                ),
                SingleChildScrollView(
                  child: Container(
                    height: 440,
                    width: 300,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        color: Colors.white54),
                      child:StreamBuilder<QuerySnapshot>(
                        stream: FirebaseFirestore.instance.collection('Students').where("FullName" ,isEqualTo: selectedName).snapshots(),
                        builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
                          if (!snapshot.hasData) return new Text('Loading...');
                          return new ListView(

                            children: snapshot.data.docs.map((DocumentSnapshot document) {


                              return new ListTile(  contentPadding: EdgeInsets.symmetric(horizontal: 10.0, vertical: 10.0),
                                  onTap: (){



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
                                    "${document["FullName"]} --- ${document["PhoneNumber"]} --- ${document["grade"]}",
                                    style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold),
                                  ),
                                  // subtitle: Text("Intermediate", style: TextStyle(color: Colors.white)),

                                  subtitle: Row(
                                    children: <Widget>[

                                      SizedBox(width: .0),

                                    ],
                                  ),


                              );
                            }).toList(),
                          );
                        },
                      )
                    // color: Colors.grey,


                  ),
                ),
              ]),
        ),
      ),
    );
  }
}
