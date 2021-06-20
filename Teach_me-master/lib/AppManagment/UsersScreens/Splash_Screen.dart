

import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'file:///D:/ameer/teach_me/lib/AppManagment/UsersScreens/Sign_in_Screen.dart';
import 'package:teach_me/AppManagment/routes/pageRouter.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

import '../../AppManagment/Constants/constants.dart';



class Splash extends StatefulWidget {
  @override
  SplashScreen createState() => SplashScreen();
}

class SplashScreen extends State<Splash>  {

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    Timer(Duration(seconds: 3),()=>  Navigator.of(context).pushReplacement(ScaleRoute(
       page: SignInUser()
    )));
  }

  @override
  Widget build(BuildContext context) {
    // This method is rerun every time setState is called, for instance as done
    // by the _incrementCounter method above.
    //
    // The Flutter framework has been optimized to make rerunning build methods
    // fast, so that you can just rebuild anything that needs updating rather
    // than having to individually change instances of widgets.
    return Scaffold(

      body: Container(
        decoration: MainBoxDecorationStyle,
        child: Center(

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
            mainAxisAlignment:MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,

            children: <Widget>[
              Container(

                decoration: BoxDecoration(
                  borderRadius: BorderRadius.all(Radius.circular(15.0)),

                ),
                child: Image.asset("assets/images/newlogologo.jpeg",width: 250,height: 250,)
              ),
              Text(

                'TeachMe',
                style: TextStyle(fontWeight: FontWeight.bold , fontFamily: 'Kaushan', fontSize: 50,color:Colors.white),
              ),
            SizedBox(height: 20),
              SpinKitRipple(color: Colors.black,)
            ],
          ),
        ),
      ),
      // This trailing comma makes auto-formatting nicer for build methods.
    );
  }


}