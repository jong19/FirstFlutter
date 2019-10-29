import 'package:first_flutter/screens/home.dart';
import 'package:first_flutter/screens/register.dart';
import 'package:flutter/material.dart';
import 'package:first_flutter/models/user.dart';



class Login extends StatefulWidget {
  @override
  _LoginState createState() => _LoginState();
}




class _LoginState extends State<Login> {

  final _formKey = GlobalKey<FormState>();
  AssetImage splashImage = AssetImage("images/first_flutter.png");
  bool _isHidden = true;



  @override
  Widget build(BuildContext context) {

    return Scaffold(
      resizeToAvoidBottomPadding: false,
      body: Container(
        child: Column(
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
                      decoration: InputDecoration(labelText: 'Email', ),
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
                          
                    Container(
                      padding: EdgeInsets.only(top: 30.0),
                      child : MaterialButton( 
                                height: 40.0, 
                                minWidth: 150.0, 
                                color: Theme.of(context).primaryColor, 
                                textColor: Colors.white, 
                                child: new Text("Login"), 
                                onPressed: () => {
                                  Navigator.push(context, MaterialPageRoute(builder: (context) {
                                      return Home();
                                  })),
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
                                ),
                          
                              );
                          
                               
                            }
                          
                            void _togglePasswordVisibility() {
                                setState(() {
                                   _isHidden = !_isHidden;
                                });
                            }
}