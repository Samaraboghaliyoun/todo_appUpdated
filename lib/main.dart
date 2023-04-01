import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:todo_app/screens/Signin.dart';
import 'package:todo_app/screens/allWidgets/add_tasks.dart';
import 'package:todo_app/screens/home/home_screen.dart';
import 'package:todo_app/screens/splash.dart';
import 'screens/todo/todoScreen.dart';
import 'screens/todo/review_todo_screen.dart';
import 'package:provider/provider.dart';
import 'package:firebase_auth/firebase_auth.dart';



Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MyApp());
}

 DatabaseReference Tasks=FirebaseDatabase.instance.reference().child('tasks');
DatabaseReference Users=FirebaseDatabase.instance.reference().child('users');


class MyApp extends StatelessWidget {
  const MyApp({Key ? key }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return FutureBuilder(
        future: Firebase.initializeApp(),
        builder: (BuildContext, snapshot) {
          if (snapshot.hasError) {
            return Text('error');
          }
            return
              MaterialApp(
              debugShowCheckedModeBanner: false,
              title: 'ToDo List',
              initialRoute: '/splash',
              routes: { '/splash': (context) => Splash(),
              "/login":(context)=> SigninScreen(),
              '/': (context) => todoScreen(),
              "/reviewScreen": (context) => review_todo_screen(),
                "/homeScreen":(context)=> LoginScreen(),
              }
            );

          }
    );
  }
}