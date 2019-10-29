import 'package:first_flutter/models/address.dart';
import 'package:first_flutter/models/post.dart';
import 'package:first_flutter/models/user.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:async';
import 'dart:convert';


class PostDetails extends StatelessWidget {

  final Post post;
  PostDetails(this.post);


  @override
  Widget build(BuildContext context) {

        return Scaffold(
          appBar: AppBar(
            title: Text(post.title),
            
          ),
    
          body: 
              Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  
                   Text("Post ID : ${post.id}"),
                   Text(post.title, style: TextStyle(fontWeight: FontWeight.bold),),
                   Text(post.body),
                   Text("Author : User ${post.userId}"),
                   

                

                 

            ],
          )
      
         
        
      
    



    );
      

  }
}

