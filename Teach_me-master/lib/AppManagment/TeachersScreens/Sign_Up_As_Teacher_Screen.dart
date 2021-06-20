import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:image_picker/image_picker.dart';
import 'file:///D:/ameer/teach_me/lib/AppManagment/UsersScreens/Account_Type_Screen.dart';
import 'package:firebase_database/firebase_database.dart';


import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:teach_me/AppManagment/Constants/constants.dart';
import 'package:teach_me/UserManagment/TeacherManagment/Teacher.dart';
import 'package:teach_me/AppManagment/routes/pageRouter.dart';
import 'file:///D:/ameer/teach_me/lib/DBManagment/FireBase_Service.dart';

import 'Sign_Up_Lessions_Details_Screen.dart';



class SignUpTeacher extends StatefulWidget {
 final  GoogleSignInAccount userObj;
 final auth;
 List<dynamic> cities;

   SignUpTeacher({Key key, this.userObj,this.auth,this.cities}) : super(key: key);

  @override
  SignUpTeacherState createState() => SignUpTeacherState(this.userObj,this.auth,this.cities);
}

class SignUpTeacherState extends State<SignUpTeacher> {
  File imageFile;
  final dateController = TextEditingController();
  String teacherFullName,phoneNumber,location,birthDate;
  final databaseReference = FirebaseDatabase.instance.reference();
  CollectionReference teachers = FirebaseFirestore.instance.collection("Teachers");
  final auth;
  bool isTeacher=true;
  List<dynamic> cities;
 final GoogleSignInAccount userObj;
  final _formKey = GlobalKey<FormState>();


  SignUpTeacherState(this.userObj,this.auth,this.cities);




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
                  SizedBox(height: 10,),
                  Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        IconButton(
                          icon: const Icon(Icons.arrow_back),
                          iconSize: 50,
                          alignment: Alignment.topLeft,
                          onPressed: () {
                            Navigator.of(context).pushReplacement(SlideRightRoute(
                               page: AccountType()
                            ));
                          }
                        ),


                            Text(
                              'TeachMe',
                              style: TextStyle(
                                  fontFamily: 'Kaushan',

                                  fontWeight: FontWeight.bold,
                                  fontSize: 30,
                                  color: Colors.white),
                            ),

                      ]),
                  SizedBox(
                    height: 20,
                  ),
                  Column(
                    children: [
                      SizedBox(
                        height: 30,
                      ),
                      Text(
                        'sign up as Teacher',
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
                      Text(userObj!=null?userObj.email:""),
                      SizedBox(height: 10,),
                      Form(
                        key: _formKey,
                        child: Column(
                          children: [
                            TextFormField(
                              validator: (value) {
                                if (value.isEmpty || value == null) {
                                  return "Must Type FullName";
                                }
                                return null;
                              },
                              keyboardType: TextInputType.emailAddress,
                              textAlign: TextAlign.center,
                              onChanged: (value) {
                                  teacherFullName =value;
                              },
                              decoration: InputDecoration(
                                fillColor: Colors.white60,
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
                              validator: (value) {
                                if (value.isEmpty || value == null) {
                                  return "Must Type PhoneNumber";
                                }
                                return null;
                              },

                              textAlign: TextAlign.center,
                              onChanged: (value) {
                                phoneNumber=value;
                              },
                              decoration: InputDecoration(
                                fillColor: Colors.white60,
                                filled: true,
                                border: OutlineInputBorder(
                                    borderRadius: new BorderRadius.circular(15.0)
                                ),
                                hintText: 'Phone Number',
                                hintStyle: InputTextStyle,


                              ),
                            ),
                            SizedBox(height: 10),
                            Container(
                              child: Autocomplete(
                                optionsBuilder: (TextEditingValue value) {
                                  // When the field is empty
                                  if (value.text.isEmpty) {
                                    return [];
                                  }

                                  // The logic to find out which ones should appear
                                  return this.cities.where((suggestion) => suggestion
                                      .toLowerCase()
                                      .startsWith(value.text.toLowerCase()));
                                },
                                onSelected: (value) {
                                  setState(() {
                                    location = value;
                                  });
                                },
                              ),
                            ),
                            // TextFormField(
                            //   validator: (value) {
                            //     if (value.isEmpty || value == null) {
                            //       return "Must Type Location";
                            //     }
                            //     return null;
                            //   },
                            //
                            //   textAlign: TextAlign.center,
                            //   onChanged: (value) {
                            //     location = value;
                            //   },
                            //   decoration: InputDecoration(
                            //     fillColor: Colors.white60,
                            //     filled: true,
                            //     border: OutlineInputBorder(
                            //         borderRadius: new BorderRadius.circular(15.0)
                            //     ),
                            //     hintText: 'Location',
                            //     hintStyle: InputTextStyle,
                            //   ),
                            // ),
                            SizedBox(height: 10,),



                            Container(
                              width: 130,
                              child: TextFormField(
                                validator: (value) {
                                  if (value.isEmpty || value == null) {
                                    return "Must Type BirthDate";
                                  }
                                  return null;
                                },
                                readOnly: true,
                                controller: dateController,
                                textAlign: TextAlign.center,
                                onTap: () async{
                                  var date =  await showDatePicker(
                                      context: context,
                                      initialDate:DateTime.now(),
                                      firstDate:DateTime(1900),
                                      lastDate: DateTime(2100));
                                  dateController.text = date.toString().substring(0,10);
                                },
                                onChanged: (value) {
                                  dateController.text=value;
                                },
                                decoration: InputDecoration(
                                  fillColor: Colors.white60,
                                  filled: true,
                                  border: OutlineInputBorder(
                                      borderRadius: new BorderRadius.circular(15.0)
                                  ),
                                  hintText: 'Birth Date',
                                  hintStyle:InputTextStyle,
                                ),
                              ),
                            ),
                          ],
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
                                    if (_formKey.currentState.validate()) {
                                      String userId = this.userObj == null ? this.auth
                                          .currentUser.uid.toString() : this.userObj
                                          .id;
                                      String email = this.userObj == null
                                          ? this.auth.currentUser.email.toString()
                                          : this.userObj.email;
                                      CollectionReference Subjectscollection =
                                      FirebaseFirestore.instance.collection("Subjects");


                                      DocumentSnapshot<Object> subjects= await Subjectscollection.doc("rFoR8RQBWc49Rx159ljf").get();
                                      List<dynamic> subjectsList=subjects.get("subjects");

                                      if (imageFile != null) {
                                        String imageUrl = await uploadImagetofireStorage(
                                            imageFile, teacherFullName, userId);
                                        Teacher newTeacher = Teacher(
                                            email,
                                            "",
                                            "",
                                            teacherFullName,
                                            dateController.text,
                                            phoneNumber,
                                            location,
                                            [],
                                            "",
                                            imageUrl);
                                         newTeacher.signUpASTeacher(
                                            newTeacher, teachers, userId);
                                        Navigator.of(context).pushReplacement(
                                            SlideRightRoute(
                                                page: TeacherLessonDetail(
                                                  userObj: this.userObj,auth: this.auth,subjects: subjectsList,)
                                            ));
                                      } else {
                                        Teacher newTeacher = Teacher(
                                            email,
                                            "",
                                            "",
                                            teacherFullName,
                                            dateController.text,
                                            phoneNumber,
                                            location,
                                            [],
                                            "",
                                            "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcQdWchFLU6qyuDDjtM9Pyo9Oi63MoVpzbhkww&usqp=CAU");
                                         newTeacher.signUpASTeacher(
                                            newTeacher, teachers, userId);
                                        Navigator.of(context).pushReplacement(
                                            SlideRightRoute(
                                                page: TeacherLessonDetail(
                                                  userObj: userObj,auth: this.auth,subjects: subjectsList,)
                                            ));
                                      }
                                    }
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
