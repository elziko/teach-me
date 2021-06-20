
import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:image_picker/image_picker.dart';

import 'package:firebase_database/firebase_database.dart';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'file:///D:/ameer/teach_me/lib/AppManagment/TeachersScreens/Teacher_Home_Page_Screen.dart';
import 'package:teach_me/AppManagment/Constants/constants.dart';
import 'package:teach_me/UserManagment/StudentManagment/Student.dart';
import 'package:teach_me/AppManagment/routes/pageRouter.dart';
import 'Update_Lesson_information_Screen.dart';
import 'file:///D:/ameer/teach_me/lib/DBManagment/FireBase_Service.dart';




// ignore: must_be_immutable
class EditProfileForTeacher extends StatefulWidget {
  DocumentSnapshot isTeacher;
  final auth;
  GoogleSignIn googleSignIn;

  EditProfileForTeacher({Key key,this.isTeacher,this.auth,this.googleSignIn}) : super(key: key);

  @override
  EditProfileForTeacherState createState() => EditProfileForTeacherState(isTeacher,this.auth,this.googleSignIn);
}

class EditProfileForTeacherState extends State<EditProfileForTeacher> {
  File imageFile;
  DocumentSnapshot isTeacher;

  final _dateController = TextEditingController();
  String fullName,phoneNumber,location;
  bool _validate=false;
  GoogleSignIn googleSignIn;




  final databaseReference = FirebaseDatabase.instance.reference();
  CollectionReference teachers = FirebaseFirestore.instance.collection("Teachers");
  final auth;


  EditProfileForTeacherState(this.isTeacher,this.auth,this.googleSignIn);



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
          padding: const EdgeInsets.all(15.0),

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
                SizedBox(height: 10,),
                Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      IconButton(
                          icon: const Icon(Icons.arrow_back),
                          iconSize: 50,
                          alignment: Alignment.topLeft,
                          onPressed: () {
                            Student s;
                            Navigator.of(context).pushReplacement(SlideRightRoute(
                                page: TeacherHomepage(isTeacher,s,"","",this.auth,this.googleSignIn)
                            ));
                          }
                      ),


                      Column(
                        children: [
                          Image.asset("assets/images/newlogologo.jpeg",matchTextDirection: true,height: 80,width: 120),

                          Text(
                            'TeachMe',
                            style: TextStyle(
                                fontFamily: 'Kaushan',

                                fontWeight: FontWeight.bold,
                                fontSize: 30,
                                color: Colors.white),
                          ),
                        ],
                      ),

                    ]),
                SizedBox(
                  height: 20,
                ),
                Column(
                  children: [
                    SizedBox(
                      height: 20,
                    ),
                    Text(
                      'Edit Your Profile',
                      style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 30,
                          color: Colors.white),
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    Text(
                      'Personal information',
                      style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 20,
                          color: Colors.white),
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    GestureDetector(
                      onTap: () {
                        _getFromGallery();
                      },
                      child: CircleAvatar(
                        radius: 70,
                        backgroundImage: imageFile != null
                            ? FileImage(imageFile)
                            : NetworkImage(
                            "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcQdWchFLU6qyuDDjtM9Pyo9Oi63MoVpzbhkww&usqp=CAU"),
                      ),
                    ),
                    SizedBox(height: 25,),
                    Text("${isTeacher["email"]}"),
                    SizedBox(height: 10,),
                    TextFormField(
                      keyboardType: TextInputType.emailAddress,

                      textAlign: TextAlign.center,
                      onChanged: (value) {
                        fullName =value;
                      },
                      decoration: InputDecoration(
                        fillColor: Colors.white60,
                        errorText: _validate ? 'Value Can\'t Be Empty' : null,

                        filled: true,
                        border: OutlineInputBorder(
                            borderRadius: new BorderRadius.circular(15.0)
                        ),

                        hintText: 'Full Name',
                        hintStyle: InputTextStyle,


                      ),
                    ),
                    SizedBox(height: 10),
                    TextFormField(


                      textAlign: TextAlign.center,
                      onChanged: (value) {
                        phoneNumber=value;
                      },
                      decoration: InputDecoration(
                        fillColor: Colors.white60,
                        errorText: _validate ? 'Value Can\'t Be Empty' : null,
                        filled: true,
                        border: OutlineInputBorder(
                            borderRadius: new BorderRadius.circular(15.0)
                        ),
                        hintText: 'Phone Number',
                        hintStyle: InputTextStyle,


                      ),
                    ),
                    SizedBox(height: 10),
                    TextFormField(
                      textAlign: TextAlign.center,
                      onChanged: (value) {
                        location = value;
                      },
                      decoration: InputDecoration(
                        fillColor: Colors.white60,
                        errorText: _validate ? 'Value Can\'t Be Empty' : null,
                        filled: true,
                        border: OutlineInputBorder(
                            borderRadius: new BorderRadius.circular(15.0)
                        ),
                        hintText: 'Location',
                        hintStyle: InputTextStyle,
                      ),
                    ),
                    SizedBox(height: 10,),



                    Container(
                      width: 130,
                      child: TextFormField(

                        readOnly: true,
                        controller: _dateController,
                        textAlign: TextAlign.center,
                        onTap: () async{
                          var date =  await showDatePicker(
                              context: context,
                              initialDate:DateTime.now(),
                              firstDate:DateTime(1900),
                              lastDate: DateTime(2100));
                          _dateController.text = date.toString().substring(0,10);
                        },
                        onChanged: (value) {
                          _dateController.text=value;
                        },
                        decoration: InputDecoration(
                          fillColor: Colors.white60,
                          filled: true,
                          errorText: _validate ? 'Type Date!' : null,
                          border: OutlineInputBorder(
                              borderRadius: new BorderRadius.circular(15.0)
                          ),
                          hintText: 'Birth Date',
                          hintStyle: InputTextStyle,
                        ),
                      ),
                    ),
                    Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: <Widget>[
                          Container(

                          ),
                          Column(
                            children: [
                              IconButton(
                                  icon: const Icon(Icons.arrow_forward),
                                  iconSize: 50,

                                  alignment: Alignment.topLeft,
                                  onPressed: () async {

                                    //String imageUrl;
                                    String userId = isTeacher.id ;

                                    //String  email = isTeacher["email"];
                                    // setState(() {
                                    //   _fullname.text.isEmpty ? _validate = true : _validate = false;
                                    //   _dateController.text.isEmpty ? _validate = true : _validate = false;
                                    //   _Location.text.isEmpty ? _validate = true : _validate = false;
                                    //   _phoneNumber.text.isEmpty ? _validate = true : _validate = false;
                                    //
                                    // });
                                    if (imageFile != null ){



                                       await uploadImagetofireStorage(imageFile,fullName,userId);

                                    }
                                    print("   here ----------------->>>>>>>>>>>>>>>> ${fullName == ""}");
                                    String fullname=fullName!=null?fullName:isTeacher["FullName"];
                                    print("fullName ::::::::::::$fullname ${fullname!=""}");
                                    String phonenumber=phoneNumber!=null?phoneNumber:isTeacher["PhoneNumber"];

                                    String locations=location!=null?location:isTeacher["Location"];

                                    String date=_dateController.text!= null?_dateController.text:isTeacher["BirthDate"];


                                    // Teacher newTeacher = Teacher(email, "", "", _fullname.text, _dateController.text, _phoneNumber.text, _Location.text, [], "",imageUrl);
                                    Map<String,dynamic> data ={"FullName":fullname,"PhoneNumber":phonenumber,"Location":locations,"BirthDate":date};
                                    await updateTeacherDetails(data,userId);

                                    Navigator.of(context).pushReplacement(SlideRightRoute(
                                        page: EditLessonInformation(isTeacher: isTeacher,googleSignIn: this.googleSignIn,)
                                    ));

                                  }
                              ),
                              Text(
                                'Next',
                                textAlign: TextAlign.center,
                                overflow: TextOverflow.ellipsis,
                                style: TextStyle(fontWeight: FontWeight.bold),
                              ),
                            ],
                          ),

                        ]),



                  ],
                ),
              ]),
        ),
      ),
    );
  }

  Future<void> _getFromGallery() async {
    PickedFile pickedFile = await ImagePicker().getImage(
      source: ImageSource.gallery,
      maxWidth: 1800,
      maxHeight: 1800,
    );
    if (pickedFile != null) {
      setState(() {
        imageFile = File(pickedFile.path);
      });
    }
  }
  //
  // Future<void> _getFromCamera() async {
  //   PickedFile pickedFile = await ImagePicker().getImage(
  //     source: ImageSource.camera,
  //     maxWidth: 1800,
  //     maxHeight: 1800,
  //   );
  //   if (pickedFile != null) {
  //     setState(() {
  //       imageFile = File(pickedFile.path);
  //     });
  //   }
  // }

}