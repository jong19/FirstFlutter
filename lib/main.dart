import 'package:first_flutter/screens/login.dart';
import 'package:flutter/material.dart';
import 'package:splashscreen/splashscreen.dart';


void main() => runApp(FlutterApp());


class FlutterApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false, 

      theme: ThemeData(
        primarySwatch: Colors.teal,
         //primaryColor: Colors.teal[500],
   
      ),

       home: Scaffold(
        //backgroundColor: Colors.orange[300],
        body: Splash(),
        
      )
        
    );

  }
}


class Splash extends StatefulWidget {
  @override
  _SplashState createState() => _SplashState();
}


class _SplashState extends State<Splash> {
  @override
  Widget build(BuildContext context) {

    AssetImage splashImage = AssetImage("images/first_flutter.png");

    return new SplashScreen(
      seconds: 5,
      navigateAfterSeconds: Login(),

      image: Image(image: splashImage),
      photoSize: 100.0,
      
      title: Text("First Flutter",
                style: TextStyle(
                color: Colors.teal[700],
                fontSize: 25.0,
                fontWeight: FontWeight.w500,
                 
              ),

      ),

      loaderColor: Colors.teal,
     
  
    );

    
  
  }
}

