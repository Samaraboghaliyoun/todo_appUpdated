import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:todo_app/screens/home/home_screen.dart';
import 'package:todo_app/screens/todo/todoScreen.dart';

import '../main.dart';
import 'allWidgets/progressDialog.dart';





class SigninScreen extends StatelessWidget {
  static const String idScreen = "/login";

  TextEditingController emailTextEditingController = TextEditingController();
  TextEditingController passwordTextEditingController = TextEditingController();



  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor:Colors.pink[100],
        title:Text("ToDo List",style: TextStyle( fontSize:30.0,
          backgroundColor: Colors.pink[100],
          color: Colors.white,),
        ),),
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        child: Column(
          children: [
            SizedBox(height: 20.0,),
            Text(
              " Welcome, Sign in ",
              style: TextStyle(fontSize: 25.0,
                  fontFamily: "Brand Bold",
                  color:Colors.pink[200] ),
              textAlign: TextAlign.center,
            ),

            Padding(
              padding: EdgeInsets.all(20.0),
              child: Column(
                children: [
                  SizedBox(height: 1.0,),
                  TextField(
                    controller: emailTextEditingController,
                    keyboardType: TextInputType.emailAddress,
                    decoration: InputDecoration(
                      hintText:"email@gmail.com",
                      labelText: "Enter Email",
                      labelStyle: TextStyle(
                          fontSize: 14.0,color: Colors.pink[200]
                      ),
                      hintStyle: TextStyle(
                          color: Colors.grey,
                          fontSize: 14.0
                      ),
                    ),
                    style: TextStyle(fontSize: 14.0),
                  ),
                  SizedBox(height: 20.0,),
                  TextField(
                    controller: passwordTextEditingController,
                    obscureText: true,
                    decoration: InputDecoration(
                      hintText:"*********",
                      labelText: "Enter Password",
                      labelStyle: TextStyle(
                          fontSize: 14.0,color: Colors.pink[200]
                      ),
                      hintStyle: TextStyle(
                          color: Colors.grey,
                          fontSize: 14.0
                      ),
                    ),
                    style: TextStyle(fontSize: 14.0),
                  ),
                  SizedBox(height: 30.0,),
                  ElevatedButton(
                    style: ButtonStyle(backgroundColor: MaterialStatePropertyAll<Color>(
                        Colors.pink[100]!)),
                    child: Container(
                      height: 50.0,
                      child: Center(
                        child: Text(
                          "Sign in ",
                          style: TextStyle(fontSize: 18.0,
                              fontFamily: "Brand Bold"),
                        ),
                      ),
                    ),
                    onPressed: () {
                      if (!emailTextEditingController.text.contains("@")) {
                        displayToastMsg("Email address is invalid", context);
                      }
                      else if (passwordTextEditingController.text.isEmpty) {
                        displayToastMsg("Password must be entered", context);
                      }
                      else if (passwordTextEditingController.text.length < 6) {
                        displayToastMsg(
                            "Password must be at least 6 characters", context);
                      }
                      else {
                        loginUser(context);
                      }
                    },
                  ),
                  SizedBox(height: 10.0,),
                ],
              ),

            ),
            SizedBox(height: 4.0,),

            TextButton(
              onPressed: () {
                Navigator.pushNamedAndRemoveUntil(
                    context, LoginScreen.homescreen, (route) => false);
              },

              child: Text("do not have an account? register here",
                style: TextStyle(fontSize: 12.0,
                    fontFamily: "Brand Bold",
                    color: Colors.pink[200]),
              ),

            ),
          ],

        ),
      ),
    );
  }

  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;
  void loginUser(BuildContext context) async {
    showDialog(
        context: context,
        barrierDismissible: false,
        builder: (BuildContext context)
        {
          return ProgressDialog(msg: "Authenticating, please wait...",);
        }
    );
   try{
    final  firebaseUser = (await _firebaseAuth
        .signInWithEmailAndPassword(
        email: emailTextEditingController.text,
        password: passwordTextEditingController.text).catchError((errMsg) {
      Navigator.pushNamedAndRemoveUntil(context, todoScreen.todoscreen,
              (route) => false);
      displayToastMsg("Error: " + errMsg.toString(), context);
    }));
    if(firebaseUser !=null){
      print('sucess');
    }
    Navigator.pushNamedAndRemoveUntil(context, todoScreen.todoscreen,
            (route) => false);
   }
    catch (e){

    }
    }

  //   try {
  //     UserCredential userCredential = await _firebaseAuth
  //         .signInWithEmailAndPassword(
  //         email: emailTextEditingController.text,
  //         password: passwordTextEditingController.text);
  //     final User? firebaseUser = userCredential.user;
  //     if (firebaseUser != null) {
  //       final DatabaseEvent event = await
  //       Users.child(firebaseUser.uid).once();
  //       if (event.snapshot.value != null) {
  //         Navigator.pushNamedAndRemoveUntil(context, todoScreen.todoscreen,
  //                 (route) => false);
  //         displayToastMsg("Login successful", context);
  //       } else {
  //         displayToastMsg("There is no such account, please register",
  //             context);
  //         await _firebaseAuth.signOut();
  //       }
  //     } else {
  //       displayToastMsg("Error: Cannot be signed in", context);
  //     }
  //   } catch(e) {
  //     // handle error
  //   }
  //
  //   if (firebaseUser != null) {
  //     Users.child(firebaseUser.uid).once().then((value)=> (DataSnapshot snap) {
  //       if (snap.value != null) {
  //         Navigator.pushNamedAndRemoveUntil(context, todoScreen.todoscreen, (route) => false);
  //         displayToastMsg("logged in successfully", context);
  //       }
  //       else {
  //         Navigator.pop(context);
  //         _firebaseAuth.signOut();
  //         displayToastMsg(
  //             "There is no such account, please register", context);
  //       }
  //     });
  //   }
  //
  //   else {
  //     Navigator.pop(context);
  //     displayToastMsg("Error occurred, can not log in", context);
  //   }
  //   _firebaseAuth.currentUser== null? Navigator.pushNamedAndRemoveUntil(context, SigninScreen.idScreen, (route) => false):
  //   Navigator.pushNamedAndRemoveUntil(context , todoScreen.todoscreen ,(route) => false);
  // }
  //
   displayToastMsg(String msg,BuildContext context )
   {
    Fluttertoast.showToast(msg: msg);
  }


}



