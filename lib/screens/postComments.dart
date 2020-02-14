
import 'package:first_flutter/models/comment.dart';
import 'package:first_flutter/screens/postDetails.dart';
import 'package:flutter/material.dart';

class PostComments extends StatelessWidget {

  final Comment comm;
  PostComments(this.comm);


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView(
        children: <Widget>[
         
        ],
      ),

    );
  }
}