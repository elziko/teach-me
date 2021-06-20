import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'file:///D:/ameer/teach_me/lib/AppManagment/UsersScreens/Sign_in_Screen.dart';


class Page1 extends StatelessWidget  {
  Widget build(BuildContext context) {
    // This method is rerun every time setState is called, for instance as done
    // by the _incrementCounter method above.
    //
    // The Flutter framework has been optimized to make rerunning build methods
    // fast, so that you can just rebuild anything that needs updating rather
    // than having to individually change instances of widgets.
    return Scaffold(

      body: Center(

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

          children: <Widget>[
            SizedBox(height: 60.0,),

            SizedBox(height: 15.0,),
            Text(
              'TeachMe',
              style: TextStyle(fontSize: 45                               , fontFamily: 'Kaushan'
              ),
            ),
            SizedBox(height: 30),

             SizedBox(height: 20.0,),
            TextButton(
              onPressed: () {


              },
              child: Text(
                "Logout",
                style: TextStyle(color: Colors.black, fontSize: 18.0),
              ),
            ),SizedBox(height: 20.0,),
            TextButton(
              onPressed: () {
                 Navigator.of(context).pushReplacement(CupertinoPageRoute(
                   builder: (context) => SignInUser()

                ));

              },
              child: Text(
                "back",
                style: TextStyle(color: Colors.black, fontSize: 18.0),
              ),
            ),


          ],
        ),
      ),
      // This trailing comma makes auto-formatting nicer for build methods.
    );
  }


}

