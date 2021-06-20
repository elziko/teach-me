import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'file:///D:/ameer/teach_me/lib/AppManagment/UsersScreens/Sign_in_Screen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_svg/svg.dart';
import 'package:teach_me/AppManagment/Constants/constants.dart';

import 'file:///D:/ameer/teach_me/lib/AppManagment/UsersScreens/Virefy_Screen.dart';
import 'package:teach_me/AppManagment/routes/pageRouter.dart';

// ignore: camel_case_types, must_be_immutable
class Sign_Up_User extends StatelessWidget {
  String email, password, verifypassword;
  final _formKey = GlobalKey<FormState>();
  final auth = FirebaseAuth.instance;

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

            children: <Widget>[
              SizedBox(height: 30,),
              Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    IconButton(
                        icon: const Icon(Icons.arrow_back),
                        iconSize: 50,
                        onPressed: () {
                          Navigator.of(context).pushReplacement(
                              SlideRightRoute(page: SignInUser()));
                        })
                  ]),
              Container(

                  child: SvgPicture.asset("assets/images/bookimage.svg",
                      allowDrawingOutsideViewBox: true,
                      matchTextDirection: true,
                      color: Colors.blue.shade900,
                      height: 200,
                      width: 400)),
              Text(
                'TeachMe',
                style: TextStyle(
                    fontFamily: 'Kaushan',

                    fontWeight: FontWeight.bold,
                    fontSize: 50,
                    color: Colors.white),
              ),
              SizedBox(height: 50),
              Center(
                child: Container(
                    width: 300,
                    child: Form(
                      key: _formKey,
                      child: Column(children: <Widget>[
                        TextFormField(
                          keyboardType: TextInputType.emailAddress,
                          textAlign: TextAlign.center,
                          onChanged: (value) {
                            email = value;
                          },
                          validator: (value) {
                            if (value.isEmpty || value == null) {
                              return "Must Type Email";
                            }
                            return null;
                          },
                          decoration: InputDecoration(
                            fillColor: Colors.white60,
                            filled: true,
                            border: OutlineInputBorder(
                                borderRadius:
                                    new BorderRadius.circular(15.0)),
                            hintText: 'Enter your email',
                            hintStyle: InputTextStyle,
                          ),
                        ),
                        SizedBox(height: 10),
                        TextFormField(
                          obscureText: true,
                          textAlign: TextAlign.center,
                          onChanged: (value) {
                            password = value;
                          },
                          validator: (value) {
                            if (value.isEmpty || value == null) {
                              return "Must Type New Password";
                            }
                            return null;
                          },
                          decoration: InputDecoration(
                            fillColor: Colors.white60,
                            filled: true,
                            border: OutlineInputBorder(
                                borderRadius:
                                    new BorderRadius.circular(15.0)),
                            hintText: 'Enter new password',
                            hintStyle: InputTextStyle,
                          ),
                        ),
                        SizedBox(height: 10),
                        TextFormField(
                          obscureText: true,
                          textAlign: TextAlign.center,
                          onChanged: (value) {
                            verifypassword = value;
                          },
                          validator: (value) {
                            if (value.isEmpty || value == null)
                                  return "ReType Your Password";
                            if(value!=password)
                                  return'Passwords not Match';
                            return null;
                          },
                          decoration: InputDecoration(
                            fillColor: Colors.white60,
                            filled: true,
                            border: OutlineInputBorder(
                                borderRadius:
                                    new BorderRadius.circular(15.0)),
                            hintText: 'Verify your password',
                            hintStyle: InputTextStyle,
                          ),
                        ),
                      ]),
                    )),
              ),
              SizedBox(height: 2),
              ElevatedButton(
                // color: Colors.white60,
                // textColor: Colors.black,
                // shape: RoundedRectangleBorder(
                //   side: BorderSide(color: Colors.black,width: 1.8),
                //   borderRadius: BorderRadius.circular(10),
                // ),
                style: ButtonStyle(
                    backgroundColor:
                        MaterialStateProperty.all(Colors.white60),
                    textStyle: MaterialStateProperty.all(
                        TextStyle(color: Colors.blue))),
                onPressed: () async {
                  if (_formKey.currentState.validate()) {

                    auth.createUserWithEmailAndPassword(email: this.email, password: this.password).then((value)  {
                      Navigator.of(context).pushReplacement(CupertinoPageRoute(
                          builder: (context) => VerifyEmail(this.auth)
                      ));
                    });

                      // Userbg user = Userbg(
                      //     email, password, verifypassword, "", "", "", "");
                      // user.signUp(context,_auth);


                  }
                },

                child: const Text(
                  'sign up',
                  style: TextStyle(fontSize: BtnFontSize,fontFamily: BtnFont),
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
