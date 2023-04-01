import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class list_todo extends StatefulWidget {

  @override
  State<list_todo> createState() => _list_todoState();
}

class _list_todoState extends State<list_todo> {
  FirebaseAuth _auth=FirebaseAuth.instance;
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
        child:
            ListView.builder(itemCount: 4,
                itemBuilder: (context, index) {
                  return ListView(
                    children: [
                      FutureBuilder<String>(
                          future: getNameOfTask(),
                        builder: (context,snapshot) {
                          //if (snapshot.hasData) {
                            return Row(
                              children:[
                              Text(snapshot.data.toString(), style: TextStyle(
                                  fontSize: 16,
                                  color: Colors.pink[200]
                              )),

                          ],
                            );
                        }
                          ),
                    ],
                  );
                }
            )


    );
  }
 Future<String> getNameOfTask() async{
    var document;
    User? curser= await _auth.currentUser;
    DocumentReference reference=FirebaseFirestore.instance.collection('TasksData').
    doc(curser?.uid);
    var c=reference.collection('TasksData');
    var query= await c.get();
    for(var snapshot in query.docs){
      document=snapshot.id;

    }
    final DocumentReference documentReference=(await reference.collection('TasksData').
    doc(document).get()) as DocumentReference<Object?>;
    String Tasksname= documentReference.get().toString();
    print(Tasksname);
    return Tasksname;

 }
}



