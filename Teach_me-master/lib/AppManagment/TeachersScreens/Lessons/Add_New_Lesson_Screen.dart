




import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:teach_me/AppManagment/Constants/constants.dart';
import 'package:teach_me/AppManagment/routes/pageRouter.dart';
import '../../../DBManagment/FireBase_Service.dart';
import 'Lessons_Screen.dart';

// ignore: must_be_immutable
class AddNewLesson extends StatefulWidget {
  final DocumentSnapshot document;
final   DocumentSnapshot isTeacher;
final auth;
GoogleSignIn googleSignIn;


   AddNewLesson({Key key,this.isTeacher, this.document,this.auth,this.googleSignIn}) : super(key: key);
  @override
  AddNewLessonState createState() => AddNewLessonState(isTeacher,document,this.auth,this.googleSignIn);
}

class AddNewLessonState extends State<AddNewLesson> {
  String lessonSubject,stuPhoneNumber,stuName,time;
  List subjects = ["English","Math","maba","biology","physic","hebrew","arabic"];
  bool canGo=false;
  // final  GoogleSignInAccount userObj;
  final   DocumentSnapshot isTeacher;
 final  DocumentSnapshot lessonDocument;
  final dateController = TextEditingController();
  final auth;
  GoogleSignIn googleSignIn;



  AddNewLessonState( this.isTeacher, this.lessonDocument,this.auth,this.googleSignIn);



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
          padding: const EdgeInsets.all(8.0),

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
           // mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    IconButton(
                        icon: const Icon(Icons.arrow_back),
                        iconSize: 50,
                        alignment: Alignment.topLeft,
                        onPressed: () {
                          Navigator.of(context).pushReplacement(SlideRightRoute(
                              page: Lessons(isTeacher,this.auth,this.googleSignIn)
                          ));
                        }
                    ),
                    Column(
                      children: [
                        SizedBox(
                          height: 25,
                        ),
                        Image.asset("assets/images/newlogologo.jpeg",matchTextDirection: true,height: 80,width: 120),
                        Text(
                          'TeachMe',
                          style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 30,
                              fontFamily: 'Kaushan',
                              color: Colors.white),
                        ),
                      ],
                    ),
                  ]),
              SizedBox(height: 70,),
              Center(
                  child: Text(
                    this.lessonDocument!=null?'Edit Lesson':'Add New Lesson',
                    style:TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 30,
                        color: Colors.white),
                  )
              ),
              SizedBox(height: 10,),
              Center(
                  child: Text(
                    "Lesson information",
                    style:TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 20,
                        color: Colors.white),
                  )
              ),


              SizedBox(height: 40,),
              Padding(
                padding: const EdgeInsets.all(20.0),
                child: Column(
                  children: [


                    TextField(
                      keyboardType: TextInputType.emailAddress,
                      textAlign: TextAlign.center,
                      onChanged: (value) {

                        lessonSubject=value;
                      },

                      decoration: InputDecoration(
                        fillColor: Colors.white60,
                        filled: true,
                        border: OutlineInputBorder(
                            borderRadius: new BorderRadius.circular(15.0)
                        ),

                        hintText: this.lessonDocument!=null?this.lessonDocument["LessonSubject"]:'Lesson subject',
                        hintStyle: InputTextStyle,


                      ),
                    ),
                    SizedBox(height: 15,),

                    TextField(

                      keyboardType: TextInputType.emailAddress,
                      textAlign: TextAlign.center,
                      onChanged: (value) {
                        value!=null? stuPhoneNumber=value:stuPhoneNumber=this.lessonDocument["StuPhoneNumber"];

                      },
                      decoration: InputDecoration(
                        fillColor: Colors.white60,
                        filled: true,
                        border: OutlineInputBorder(
                            borderRadius: new BorderRadius.circular(15.0)
                        ),

                        hintText: this.lessonDocument!=null?this.lessonDocument["StuPhoneNumber"]:'Student Phone Number',


                        hintStyle: InputTextStyle,



                      ),
                    ),
                    SizedBox(height: 15,),

                    TextField(

                      keyboardType: TextInputType.emailAddress,
                      textAlign: TextAlign.center,
                      onChanged: (value) {

                        value!=null? stuName=value:stuName=this.lessonDocument["StudentName"];

                      },
                      decoration: InputDecoration(
                        fillColor: Colors.white60,
                        filled: true,
                        border: OutlineInputBorder(
                            borderRadius: new BorderRadius.circular(15.0)
                        ),

                        hintText: this.lessonDocument!=null?this.lessonDocument["StudentName"]:'Student Name',


                        hintStyle: InputTextStyle,



                      ),
                    ),
                    SizedBox(height: 15,),

                    Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,

                        children:<Widget>[
                          Container(
                            width: 130,
                            child: TextField(

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
                                value!=null? dateController.text=value:dateController.text=this.lessonDocument["Date"];

                                dateController.text=value;

                              },
                              decoration: InputDecoration(
                                fillColor: Colors.white60,
                                filled: true,
                                border: OutlineInputBorder(
                                    borderRadius: new BorderRadius.circular(15.0)
                                ),
                                hintText: this.lessonDocument!=null?this.lessonDocument["Date"]:'Date',
                                hintStyle: InputTextStyle,
                              ),
                            ),
                          ),
                          Container(
                              height: 70,
                              width: 150,
                              child:TextField(
                                textAlign: TextAlign.center,

                                onChanged: (value) {
                                  value.isEmpty? time=this.lessonDocument["Time"]:time=value;

                                },
                                decoration: InputDecoration(
                                  contentPadding: new EdgeInsets.symmetric(vertical: 25.0, horizontal: 10.0),
                                  fillColor: Colors.white60,
                                  filled: true,
                                  border: OutlineInputBorder(
                                      borderRadius: new BorderRadius.circular(15.0)
                                  ),

                                  hintText: this.lessonDocument!=null?this.lessonDocument["Time"]:'Time',


                                  hintStyle: InputTextStyle,



                                ),
                              )
                          ),

                        ]
                    ),
                    SizedBox(height:50,),

                    Center(
                     child: IconButton(icon: Icon(Icons.done,size: 50,), onPressed: (){
                      Map<String, dynamic> data;
                      if (this.lessonDocument!=null){
                       data ={"Date":dateController.text.isEmpty?this.lessonDocument["Date"]:dateController.text,"LessonSubject":lessonSubject.isEmpty?this.lessonDocument["LessonSubject"]:lessonSubject,"StuPhoneNumber":stuPhoneNumber.isEmpty?this.lessonDocument["StuPhoneNumber"]:stuPhoneNumber,"StudentName":stuName.isEmpty?this.lessonDocument["StudentName"]:stuName,"TeacherId":isTeacher.id,"TeacherName":this.isTeacher["FullName"],"Time":time.isEmpty?this.lessonDocument["Time"]:time};

                       editMeetingToFireStoreAsTeacher(data,this.lessonDocument.id);
                       Navigator.of(context).pushReplacement(SlideRightRoute(
                           page: Lessons(isTeacher,this.auth,this.googleSignIn)
                       ));

                      }else if(dateController.text.isEmpty|| lessonSubject.isEmpty||stuPhoneNumber.isEmpty||stuName.isEmpty||time.isEmpty ) {
                        return showDialog(context: context, builder: (context) => SureDetails());

                      }else{

                        data ={"Date":dateController.text,"LessonSubject":lessonSubject,"StuPhoneNumber":stuPhoneNumber,"StudentName":stuName,"TeacherId":isTeacher.id,"TeacherName":this.isTeacher["FullName"],"Time":time};
                        addMeetingToFireStoreAsTeacher(data);
                        Navigator.of(context).pushReplacement(SlideRightRoute(
                            page: Lessons(isTeacher,this.auth,this.googleSignIn)
                        ));
                      }






                     })
                    ),
                  ],
                ),
              ),


            ],
          ),

        ),
      ),

      // This trailing comma makes auto-formatting nicer for build methods.
    );
  }

}

class SureDetails extends StatelessWidget {



  const SureDetails({Key key}) : super(key: key);



  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      content: Container(
          height: 100,
          child: Column(
            children: <Widget>[
              new Text(" Must Enter All The Details !!"),




            ],
          )),
      title: Text(''),


    );
  }
}



