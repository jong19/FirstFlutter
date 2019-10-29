import 'dart:convert';

import 'package:first_flutter/api/api.dart';
import 'package:first_flutter/screens/home.dart';
import 'package:flutter/material.dart';
import 'package:first_flutter/screens/login.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Register extends StatefulWidget {
  @override
  _RegisterState createState() => _RegisterState();
}

class _RegisterState extends State<Register> {

  bool _isHidden = false;
  

  void _togglePasswordVisibility() {
              setState(() {
                  _isHidden = !_isHidden;
              });
  }

  TextEditingController firstnameController = TextEditingController();
  TextEditingController lastnameController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController phoneController = TextEditingController();

  bool _isLoading = false;


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomPadding: false,
      body: Container(
        child: Column(
          children: <Widget>[
            
            // Create Account Title
            Container(
                padding: EdgeInsets.fromLTRB(20.0, 100.0, 0, 50.0),
                child: 
                  Text("Create An Account",
                      style: TextStyle(
                      color: Colors.teal,
                      fontSize: 20.0,
                      fontWeight: FontWeight.w500
                    ),

                  )
              ),
            
            // Registration Form
            Container(
              padding: EdgeInsets.fromLTRB(20.0, 40.0, 20.0,0.0),
              child: Column(
                children: <Widget>[
                  Row(
                    children: <Widget>[
                      Expanded(
                        child: TextFormField(
                                    decoration: InputDecoration(labelText: 'Firstname', ),
                                    keyboardType: TextInputType.emailAddress,

                              ),
                      ),

                       Expanded(
                        child: TextFormField(
                                    decoration: InputDecoration(labelText: 'Lastname', ),
                                    keyboardType: TextInputType.emailAddress,

                              ),
                      ),
                  
                    ],

                  ),

                   TextFormField(
                      decoration: InputDecoration(
                        labelText: 'Email', 
                     
                        ),
                      keyboardType: TextInputType.emailAddress,
          
                   ),

          
                    TextFormField(
                        keyboardType: TextInputType.visiblePassword,
                        decoration: InputDecoration(
                            labelText: 'Password',
                            suffixIcon: IconButton(
                                onPressed: _togglePasswordVisibility,
                                icon: _isHidden ? Icon(Icons.visibility_off) : Icon(Icons.visibility),
                                ),             
                        ),
                        obscureText: _isHidden ? false : true,

                    
                                             
                                                                     
                    ),

                    TextFormField(
                      decoration: InputDecoration(
                        labelText: 'Phone', 
                     
                        ),
                      keyboardType: TextInputType.phone
          
                   ),


                      Container(
                      padding: EdgeInsets.only(top: 30.0),
                      child : MaterialButton( 
                              height: 40.0, 
                              minWidth: 150.0, 
                              color: Theme.of(context).primaryColor, 
                              textColor: Colors.white, 
                              child: Text(_isLoading ? 'Saving...' : 'Register'),
                              onPressed: _isLoading ? null : _saveUser,
                                /*
                                Navigator.push(context, MaterialPageRoute(builder: (context){
                                    return Register();
                                })),
                                */


                              
                              splashColor: Colors.purpleAccent,
                            ),
                       

                    ),




                ],

              ),
            ),

              


          ],
        ),

      ),

    );
      
    
  
  }

  void _saveUser() async {
    

    setState(() {

       _isLoading = true; 

    });



    var dataUser = {

        'firstName' : firstnameController.text,
        'lastName' :  lastnameController.text,
        'email' : emailController.text,
        'password' : passwordController.text,
        'phone' : phoneController.text,

    };

    var response = await FirstFlutterApi().postRequest(dataUser, 'users');
    var body =  json.decode(response.body);

    if (body['success']) {
      SharedPreferences localStorage = await SharedPreferences.getInstance();
      var token = localStorage.setString('token', body['token']);
      var user = localStorage.setString('user', body['user']);

      localStorage.setString('token', body['token']);
      localStorage.setString('user', body['user']);

      print("TOKEN ===> $token");
      print("USER ===> $user");

       Navigator.push(context, MaterialPageRoute(builder: (context){
                                    return Home();
                                }));


    }

    
    setState(() {

       _isLoading = false; 

    });








  }

 

  }
  
  