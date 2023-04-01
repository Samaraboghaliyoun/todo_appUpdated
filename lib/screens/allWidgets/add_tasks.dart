import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:todo_app/main.dart';


class AddTask extends StatefulWidget {
  @override
  State<AddTask> createState() => _AddTaskState();
}

class _AddTaskState extends State<AddTask> {
  FirebaseAuth _auth=FirebaseAuth.instance;

  TextEditingController name=TextEditingController();
@override
  void initState() {
   _getUserData();
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return Container(
      child:Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children:[
          SizedBox(height: 20),
          Text("Add New Task ", style:TextStyle(fontSize:25,
              color:Colors.pink[200],
              fontWeight: FontWeight.bold
          ),
            textAlign: TextAlign.center,
          ),
          SizedBox(height: 40,),
          TextField(
            controller: name,
            keyboardType: TextInputType.text,
            autofocus: true,
          textAlign: TextAlign.center,decoration: InputDecoration(
              hintText: "I will keep smile today",
              hintStyle: TextStyle(
                  color: Colors.grey
              )
          ),),
          SizedBox(height: 40,),
          FilledButton(onPressed: (){
                    _getUserData();
          }, child:Text("ADD",style:TextStyle(fontSize:18,
              color:Colors.white)
          ),
              style: ButtonStyle(
                backgroundColor: MaterialStatePropertyAll<Color>(Colors.pink[100]!),
                  fixedSize:MaterialStatePropertyAll<Size>(Size.fromWidth(250)) )
              ),

        ]
      )
    );
  }

  // AddNewTask() async {
  Future<void> _getUserData() async {
    final database = FirebaseFirestore.instance;
    try {
      User _currentUser = await FirebaseAuth.instance.currentUser!;
      String authid =_currentUser.uid;
      Map<String, String> userData = {
        'taskName':name.text,
      };
      database.collection('TasksData').doc(authid).set(userData).catchError((e) {
        print(e);
      });
    } catch (e) {
      print(e);
    }
  }
}
