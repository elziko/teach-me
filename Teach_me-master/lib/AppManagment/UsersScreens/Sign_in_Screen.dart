import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'file:///D:/ameer/teach_me/lib/AppManagment/UsersScreens/Account_Type_Screen.dart';
import 'file:///D:/ameer/teach_me/lib/AppManagment/TeachersScreens/Teacher_Home_Page_Screen.dart';
import 'package:teach_me/AppManagment/Constants/constants.dart';
import 'package:teach_me/UserManagment/StudentManagment/Student.dart';
import 'package:teach_me/AppManagment/routes/pageRouter.dart';
import 'file:///D:/ameer/teach_me/lib/AppManagment/UsersScreens/Sign_Up_User_Screen.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';







import '../StudentsScreens/Student_Activity_Home_Screen.dart';

class SignInUser extends StatefulWidget {
  SignInUser({Key key, this.title}) : super(key: key);

  // This widget is the home page of your application. It is stateful, meaning
  // that it has a State object (defined below) that contains fields that affect
  // how it looks.

  // This class is the configuration for the state. It holds the values (in this
  // case the title) provided by the parent (in this case the App widget) and
  // used by the build method of the State. Fields in a Widget subclass are
  // always marked "final".

  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<SignInUser> {

    String email ,password ;
  CollectionReference teachers = FirebaseFirestore.instance.collection("Teachers");
  CollectionReference students = FirebaseFirestore.instance.collection("Students");
  final _formKey = GlobalKey<FormState>();
  final auth = FirebaseAuth.instance;


  final GoogleSignIn _googleSignIn = new GoogleSignIn(
    scopes: [
      'email',
      // 'https://www.googleapis.com/auth/contacts.readonly',
    ],
  );
  GoogleSignInAccount _userObj;
  bool isLoggedin=false;

 Future<bool> _login ()async{
    try{
      _userObj=  await _googleSignIn.signIn();
      setState(() {
         isLoggedin=true;

      });
      print("hereeeee ${_userObj.displayName}");
      return isLoggedin;
    }catch(e){
      print(e);

    }
    return null;
  }


//  _logout()async{
//   try{
//     await _googleSignIn.signOut();
//     setState(() {
//       isLoggedin=false;
//     });
//
//   }catch(e){
//     print(e);
//
//   }
//
// }



  @override
  Widget build(BuildContext context) {
    // This method is rerun every time setState is called, for instance as done
    // by the _incrementCounter method above.
    //
    // The Flutter framework has been optimized to make rerunning build methods
    // fast, so that you can just rebuild anything that needs updating rather
    // than having to individually change instances of widgets.

    return  Scaffold(

        body:Container(
          height: MediaQuery.of(context).size.height,
          width:  MediaQuery.of(context).size.width,

          decoration: MainBoxDecorationStyle,
          child: Center(

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

                  // Container(child: Icon(FontAwesomeIcons.swatchbook, size: 30,color :Colors.white)),
                  Container(child: Image.asset("assets/images/newlogologo.jpeg",matchTextDirection: true,height: 200,width: 250)),

                  Text(
                    'TeachMe',
                    style: TextStyle(fontWeight: FontWeight.bold ,fontFamily: 'Kaushan',  fontSize: 50,color:Colors.white),
                  ),
                  SizedBox(height: 50),
                  Center(
                    child: Container(
                        width: 300,
                        child:Form(
                          key: _formKey,
                          child: Column(

                              children: <Widget>[
                                TextFormField(
                                  onChanged: (value){
                                    email = value;
                                  },
                                  validator:(value){
                                    if(value.isEmpty|| value==null){
                                      return "Must Type Email";
                                    }
                                    return null;
                                  } ,
                                  keyboardType: TextInputType.emailAddress,
                                  decoration: InputDecoration(
                                    fillColor: Inputfillcolor, filled: true,
                                    border: OutlineInputBorder(

                                        borderRadius: new BorderRadius.circular(15.0)
                                    ),

                                    hintText: 'Enter your email' ,
                                    hintStyle: InputTextStyle,


                                  ),
                                ),
                                SizedBox(height: 10),
                                TextFormField(
                                    validator:(value){
                                      if(value.isEmpty|| value==null){
                                        return "Must Type Password";
                                      }
                                      return null;
                                    },
                                    onChanged: (value){
                                    password=value;
                                  },
                                  keyboardType: TextInputType.visiblePassword,
                                    obscureText: true,

                                  decoration: InputDecoration(
                                    fillColor: Inputfillcolor, filled: true,
                                    border: OutlineInputBorder(
                                        borderRadius: new BorderRadius.circular(15.0)
                                    ),
                                    hintText: 'Enter your password',
                                    hintStyle: InputTextStyle,


                                  ),
                                ),
                              ]
                          ),
                        )
                    ),
                  ) ,
                  SizedBox(height: 5),
                  ElevatedButton(

                    style: ButtonStyle(
                      backgroundColor: MaterialStateProperty.all(Colors.white60),
                      textStyle: MaterialStateProperty.all(TextStyle(
                        color: Colors.blue
                      ))


                    ),
                    onPressed: () async {

                     // Userbg newlogin = Userbg(email,password,"","","","","");
                    // final userCredential= newlogin.login(context, Teachers);

                      if (_formKey.currentState.validate()) {
                        // TODO submit

                        try {
                          final  userCredential = await auth.signInWithEmailAndPassword(
                            email: email,
                            password: password,

                          );

                          if(userCredential != null){
                            DocumentSnapshot isTeacher = await teachers.doc("${userCredential.user.uid}").get();
                            if(isTeacher.exists){

                              Student s;
                              Navigator.of(context).pushReplacement(CupertinoPageRoute(
                                  builder: (context) => TeacherHomepage(isTeacher,s,"","",auth,this._googleSignIn)
                              ));
                            }else{
                              DocumentSnapshot student = await students.doc("${userCredential.user.uid}").get();

                              String fullName= student.get(FieldPath(["FullName"]));
                              String location= student.get(FieldPath(["Location"]));
                              String phoneNumber= student.get(FieldPath(["PhoneNumber"]));
                             // String grade= student.get(FieldPath(["grade"]));
                              String birthDate= student.get(FieldPath(["BirthDate"]));


                              Student s = new Student("email", "password", "verifyPassword", fullName, birthDate, phoneNumber, location, true);
                              print("isStudent");
                              Navigator.of(context).pushReplacement(CupertinoPageRoute(
                                  builder: (context) => StudentActivity(s,_googleSignIn)
                              ));

                            }
                          }

                        } on FirebaseAuthException catch (e) {
                          if (e.code == 'user-not-found') {
                            print('No user found for that email.');
                          } else if (e.code == 'wrong-password') {
                            print('Wrong password provided for that user.');
                          }
                        }
                      }



                      }


  ,
                    child: const Text(
                      'sign in',
                      style: TextStyle(fontSize: BtnFontSize,fontFamily: BtnFont),
                    ),
                  ),

                  SizedBox(height: 16),
                  // Align(
                  //     alignment: Alignment.bottomRight,
                  //     child: IconButton( icon: const Icon(Icons.help),iconSize: 70,alignment: Alignment.topRight, onPressed: ()=>showDialog(
                  //       context: context,
                  //       builder: (context) => AboutWidget(),
                  //
                  //     ),
                  //
                  //     )
                  //
                  // ),
                  Text("OR",
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 15,
                    fontWeight: FontWeight.bold
                      ,fontFamily: BtnFont
                  ),),
                  SizedBox(height: 16),

                  Container(
                    decoration: BoxDecoration(
                        border: Border.all(
                          color: Colors.white,
                        ),
                        borderRadius: BorderRadius.all(Radius.circular(20))

                    ),
                    child: IconButton(
                      color: Colors.black,
                    icon:Icon( FontAwesomeIcons.google),
                      onPressed: () async {

                        bool isLogedin=  await   _login();

                        if (isLogedin == true)
                        {

                          Navigator.of(context).pushReplacement(SlideRightRoute(
                              page: AccountType(googleSignIn: _googleSignIn,userObj: _userObj,)
                          ));
                        }

                      },
                    ),
                  ),
                  SizedBox(height: 30,),

                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text("Have no Account ?"),
                      TextButton(onPressed: ()async {


                        Navigator.of(context).pushReplacement(SlideRightRoute(
                            page: Sign_Up_User()
                        ));

                      } , child:Text(
                        'sign up',
                        style: TextStyle(fontSize: BtnFontSize,  decoration: TextDecoration.underline,fontFamily: BtnFont),
                      ), ),

                    ],
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

class AboutWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      content: new Text("Alert Dialog body this is our app jfvkdvs"
          "dsdsdcsdcsdsvsv"),
      title: Text('data'),

    );
  }
}