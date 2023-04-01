import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:todo_app/screens/Signin.dart';
import 'package:todo_app/screens/home/home_screen.dart';



class Splash extends StatefulWidget{

  static const String splash= '/splash';
  @override
  State<Splash> createState() => _SplashState();
}

class _SplashState extends State<Splash> {
  @override
  void initState(){
    super.initState();
    _nevigatetohome();
  }
  _nevigatetohome() async {
    await Future.delayed(Duration(seconds: 3),(){});
    Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=> SigninScreen() ));
  }

  @override
  Widget build (BuildContext context){
    return Scaffold(
      backgroundColor: Colors.pink[50],
    body:Center(
      child:Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children:[
               Icon(Icons.favorite
               ,color: Colors.white,
               size: 40,),
          const SizedBox(height: 30,),
          CircularProgressIndicator(
            color: Colors.black,
          )
      ]
      )

    )
    );
  }
}