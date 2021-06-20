import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'file:///D:/ameer/teach_me/lib/AppManagment/StudentsScreens/Student_Activity_Home_Screen.dart';
import 'file:///D:/ameer/teach_me/lib/AppManagment/StudentsScreens/Search_for_Teacher_Screens/Search_For_Teacher_Result_Second_Screen.dart';
import 'package:teach_me/AppManagment/Constants/constants.dart';
import 'package:teach_me/UserManagment/StudentManagment/Student.dart';
import 'package:teach_me/AppManagment/routes/pageRouter.dart';

// ignore: must_be_immutable
class SearchForTeacherStudentActivity extends StatefulWidget {
  Student student;
  GoogleSignIn googleSignIn;
  final auth;
  List<dynamic> cities;
  List<dynamic> subjects;

  SearchForTeacherStudentActivity(
      this.student, this.googleSignIn, this.auth, this.subjects,this.cities);

  @override
  SearchForTeacherState createState() => SearchForTeacherState(
      student, this.googleSignIn, this.auth, this.subjects,this.cities);
}

class SearchForTeacherState extends State<SearchForTeacherStudentActivity> {
  bool showvalue = false;
  var controler = new TextEditingController();
  var controlersecond = new TextEditingController();
  List<dynamic> subjects;
  List<dynamic> cities;

  static String selectedSubject;
  String _selectedLocation;
  final auth;

  Student student;
  GoogleSignIn googleSignIn;

  SearchForTeacherState(
      this.student, this.googleSignIn, this.auth, this.subjects,this.cities);

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
        width: MediaQuery.of(context).size.width,
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
                  SizedBox(
                    height: 25,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      IconButton(
                          icon: const Icon(Icons.arrow_back),
                          iconSize: 50,
                          onPressed: () {
                            Navigator.of(context).pushReplacement(
                                SlideRightRoute(
                                    page: StudentActivity(
                                        this.student, this.googleSignIn)));
                          }),
                    ],
                  ),
                  Center(
                    child: Column(children: [
                      Container(
                          child: Image.asset("assets/images/newlogologo.jpeg",
                              matchTextDirection: true,
                              height: 160,
                              width: 250)),
                      Text(
                        'TeachMe',
                        style: TextStyle(
                            fontFamily: 'Kaushan',
                            fontWeight: FontWeight.bold,
                            fontSize: 30,
                            color: Colors.white),
                      ),
                    ]),
                  ),
                  SizedBox(
                    height: 70,
                  ),
                  Padding(
                    padding: const EdgeInsets.all(15.0),
                    child: Column(children: <Widget>[
                      Center(
                        child: Text(
                          "Subject",
                          style: TextStyle(color: Colors.black, fontSize: 20),
                        ),
                      ),
                      SizedBox(
                        height: 4,
                      ),
                      Autocomplete(
                        optionsBuilder: (TextEditingValue value) {
                          // When the field is empty
                          if (value.text.isEmpty) {
                            return [];
                          }

                          // The logic to find out which ones should appear
                          return this.subjects.where((suggestion) => suggestion
                              .toLowerCase()
                              .startsWith(value.text.toLowerCase()));
                        },
                        onSelected: (value) {
                          setState(() {
                            selectedSubject = value;
                          });
                        },
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      Center(
                        child: Text(
                          "City",
                          style: TextStyle(color: Colors.black, fontSize: 20),
                        ),
                      ),
                      SizedBox(
                        height: 4,
                      ),
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
                              _selectedLocation = value;
                            });
                          },
                        ),
                      ),
                      SizedBox(
                        height: 20,
                      ),
                      //  Text(_selectedAnimal != null
                      //    ? _selectedAnimal
                      //  : 'Type something (a, b, c, etc)'),
                    ]),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(15.0),
                    child: Row(
                      children: [
                        Text(
                          "By Your Place",
                          style: TextStyle(
                            fontSize: 20,
                            color: Colors.black,
                          ),
                        ),
                        Checkbox(
                          value: this.showvalue,
                          onChanged: (bool value) {
                            setState(() {
                              this.showvalue = value;
                            });
                          },
                        ),
                      ],
                    ),
                  ),
                  SizedBox(
                    height: 50,
                  ),
                  IconButton(
                      icon: const Icon(Icons.done),
                      iconSize: 50,
                      alignment: Alignment.bottomCenter,
                      onPressed: () async {
                        //  //List<Teacher> TeachersList= await student.getTeacherDetails(selectedSubject, _selectedLocation);
                        //
                        //  print(TeachersList.first.fullName);
                        //
                        // if(TeachersList==null){
                        //   print("here ------------> Nulll");
                        // }
                        // else{
                        //   print("here -----------> NOT NULL");
                        // }

                        Navigator.of(context).pushReplacement(SlideRightRoute(
                            page: SearchForTeacherViewTeachers(
                          auth: this.auth,
                          selectedSubject: selectedSubject,
                          selectedLocation: _selectedLocation,
                          s: student,
                          googleSignIn: this.googleSignIn,
                        )));
                        // CollectionReference  cities=FirebaseFirestore.instance.collection("Cities");
                        //
                        // Map<String, dynamic> data = {"cities": locations};
                        // cities.add(data);
                      }),
                ]),
          ),
        ),
      ),
    );
  }
}
