import 'package:flutter/material.dart';

import 'List_toDo.dart';

class Tasksdoto extends StatefulWidget {

  @override
  State<Tasksdoto> createState() => _TasksdotoState();
}

class _TasksdotoState extends State<Tasksdoto> {

  @override
  Widget build(BuildContext context) {
    return ListView.builder(itemCount:4,
        itemBuilder: (context,index){
      return list_todo(

      )
    ;
    }

    );

  }
}

