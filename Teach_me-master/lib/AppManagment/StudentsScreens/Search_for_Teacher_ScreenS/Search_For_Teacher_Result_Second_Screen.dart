

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'file:///D:/ameer/teach_me/lib/AppManagment/TeachersScreens/Teacher_Home_Page_Screen.dart';
import 'package:teach_me/AppManagment/Constants/constants.dart';
import 'package:teach_me/UserManagment/StudentManagment/Student.dart';
import 'package:teach_me/UserManagment/TeacherManagment/Teacher.dart';
import 'package:teach_me/AppManagment/routes/pageRouter.dart';
import 'Search_For_Teacher_First_Screen.dart';



// ignore: must_be_immutable
class SearchForTeacherViewTeachers extends StatefulWidget {
  String selectedSubject;
  String selectedLocation;
  GoogleSignIn googleSignIn;
  Student s;
  List<Teacher> teachers;
  final auth;
  SearchForTeacherViewTeachers({ @required this.selectedSubject,@required this.selectedLocation,this.s,this.teachers,this.googleSignIn,this.auth}) : super();
  SearchForTeacherState createState() => SearchForTeacherState(selectedSubject:this.selectedSubject,selectedLocation: this.selectedLocation ,s:this.s,teachers: this.teachers);


}

class SearchForTeacherState extends State<SearchForTeacherViewTeachers> {
  bool showValue=false;
  String selectedSubject;
  String selectedLocation;
  Student s;
  List<Teacher> teachers;
  GoogleSignIn googleSignIn;
  List<Teacher> teachersResult;
  final auth;

  SearchForTeacherState({ @required this.selectedSubject,@required this.selectedLocation,this.s,this.teachers,this.googleSignIn,this.auth}) : super();


  Widget build(BuildContext context)  {
// this.teachers.then((value) => {
//   value.forEach((element)  {
//     teachersResult.add(element);
//   })
// });
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
                    SizedBox(height: 20,),
                    Padding(
                      padding: const EdgeInsets.all(15.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: <Widget>[
                          IconButton(
                              icon: const Icon(Icons.arrow_back),
                              iconSize: 50,
                              alignment: Alignment.topLeft,
                              onPressed: ()async {

                                CollectionReference Subjectscollection =
                                FirebaseFirestore.instance.collection("Subjects");

                                DocumentSnapshot<Object> subjects= await Subjectscollection.doc("rFoR8RQBWc49Rx159ljf").get();
                                List<dynamic> subjectsList=subjects.get("subjects");

                                CollectionReference citiescollection=FirebaseFirestore.instance.collection("Cities");
                                DocumentSnapshot<Object> cities= await citiescollection.doc("eF4F8hC9Y6QJjm1fRXXN").get();
                                List<dynamic> citiesList=cities.get("cities");


                                Navigator.of(context).pushReplacement(CupertinoPageRoute(
                                    builder: (context) => SearchForTeacherStudentActivity(this.s,this.googleSignIn,this.auth,subjectsList,citiesList)

                                ));
                              }
                          ),

                           Column(
                                children: [
                                  SizedBox(
                                    height: 11,
                                  ),
                                  Image.asset("assets/images/newlogologo.jpeg",matchTextDirection: true,height: 50,width: 120),
                                  Text(
                                    'TeachMe',
                                    style: TextStyle(
                                        fontFamily: 'Kaushan',

                                        fontWeight: FontWeight.bold,
                                        fontSize: 25,
                                        color: Colors.black),
                                  ),  ]),


                        ],
                      ),
                    ),


                   Padding(
                     padding: const EdgeInsets.all(15.0),
                     child: Column(
                       children: [
                         Text(selectedSubject != null?selectedSubject:"Subject",
                         style: TextStyle(
                           color: Colors.blue,
                           fontSize: 50,
                           fontWeight: FontWeight.bold
                         ),),
                         Text("Here You Can Find Very Professional $selectedSubject Teachers"),
                       ],
                     ),
                   ),
              Padding(
                padding: const EdgeInsets.all(15.0),
                child: Center(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    for(var i=0 ; i<4 ; i++)
                      TextButton(
                        style: ButtonStyle(
                          foregroundColor: MaterialStateProperty.all<Color>(Colors.blue),
                        ),
                        onPressed: () { },
                        child: Text('point ${(i+3)}'),
                      ),
                    ]
                  ),
                ),

              )
,


                 SingleChildScrollView(child: Container(height: 500,child: TeachersList(this.selectedSubject,this.selectedLocation,this.s,this.auth,this.googleSignIn)))



                  ]),


          ),
      ),

    );
  }
}






// ignore: must_be_immutable
class TeachersList extends StatefulWidget  {

  String subject;
  String location;
  Student student;
  final auth;
  GoogleSignIn googleSignIn;

  TeachersList(this.subject,this.location,this.student,this.auth,this.googleSignIn);

  @override
  _TeachersListState createState() => _TeachersListState(student,subject,location,this.auth,this.googleSignIn);
}

class _TeachersListState extends State<TeachersList> {


  String subject;
  String location;
  Student student;
  GoogleSignIn googleSignIn;
  final auth;

  _TeachersListState(this.student,this.subject,this.location,this.auth,this.googleSignIn);
  Widget build(BuildContext context) {
    // This method is rerun every time setState is called, for instance as done
    // by the _incrementCounter method above.
    //
    // The Flutter framework has been optimized to make rerunning build methods
    // fast, so that you can just rebuild anything that needs updating rather
    // than having to individually change instances of widgets.
    return new StreamBuilder<QuerySnapshot>(
      stream:this.widget.location=="all" && this.widget.subject=="all"? FirebaseFirestore.instance.collection('Teachers').snapshots():FirebaseFirestore.instance.collection('Teachers').where("Location",isEqualTo: this.widget.location).where("subjects",isEqualTo: this.widget.subject).snapshots(),
      builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
        if (!snapshot.hasData) return new Text('Loading...');
        return new ListView(
          children: snapshot.data.docs.map((DocumentSnapshot document) {

            return new ListTile(  contentPadding: EdgeInsets.symmetric(horizontal: 20.0, vertical: 10.0),
                onTap: (){
                  Navigator.of(context).pushReplacement(SlideRightRoute(
                      page: TeacherHomepage(document,this.student,this.subject,this.location,this.auth,this.googleSignIn)
                  ));
                },
                leading: Container(

                  padding: EdgeInsets.only(right: 12.0),
                  decoration: new BoxDecoration(
                      border: new Border(
                          right: new BorderSide(width: 1.0, color: Colors.white24))),
                  child: GestureDetector(

                    child: CircleAvatar(
                      radius: 30,
                      backgroundImage: document["ProfileImg"] != null
                       ?NetworkImage(document["ProfileImg"])
                          : NetworkImage(
                          "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcQdWchFLU6qyuDDjtM9Pyo9Oi63MoVpzbhkww&usqp=CAU"),
                    ),
                  ),
                ),
                title: Text(
                  document["FullName"],
                  style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
                ),
                // subtitle: Text("Intermediate", style: TextStyle(color: Colors.white)),

                subtitle: Row(
                  children: <Widget>[
                    RatingBarIndicator(
                      rating: document["Rating"],
                      itemBuilder: (context, index) => Icon(
                        Icons.star,
                        color: Colors.amber,
                      ),
                      itemCount: 5,
                      itemSize: 5.0,
                      direction: Axis.horizontal,
                    ),
                    SizedBox(width: 5,),
                    Text(document["subjects"]!=null?document["subjects"]:"subject", style: TextStyle(color: Colors.white))
                  ],
                ),
                trailing:
                Icon(Icons.keyboard_arrow_right, color: Colors.white, size: 30.0)
            );
          }).toList(),
        );
      },
    );
  }


}


