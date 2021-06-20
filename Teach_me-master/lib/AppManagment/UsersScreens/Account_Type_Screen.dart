
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'file:///D:/ameer/teach_me/lib/AppManagment/StudentsScreens/Sign_Up_As_Student_Screen.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'file:///D:/ameer/teach_me/lib/AppManagment/StudentsScreens/Student_Activity_Home_Screen.dart';
import 'file:///D:/ameer/teach_me/lib/AppManagment/TeachersScreens/Teacher_Home_Page_Screen.dart';
import 'package:teach_me/AppManagment/Constants/constants.dart';
import 'package:teach_me/UserManagment/StudentManagment/Student.dart';
import 'package:teach_me/AppManagment/routes/pageRouter.dart';


import '../TeachersScreens/Sign_Up_As_Teacher_Screen.dart';
import 'Sign_in_Screen.dart';

// ignore: must_be_immutable
class AccountType extends StatelessWidget {

  GoogleSignIn googleSignIn;
  final auth;
  GoogleSignInAccount userObj;
  Student s;


   AccountType({Key key, this.googleSignIn,this.userObj,this.auth}) : super(key: key);


  Widget build(BuildContext context) {



    // This method is rerun every time setState is called, for instance as done
    // by the _incrementCounter method above.
    //
    // The Flutter framework has been optimized to make rerunning build methods
    // fast, so that you can just rebuild anything that needs updating rather
    // than having to individually change instances of widgets.
    return Scaffold(

      body: Container(
        height:MediaQuery.of(context).size.height,
        width:  MediaQuery.of(context).size.width,

        decoration: MainBoxDecorationStyle,
        child: Padding(
          padding: const EdgeInsets.all(20.0),


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
              Row(
              mainAxisAlignment: MainAxisAlignment.start,
                  children: <Widget>[
                    SizedBox(height: 10,),
                    IconButton(
                        icon: const Icon(Icons.arrow_back),
                        iconSize: 50,
                        alignment: Alignment.topLeft,
                        onPressed: () async{
                          if (this.googleSignIn!=null){
                            await this.googleSignIn.signOut();


                          }else if (this.auth != null){

                            await auth.signOut();

                          }
                          Navigator.of(context).pushReplacement(SlideRightRoute(
                              page:SignInUser()
                          ));
                        }
                    ),
                     ]),
                    Container(child: Image.asset("assets/images/newlogologo.jpeg",matchTextDirection: true,height: 200,width: 250)),

                    Text(
                      'TeachMe',
                      style: TextStyle(fontWeight: FontWeight.bold,
                          fontSize: 50,
                          fontFamily: 'Kaushan',
                          color: Colors.white),
                    ),
                    SizedBox(height: 100),
                    Center(
                      child: Container(
                        width: 300,
                        child: Column(
                            children: <Widget>[
                              Text(
                               userObj!=null?"sign in as": 'sign up as',
                                style: TextStyle(fontWeight: FontWeight.bold,
                                    fontSize: 30,
                                    color: Colors.white),
                              ),
                              SizedBox(height: 20,),
                              ElevatedButton(
                                child: Text('Teacher'),
                                style: ElevatedButton.styleFrom(
                                  primary: Colors.white70,
                                  minimumSize: Size(100, 100),
                                  shape: const BeveledRectangleBorder(borderRadius: BorderRadius.all(Radius.circular(8))),

                                  onPrimary: Colors.black,
                                  textStyle: TextStyle(
                                      color: Colors.black,
                                      fontSize: 40,
                                      fontStyle: FontStyle.italic,
                                      fontFamily: BtnFont

                                  ),
                                ),
                                onPressed: () async{

                                  CollectionReference citiescollection=FirebaseFirestore.instance.collection("Cities");
                                  DocumentSnapshot<Object> cities= await citiescollection.doc("eF4F8hC9Y6QJjm1fRXXN").get();
                                  List<dynamic> citiesList=cities.get("cities");


                                  CollectionReference teachers = FirebaseFirestore.instance.collection("Teachers");
                                  if (googleSignIn ==null){
                                    Navigator.of(context).pushReplacement(SlideRightRoute(
                                        page: SignUpTeacher(userObj: userObj,auth: this.auth,cities:citiesList)

                                    ));
                                  }else{

                                    DocumentSnapshot isTeacher = await teachers.doc("${this.userObj.id}").get();
                                    if (isTeacher.exists){
                                      Navigator.of(context).pushReplacement(SlideRightRoute(
                                          page: TeacherHomepage(isTeacher,s,"","",this.auth,this.googleSignIn)

                                      ));
                                    }else{
                                      Navigator.of(context).pushReplacement(SlideRightRoute(
                                          page: SignUpTeacher(userObj: userObj,cities:citiesList)

                                      ));
                                    }

                                  }









                                },
                              ),

                              // ignore: deprecated_member_use
                              SizedBox(height: 20),
                              ElevatedButton(
                                child: Text('Student'),
                                style: ElevatedButton.styleFrom(
                                  primary: Colors.white70,
                                  onPrimary: Colors.black,
                                  minimumSize: Size(100, 100),
                                  shape: const BeveledRectangleBorder(borderRadius: BorderRadius.all(Radius.circular(8))),

                                  textStyle: TextStyle(
                                      color: Colors.black,
                                      fontSize: 40,
                                      fontStyle: FontStyle.italic,
                                    fontFamily: BtnFont
                                  ),
                                ),
                                onPressed: () async{
                                  CollectionReference citiescollection=FirebaseFirestore.instance.collection("Cities");
                                  DocumentSnapshot<Object> cities= await citiescollection.doc("eF4F8hC9Y6QJjm1fRXXN").get();
                                  List<dynamic> citiesList=cities.get("cities");

                                  if(userObj!=null){
                                    String email = userObj.email;
                                    String fullname=userObj.displayName;
                                    Student student= Student(email, "password", "verifyPassword", fullname, "birthDate", "phoneNumber", "location",true);
                                    Navigator.of(context).pushReplacement(SlideRightRoute(
                                        page: StudentActivity(student,googleSignIn)

                                    ));
                                  }else{
                                    Student student= Student(this.auth.currentUser.email, "password", "verifyPassword", "userObj.displayName", "birthDate", "phoneNumber", "location",true);
                                    Navigator.of(context).pushReplacement(SlideRightRoute(
                                        page: SignUpStudent(student:student,citiesList:citiesList)

                                    ));
                                  }

                                },
                              ),

                              // This trailing comma makes auto-formatting nicer for build methods.
                            ]
                        ),
                      ),
                    ),
                  ]
              ),
            ),

        ),
      ),
    );
  }
}
