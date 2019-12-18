import 'dart:convert';

import 'package:first_flutter/api/api.dart';
import 'package:first_flutter/models/user.dart';
import 'package:first_flutter/screens/home.dart';
import 'package:flutter/material.dart';
import 'package:first_flutter/screens/login.dart';
import 'package:flutter/material.dart' as prefix0;
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;
import 'dart:async';
import 'dart:convert';
import 'package:progress_dialog/progress_dialog.dart';


class Register extends StatefulWidget {
  @override
  _RegisterState createState() => _RegisterState();
}

class _RegisterState extends State<Register> {

  final _formKey = GlobalKey<FormState>();
  User _user;
  String email;
  var errMsg;

  bool _isHidden = false;
  bool _av = false;

  TextEditingController firstnameController = new TextEditingController();
  TextEditingController lastnameController = new TextEditingController();
  TextEditingController emailController = new TextEditingController();
  TextEditingController passwordController = new TextEditingController();
  TextEditingController phoneController = new TextEditingController();

 // bool _isLoading = false;



  var jsonUsers;
  
  void _togglePasswordVisibility() {
              setState(() {
                  _isHidden = !_isHidden;
              });
  }



  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomPadding: false,
      body: Container(
        child: Builder(
          builder: (context) => Form(
            key : _formKey ,
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
                        child: 

                        TextFormField(
                                    decoration: InputDecoration(labelText: 'Firstname', ),
                                    keyboardType: TextInputType.text,
                                    autovalidate: _av,
                                    validator: (value){
                                      if (value.isEmpty) {
                                        return "Firstname is required";
                                        
                                      }
                                    },
                                 onSaved: (val) => setState(() => firstnameController.text = val),


                              ),
                      ),

                       Expanded(
                        child: TextFormField(
                                    decoration: InputDecoration(labelText: 'Lastname', ),
                                    keyboardType: TextInputType.text,
                                    autovalidate: _av,
                                     validator: (value){
                                      if (value.isEmpty) {
                                        return 'Lastname is required';
                                      }
                                    },
                                 onSaved: (val) => setState(() => lastnameController.text = val),

                              ),
                      ),
                  
                    ],

                  ),
                  

                  
                     TextFormField(
                      decoration: InputDecoration(
                        labelText: 'Email', 
                     
                        ),
                      keyboardType: TextInputType.emailAddress,
                      autovalidate: _av,
                       validator: (value){
                                      if (value.isEmpty) {
                                        return 'Email is required';
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
                        obscureText: _isHidden ? false : true,
                       autovalidate: _av,

                         validator: (value){
                                      if (value.isEmpty) {
                                        return 'Password is required';
                                     
                                      }
                                    },

                                  onSaved: (val) => setState(() => passwordController.text = val),

                    
                                             
                                                                     
                    ),


                     TextFormField(
                      decoration: InputDecoration(
                        labelText: 'Phone', 
                     
                        ),
                      keyboardType: TextInputType.phone,
                      autovalidate: _av,
                       validator: (value){
                                      if (value.isEmpty) {
                                        return 'Phone is required';
                                      }

                                      
                                    },
                                  onSaved: (val) => setState(() => phoneController.text = val),
                      
          
                   ),

                 
                      Container(
                      padding: EdgeInsets.only(top: 30.0),
                      child :MaterialButton( 
                            height: 40.0, 
                            minWidth: 150.0, 
                            color: Theme.of(context).primaryColor, 
                                    textColor: Colors.white, 
                                    child: new Text("Create Account"), 

                                    onPressed: ()  {

                                     

                                       
                                       
                                       

                                       /*
                                         final snackBar = SnackBar(
                                          content: Text(errMsg),
                                          action: SnackBarAction(
                                            label: 'OK',
                                            onPressed: () {
                                              //Navigator.of(context).pop();
                                              
                                          
                                            },
                                          ),
                                        );

                                      
                                        Scaffold.of(context).showSnackBar(snackBar);

                                        */

                                        

                                      
                                      final form = _formKey.currentState;

                                      if (form.validate()) {

                                      /*
                                       ProgressDialog pd = ProgressDialog(context, type: ProgressDialogType.Normal);
                                       pd.style(message: 'Saving user...');
                                       pd.show();
                                       

              
                                       Future.delayed(Duration(seconds: 3)).then((onValue){
                                         if (pd.isShowing()) {
                                           pd.hide();
                                           
                                         }
                                        

                                       });
                                       */
                                        form.save();
                                        _saveUser();
                            
                                      }
                                      else{
                                        setState(() {
                                          _av = true;
                                        });
                                      }
                                    


                                    }, 
                                    splashColor: Colors.purpleAccent,
                          ),
                       

                    ),




                ],

              ),
            ),

              


          ],
        )
        ,),
        ),
        
        
        
        
        
        
        
       

      ),

    );
      
    
  
  }

  Future<String> _saveUser() async {

    var registerBody;
    var userToken;
  
  
    var dataUser = {

        'id' : '',
        'firstname' : firstnameController.text,
        'lastname' :  lastnameController.text,
        'email' :     emailController.text,
        'password' : passwordController.text,
        'address' : {
          'street' : '', 
          'suite' : '', 
          'city' : '', 
          'zipcode' : ' ', 

            'geo' : {
              'lat' : '', 'lng' : ''
            }
          
        },
        
        'phone' :   phoneController.text,
        'website' : '',
        'company' : {
            'name' : '',
            'catchPhrase' : '',
            'bs' : ''

        }
        
    };


    var registerResponse = await FirstFlutterApi().postRequest(dataUser, 'register');
    


    if (registerResponse.statusCode == 201 )  {

          registerBody = json.decode(registerResponse.body);
     

        
          print('REGISTER BODY ${registerBody['accessToken']}');

        
          if (registerBody != null)  {

            userToken = registerBody['accessToken'];

            await FirstFlutterApi().setToken(userToken);
            print(await FirstFlutterApi().getToken());

                
           Navigator.push(context, MaterialPageRoute(builder: (context){
                return Login();
           }));

            
          }
          else{
            throw Exception("ResponseBody is null");
          }


    }
    else{
      errMsg = registerResponse.body.toString();

        
        return showDialog(

        
            context: context,
            barrierDismissible: false, // user must tap button!
            builder: (BuildContext context) {
              return AlertDialog(
                title: Text('Ooops...'),
                content: SingleChildScrollView(
                  child: ListBody(
                    children: <Widget>[
                      Text(errMsg),
                      
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

    print('USER TOKEN => $userToken');

    return await Future.value('RETURNED SAVEUSER() WITH API CLASS $userToken');
    //return await Future.value(errMsg);

  }

  









 

 



}
  
  