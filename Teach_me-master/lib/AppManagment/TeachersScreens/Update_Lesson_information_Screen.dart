
// ignore: camel_case_types
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:teach_me/AppManagment/Constants/constants.dart';
import 'package:teach_me/UserManagment/StudentManagment/Student.dart';
import 'package:teach_me/AppManagment/routes/pageRouter.dart';

import 'Teacher_Home_Page_Screen.dart';

// ignore: must_be_immutable
class EditLessonInformation extends StatefulWidget {
  DocumentSnapshot isTeacher;
  final auth;
  GoogleSignIn googleSignIn;
  EditLessonInformation({Key key,this.isTeacher,this.auth,this.googleSignIn}) : super(key: key);
  @override
  EditLessonInformationState createState() => EditLessonInformationState(isTeacher,this.auth,this.googleSignIn);
}

class EditLessonInformationState extends State<EditLessonInformation> {
  String subjects,titleSentence,moreDetails,price,selectedSubject;
  List subjectsLists = ["English","Math","maba","biology","physic","hebrew","arabic"];
  bool canGo=false;
  DocumentSnapshot isTeacher;
  GoogleSignIn googleSignIn;
  final auth;


  EditLessonInformationState(this.isTeacher,this.auth,this.googleSignIn);



  Widget build(BuildContext context) {
    CollectionReference teachers = FirebaseFirestore.instance.collection("Teachers");

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
          padding: const EdgeInsets.only(top: 20),

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
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[

                      Column(
                        children: [
                          SizedBox(
                            height: 25,
                          ),
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
                SizedBox(height: 10,),
                Center(
                    child: Text(
                      'Lessions Information',
                      style:TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 30,
                          color: Colors.white),
                    )
                ),



                SizedBox(height: 40,),
                Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: Column(
                    children: [
                      Center(
                        child: Text(
                          "subjects",style:TextStyle(color:Colors.black,fontSize: 20),
                        ),
                      ),
                      SizedBox(height: 4,),
                      Container(
                        child: Autocomplete(
                          optionsBuilder: (TextEditingValue value) {
                            // When the field is empty
                            if (value.text.isEmpty) {
                              return [];
                            }

                            // The logic to find out which ones should appear
                            return subjectsLists.where((suggestion) => suggestion
                                .toLowerCase()
                                .startsWith(value.text.toLowerCase()));
                          },
                          onSelected: (value) {
                            setState(() {
                              selectedSubject = value;
                            });
                          },
                        ),
                      ),

                      SizedBox(height: 15,),
                      TextFormField(
                        keyboardType: TextInputType.emailAddress,
                        textAlign: TextAlign.center,
                        onChanged: (value) {
                          titleSentence=value;
                        },
                        decoration: InputDecoration(
                          fillColor: Colors.white60,
                          filled: true,
                          border: OutlineInputBorder(
                              borderRadius: new BorderRadius.circular(15.0)
                          ),

                          hintText: 'Enter a Title Sentence',
                          hintStyle: InputTextStyle,


                        ),
                      ),
                      SizedBox(height: 15,),

                      Container(


                        child: TextFormField(

                          keyboardType: TextInputType.emailAddress,
                          textAlign: TextAlign.center,
                          onChanged: (value) {
                            moreDetails=value;
                          },
                          decoration: InputDecoration(
                            contentPadding: new EdgeInsets.symmetric(vertical: 75.0, horizontal: 10.0),
                            fillColor: Colors.white60,
                            filled: true,
                            border: OutlineInputBorder(
                                borderRadius: new BorderRadius.circular(15.0)
                            ),

                            hintText: 'More About you',


                            hintStyle: InputTextStyle,



                          ),
                        ),
                      ),
                      Row(
                          children:<Widget>[
                            Text(
                                'Can You Go to Student House ?'
                            ),
                            Padding(
                              padding: const EdgeInsets.all(15.0),
                              child: Container(


                                  child: Row(

                                    children: [

                                      // ignore: deprecated_member_use
                                      FlatButton(onPressed: (){

                                        setState(() {
                                          canGo=!canGo;

                                        });



                                      }, child: Text('Can',style:TextStyle(
                                        color: Colors.white70
                                      )),
                                        color: canGo ? Colors.green : Colors.red,),


                                    ],
                                  )
                              ),
                            ),
                          ]

                      ),
                      Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,

                          children:<Widget>[
                            Container(
                                height: 70,
                                width: 150,
                                child:TextFormField(
                                  textAlign: TextAlign.center,
                                  onChanged: (value) {
                                    price=value;
                                  },
                                  decoration: InputDecoration(
                                    contentPadding: new EdgeInsets.symmetric(vertical: 25.0, horizontal: 10.0),
                                    fillColor: Colors.white60,
                                    filled: true,
                                    border: OutlineInputBorder(
                                        borderRadius: new BorderRadius.circular(15.0)
                                    ),

                                    hintText: 'Price',


                                    hintStyle: InputTextStyle,



                                  ),
                                )
                            ),
                            SizedBox(width: 30,),
                            Column(
                              children: [
                                TextButton(onPressed: ()async{

                                  Student s;
                                  Navigator.of(context).pushReplacement(SlideRightRoute(
                                      page: TeacherHomepage(isTeacher,s,"","",this.auth,this.googleSignIn)
                                  ));
                                }, child:Text(
                                  'skip',
                                  textAlign: TextAlign.center,
                                  overflow: TextOverflow.ellipsis,
                                  style: TextStyle(fontWeight: FontWeight.bold,fontSize: 20),
                                ))

                              ],
                            ),
                            Column(
                              children: [
                                IconButton(
                                    icon: const Icon(Icons.arrow_forward),
                                    iconSize: 50,

                                    alignment: Alignment.topLeft,
                                    onPressed: () async {

                                      String userId =this.isTeacher.id;
                                      DocumentSnapshot isTeacher = await teachers.doc("$userId").get();

                                     selectedSubject=selectedSubject!=""?selectedSubject:isTeacher["subjects"];
                                      titleSentence=titleSentence != ""?titleSentence:isTeacher["Title Sentence"];

                                       moreDetails=moreDetails != null?moreDetails:isTeacher["More"];
                                      print("ameer can go :::::$canGo");
                                      canGo = canGo!=null?canGo:isTeacher["CanGo"];

                                      price=price != ""?price:isTeacher["Price"];

                                      Map <String,dynamic> data = {"subjects":selectedSubject,"Title Sentence":titleSentence,"More":moreDetails,"Price":price,"CanGo":canGo} ;



                                      await moreTeacherDet(data,teachers,userId);

                                      isTeacher = await   teachers.doc(this.isTeacher.id).get();
                                      Student s;
                                      Navigator.of(context).pushReplacement(SlideRightRoute(
                                          page: TeacherHomepage(isTeacher,s,"","",this.auth,this.googleSignIn)
                                      ));





                                    }
                                ),
                                Text(
                                  'Next',
                                  textAlign: TextAlign.center,
                                  overflow: TextOverflow.ellipsis,
                                  style: TextStyle(fontWeight: FontWeight.bold),
                                )
                              ],
                            ),
                          ]
                      )
                    ],
                  ),
                ),


              ],
            ),
          ),

        ),
      ),

      // This trailing comma makes auto-formatting nicer for build methods.
    );
  }

}


Future<void> moreTeacherDet(Map <String,dynamic> data,CollectionReference collectionReference,String userId)async{
  collectionReference.doc(userId).update(data);
  return;

}