
import 'package:first_flutter/api/api.dart';
import 'package:first_flutter/screens/home.dart';
import 'package:first_flutter/screens/register.dart';
import 'package:flutter/material.dart';
import 'package:first_flutter/models/user.dart';
import 'package:http/http.dart' as http;
import 'dart:async';
import 'dart:convert';

import 'package:shared_preferences/shared_preferences.dart';
import 'package:jaguar_jwt/jaguar_jwt.dart';



class Login extends StatefulWidget {
  @override
  _LoginState createState() => _LoginState();
}




class _LoginState extends State<Login> {

  final _formKey = GlobalKey<FormState>();
  AssetImage splashImage = AssetImage("images/first_flutter.png");
  bool _isHidden = true;

  TextEditingController emailController = new TextEditingController();
  TextEditingController passwordController = new TextEditingController();



  @override
  Widget build(BuildContext context) {

    return Scaffold(
      resizeToAvoidBottomPadding: false,
      body: Container(
        child: Builder(
            builder: (context) => Form(
            key : _formKey,
            child:    Column(
          children: <Widget>[

            // Logo and Title
            Container(
              padding: EdgeInsets.fromLTRB(0, 100.0, 0, 50.0),
              child: Column(

                  children: <Widget>[

                    Container(
                      child: Image(
                      image: splashImage,
                      width: 100.0,
                      height: 100.0
                    ),
                  
                  ),

                Container(
                  child: Text("Login",
                  style: TextStyle(
                        color: Colors.teal,
                        fontSize: 20.0,
                        fontWeight: FontWeight.w500   
                        ),
                  ),
                          
                ),

                ],

                ),

            ),
            

                //Login Form
              Container(
                padding: EdgeInsets.fromLTRB(20.0, 0.0, 20.0,0.0),
                child: Column(
                  children: <Widget>[
                      TextFormField(
                      decoration: InputDecoration(labelText: 'Username', ),
                      keyboardType: TextInputType.text,
                      validator: (value){
                                      if (value.isEmpty) {
                                        return "Username is required";
                                        
                                      }
                                    },
                      onSaved: (val) => setState(() => emailController.text = val),
                      
                      
                  
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
                              validator: (value){
                                      if (value.isEmpty) {
                                        return "Password is required";
                                        
                                      }
                                    },
                      onSaved: (val) => setState(() => passwordController.text = val),
                          
                          obscureText: _isHidden ? false : true,

                    
                                             
                                                                     
                    ),
                          
                    Container(
                      padding: EdgeInsets.only(top: 30.0),
                      child : MaterialButton( 
                                height: 40.0, 
                                minWidth: 150.0, 
                                color: Theme.of(context).primaryColor, 
                                textColor: Colors.white, 
                                child: new Text("Login"), 
                                      onPressed: ()  {
                                      
                                      
                                      final form = _formKey.currentState;

                                      if (form.validate()) {
                                       form.save();
                                      _loginUser();

               
                                      }
                                      
                                   
                                    },  
                                splashColor: Colors.purpleAccent,
                              ),
                                                 
                          
                                              ),
                          
                Container(
                  padding: EdgeInsets.only(top: 20.0),
                  child : MaterialButton( 
                            height: 40.0, 
                            minWidth: 150.0, 
                            color: Theme.of(context).primaryColor, 
                                textColor: Colors.white, 
                                    child: new Text("Sign Up Now"), 
                                    onPressed: () => {
                                              Navigator.push(context, MaterialPageRoute(builder: (context){
                                                  return Register();
                                              })),
                                    }, 
                                    splashColor: Colors.purpleAccent,
                          ),
                                                 
                          
                  ),
                          
                                             
                
                                            ],
                                          ),
                          
                                        ),
                          
                                      
                                     
                                      
                                    ],
                                  ), 

        )
        
        
     
                                ),
                                )
                          
                              ); 
                          
                               
                            }

      void _loginUser() async{

          var loginBody;

          var userToken;

          var decodedToken;

          var accessClaim;
      

         var decodedId, decodedEmail, decodedExpiry, decodedIat;
         

       
        var dataUser = {
          'userId' : '',
          'email' : emailController.text,
          'password' : passwordController.text
        };

      var loginResponse = await FirstFlutterApi().postRequest(dataUser, 'login');

      if (loginResponse.statusCode == 200) {

             loginBody = json.decode(loginResponse.body);
             userToken = loginBody['accessToken'];
            // await FirstFlutterApi().getToken();

             // sent the token to decodeToken method which decodes the token using JaguarJWT 
             decodedToken = FirstFlutterApi().decodeToken(userToken);
            
             // decoded so we can access specific claims in the list
             accessClaim = json.decode(decodedToken);

             print('USER TOKEN IN LOGIN ==> $userToken');
            // print('DECODED TOKEN ==> $decodedToken');
            // print('ACCESS CLAIM ==> $accessClaim');

            // 4 claims are being returned from the decoded token. 
             decodedId = accessClaim['sub'];
             decodedEmail = accessClaim['email'];
             decodedIat = accessClaim['iat'];
             decodedExpiry = accessClaim['exp'];

           //  print('$decodedId, $decodedEmail, $decodedIat, $decodedExpiry');

              await FirstFlutterApi().setToken(userToken);
              await FirstFlutterApi().setId(decodedId);
              print(await FirstFlutterApi().getId());

            
           Navigator.push(context, MaterialPageRoute(builder: (context){
                return Home();
           }));


           
           
        
      }

      else{
            
            return showDialog(

            context: context,
            barrierDismissible: false, // user must tap button!
            builder: (BuildContext context) {
              return AlertDialog(
                title: Text('Ooops...'),
                content: SingleChildScrollView(
                  child: ListBody(
                    children: <Widget>[
                      Text(loginResponse.body.toString()),
                      
                    ],
                  ),
                ),
                actions: <Widget>[
                  FlatButton(
                    child: Text('OK'),
                    onPressed: () {
                      Navigator.of(context).pop();
                            
                    },
                  ),
                ],
              );
            },
      );

      }


      }

      String decodeToken(String token){

        final parts = token.split('.');
        final payLoad = parts[1];

        final String decodedToken = B64urlEncRfc7515.decodeUtf8(payLoad);

       // print(decodedToken.runtimeType);

        return decodedToken;

 

      }

                          
      void _togglePasswordVisibility() {
                  setState(() {
                  _isHidden = !_isHidden;
                  });
     }
}