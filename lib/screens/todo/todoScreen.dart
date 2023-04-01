import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:todo_app/screens/allWidgets/List_toDo.dart';
import 'package:todo_app/screens/todo/review_todo_screen.dart';

import '../allWidgets/taskstodo.dart';




class todoScreen extends StatefulWidget{

  static const String todoscreen= '/';



  @override
  _todoScreen createState() => _todoScreen();
}
class _todoScreen extends State<todoScreen> {
  FirebaseAuth _auth=FirebaseAuth.instance;
  final currentuser=FirebaseAuth.instance;
  late String Taskname="";
  var taskName;


  getNameOfTask() async {
    var Taskref = await FirebaseFirestore.instance.collection('TasksData')
        .doc(currentuser.currentUser!.uid).get()
        .then((doc) => taskName=doc.get('taskName'));

    return Taskref;
  }
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      // backgroundColor: Colors.white,
        appBar: AppBar(
          leading: Icon(Icons.playlist_add_check_outlined,),
          title: Text("ToDo List", style: TextStyle(fontSize: 30.0,
            backgroundColor: Colors.pink[100],
            color: Colors.white,
          ),
          ),
          centerTitle: true,
          actions: [
            IconButton(icon: Icon(Icons.add_task),
              alignment: Alignment.center,
              onPressed: () {
                Navigator.pushNamedAndRemoveUntil(
                    context, review_todo_screen.reviewpage, (route) => false);
              },
            ),
          ],
          backgroundColor: Colors.pink[100],


        ),
        body: Container(
            padding: const EdgeInsets.only(top: 20,
              left: 10,
              right: 20,
              bottom: 80,
            ),
            child: Column(
                children: [
                  Expanded(child: ListView(
                    children: [
                      FutureBuilder(
                          future: getNameOfTask(),
                          builder: (context, snapshot) {
                            if(snapshot.hasData){
                              return Column(
                                  children: [
                                    Text("Task For Today", style: TextStyle(
                                        fontSize: 20,
                                        color: Colors.pink[200]
                                    )),
                                    SizedBox(height: 10,),
                                    Row(children: [
                                      Icon(Icons.task,color: Colors.pink[100],),
                                      Text("Tasks",style :TextStyle(fontSize: 24,color: Colors.pink[200])),
                                    ],),
                                    Card(child: Row(
                                      children: [
                                        SizedBox(width: 10,),
                                        Text(snapshot.data.toString()
                                          , style: TextStyle(
                                              fontSize: 16,
                                              color: Colors.pink[200]
                                          ),textAlign: TextAlign.center,),
                                        SizedBox(height: 40,),
                                      ],
                                    ),),

                                  ]);
                            }else{
                              return Text("No Tasks for Today",style: TextStyle(color: Colors.pink[100],fontSize: 30),
                                textAlign: TextAlign.center,);
                            }

                          }
                      )
                    ],
                  ),

                  )
                ]
            )
        )
    );



  }
  Widget  TaskName(){
    return ListTile(
      title: Text("Task",style :TextStyle(fontSize: 24,color: Colors.pink[200])),
      leading: Icon(Icons.tag_faces),
    );
  }
}
