import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:todo_app/screens/todo/todoScreen.dart';

import '../../main.dart';
import '../allWidgets/progressDialog.dart';
class  LoginScreen extends StatelessWidget {
  static const String homescreen= "/homeScreen";
  TextEditingController name=TextEditingController();
  TextEditingController password=TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.pink[100],
        leading: Icon(Icons.playlist_add_check_outlined,),
    title: Text("ToDo List",style: TextStyle( fontSize:30.0,
    backgroundColor: Colors.pink[100],
    color: Colors.white,
    ),
    ),),

        backgroundColor: Colors.white,
        body: SingleChildScrollView(
        child: Column(
        children: [

    SizedBox(height: 80.0,),
    Text(
    "Welcome,Sign in",
    style: TextStyle(fontSize: 25.0,
    fontFamily: "Brand Bold",
    color: Colors.pink[200]),
    textAlign: TextAlign.start,
    ),
           Padding(
            padding: EdgeInsets.all(20.0),
          child: Column(
           children: [
      SizedBox(height: 3.0,),
        TextFormField(
        controller: name,
       keyboardType: TextInputType.text,
        decoration: InputDecoration(
         hintText:"Todo@gmail.com",
         labelText: "Email address",
         labelStyle: TextStyle(
         fontSize: 14.0,color: Colors.pink[200]
    ),
        hintStyle: TextStyle(
       color: Colors.grey,
       fontSize: 12.0
    ),
    ),
    style: TextStyle(fontSize: 14.0),
    ),
             SizedBox(height: 1.0,),
             TextFormField(
               controller: password,
               keyboardType: TextInputType.text,
               decoration: InputDecoration(
                 hintText:"*******",
                 labelText: "Password",
                 labelStyle: TextStyle(
                     fontSize: 14.0,color: Colors.pink[200]
                 ),
                 hintStyle: TextStyle(
                     color: Colors.grey,
                     fontSize: 12.0
                 ),
               ),
               style: TextStyle(fontSize: 14.0),
             ),
              SizedBox(height: 40.0,),
               ElevatedButton(
               style: ButtonStyle(backgroundColor: MaterialStatePropertyAll<Color>(
                    Colors.pink[100]!
      )),

    child: Container(
    height: 50.0,
    child: Center(
    child: Text(
    "Create Account",
    style: TextStyle(fontSize: 18.0,
    fontFamily: "Brand Bold"),
    ),
    ),
    ),
    onPressed: () {
      if (!name.text.contains("@")) {
        displayToastMsg("Email address is invalid", context);
      }
      else if (password.text.length < 6) {
        displayToastMsg(
            "Password must be at least 6 characters", context);
      }
      else {
        registerNewUser(context);
      }

    },
    ),
    ],
    )
    )
            ],
        )
    )
    );

  }

  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;

  Stream<String> get onAuthStateChanged =>
      _firebaseAuth.authStateChanges().map(
              ( User? FirebaseUser) => User != null?(FirebaseUser!.uid):""
      );
  void registerNewUser(BuildContext context) async {
    showDialog(
        context: context,
        barrierDismissible: false,
        builder: (BuildContext context) {
          return ProgressDialog(msg: "Registering, please wait...",);
        }
    );
    final User? firebaseUser = (await _firebaseAuth
        .createUserWithEmailAndPassword(
        email: name.text,
        password: password.text).catchError((errMsg) {
      Navigator.pop(context);
      displayToastMsg("Error: " + errMsg.toString(), context);
    })).user;
    if (firebaseUser != null) {
      //user created
      //save user data
      Users.child(firebaseUser.uid);
      displayToastMsg("Account has been created successfully", context);
      Navigator.of(context).pushNamed('/');
      //Navigator.pop(context);
    }
    else if (firebaseUser != null) {
      try {
        UserCredential userCredential = await _firebaseAuth
            .signInWithEmailAndPassword(
            email: name.text,
            password: password.text);
        final User? firebaseUsers= userCredential.user;
        if (firebaseUsers != null) {
          final DatabaseEvent event = await
          Users.child(firebaseUser.uid).once();
            if (event.snapshot.value != null) {
              Navigator.pushNamedAndRemoveUntil(
                  context, todoScreen.todoscreen, (route) => false);
              displayToastMsg("logged in successfully", context);
            }
            else {
              displayToastMsg("There is no such account, please register",
                  context);
              await _firebaseAuth.signOut();
            }

        }
        else {
          Navigator.pop(context);
          displayToastMsg("Error occurred, can not log in", context);
        }
      }
      catch (e) {
        // handle error
      }
    }
    else {
      Navigator.pop(context);
      //error occurred-display error message
      displayToastMsg("New account has not been created", context);
    }
  }
  }



displayToastMsg(String msg, BuildContext context) {
  Fluttertoast.showToast(msg: msg);
}




