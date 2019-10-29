import 'package:first_flutter/models/address.dart';
import 'package:first_flutter/models/user.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:async';
import 'dart:convert';


class UserDetails extends StatelessWidget {

  final User user;
  UserDetails(this.user);


  @override
  Widget build(BuildContext context) {

        return Scaffold(
          appBar: AppBar(
            title: Text(user.name),
            
          ),
    
          body: 
              Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  
                  Text(user.id.toString()),
                  Text(user.username),
                  Text(user.email),
                  Text(user.phone),
                  Text(user.website),

                  Text(user.street + ", " + user.suite + ", " + user.city + ", " + user.zipcode),

            ],
          )
      
         
        
      
    



    );
      

  }
}

