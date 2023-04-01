import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import '../allWidgets/add_tasks.dart';
import '../allWidgets/taskstodo.dart';
import 'todoScreen.dart';
class review_todo_screen extends StatefulWidget
{
  static const String reviewpage= "/reviewScreen";


  @override
  _review_todo createState() => _review_todo();
}

class _review_todo extends State<review_todo_screen>  {

  TextEditingController name=TextEditingController();
  final currentuser=FirebaseAuth.instance;
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
  // TODO: implement createState
  @override
  Widget build(BuildContext context) {

    // TODO: implement build
    return Scaffold(
        appBar: AppBar(
          leading: Icon(Icons.playlist_add_check_outlined,),
          title: Text("ToDo List",style: TextStyle( fontSize:30.0,
            backgroundColor: Colors.pink[100],
            color: Colors.white,
          ),
          ),
          centerTitle: true,
          actions: [
            IconButton(icon: Icon(Icons.arrow_forward),alignment:Alignment.center , onPressed: () {
              Navigator.pushNamedAndRemoveUntil(
                  context, todoScreen.todoscreen, (route) => false);}
            ),
          ],
          backgroundColor: Colors.pink[100],
        ),
        body: Container(
          // padding: const EdgeInsets.only(top:20,
          //   left:10,
          //   right:20,
          //   bottom:20,
          //
          // ),
          child:Column(
            children:[
              Expanded(child: ListView(
                children: [
                  FutureBuilder(
                      future: getNameOfTask(),
                      builder: (context, snapshot) {
                        if(snapshot.hasData){
                          return Column(
                              children: [
                                SizedBox(height: 20,),
                                Text("Task For Today", style: TextStyle(
                                    fontSize: 20,
                                    color: Colors.pink[200]
                                ),textAlign: TextAlign.center,),
                                SizedBox(height: 10,),
                                //TaskName(),
                                Row(children: [
                                  Icon(Icons.task,color:Colors.pink[100]),
                                  Text("Tasks",style :TextStyle(fontSize: 24,color: Colors.pink[200])),
                                ],),

                                Card(child:
                                Row(
                                  children: [
                                    SizedBox(width: 10,),
                                    Text(snapshot.data.toString()
                                      , style: TextStyle(
                                        fontSize: 16,
                                        color: Colors.pink[200],
                                      ),textAlign: TextAlign.left,),
                                    SizedBox(width: 20,),
                                    IconButton(icon: Icon(Icons.edit,size: 20,),alignment:Alignment.centerRight,color: Colors.pink[100] , onPressed: () {
                                      showDialog(context: context, builder: (BuildContext) {
                                        return AlertDialog(
                                          title: Text("Edit task",
                                            style: TextStyle(color: Colors.pink[200],
                                            ), textAlign: TextAlign.center,),
                                          content: TextFormField(
                                            controller: name,
                                            keyboardType: TextInputType.text,
                                            autofocus: true,
                                            onChanged: (value) {
                                              setState(() {
                                                name.text = value;
                                              });
                                            },
                                            decoration: InputDecoration(
                                                hintText: "I will keep smile today",
                                                hintStyle: TextStyle(
                                                    color: Colors.grey
                                                )
                                            ),
                                          ),
                                          actions: [
                                            FilledButton(onPressed: (){
                                              _getUpdateData(name.text.toString());
                                            }
                                                ,child: Text("Save"),
                                                style: ButtonStyle(
                                                    backgroundColor: MaterialStatePropertyAll<Color>(Colors.pink[100]!)
                                                ))

                                          ],
                                        );
                                      });
                                    }  ),
                                    IconButton(icon: Icon(Icons.delete,size: 20,),alignment:Alignment.centerRight,color: Colors.pink[100] ,
                                      onPressed: (){
                                      _getDeleteData();
                                      },)
                                  ],
                                ),),

                              ]);
                        }else{
                          return Text("\nNo Tasks for Today",style: TextStyle(color: Colors.pink[100],fontSize: 30),
                            textAlign: TextAlign.center,);
                        }
                      }
                  ),

                  SizedBox(height: 600,),
                  FilledButton(onPressed: (){
                    showModalBottomSheet
                      ( isScrollControlled: true,

                        context: context, builder: (context)=> SingleChildScrollView(
                          child: Container(
                            padding: EdgeInsets.only(
                                bottom: MediaQuery.of(context).viewInsets.bottom
                            ),
                            child: AddTask(
                            ),
                          ),
                        ));
                  }, child: Icon(Icons.add)
                      ,style: ButtonStyle(
                          backgroundColor: MaterialStatePropertyAll<Color>(Colors.pink[100]!)
                      ))


                ],
              ),
              ),
            ],
          ),
        )

    );


  }
  Future<void> _getUpdateData(value) async {
    final database = FirebaseFirestore.instance;
    try {
      User _currentUser = await FirebaseAuth.instance.currentUser!;
      String authid =_currentUser.uid;

      Map<String, String> userData = {
        'taskName':value,
      };
      database.collection('TasksData').doc(authid).update(userData).catchError((e) {
        print(e);
      });
    } catch (e) {
      print(e);
    }
  }

  Future<void> _getDeleteData() async {
    final database = FirebaseFirestore.instance;
    try {
      User _currentUser = await FirebaseAuth.instance.currentUser!;
      String authid =_currentUser.uid;
      database.collection('TasksData').doc(authid).delete().catchError((e) {
        print(e);
      });
    } catch (e) {
      print(e);
    }
  }

  Widget  TaskName(){
    return ListTile(
      title: Text("Tasks",style :TextStyle(fontSize: 24,color: Colors.pink[200])),
     // tileColor: Colors.white ,
      leading: Icon(Icons.tag_faces),
    );
  }

}






