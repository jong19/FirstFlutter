import 'dart:ui';

import 'package:first_flutter/api/api.dart';
import 'package:first_flutter/models/address.dart';
import 'package:first_flutter/models/comment.dart';
import 'package:first_flutter/models/post.dart';
import 'package:first_flutter/models/user.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:async';
import 'dart:convert';


/*

Issue 1 : responsebody prints but the length variable is not found.
Solution : in list initialization, the list is set to list<Comment>

Issue 2 : After loading, no cotent is being displayed
Solution : set Listview.builder shrinkWrap = true AND scrollableDirction = Axis.vertical

*/


class PostDetails extends StatelessWidget {

  final Post post;
  PostDetails(this.post);


  Comment comm;
  var commentBody;
  var postId, id, name, email, body;
  List<Comment> listComments = [];

  Future <List<Comment>> getComments() async{

    postId = post.id;
  
   // get postId
    http.Response responseComments = await FirstFlutterApi().getRequest('comments?postId=$postId');
    //print(responseComments.body);

     print('THIS IS POST $postId');

    if (responseComments.statusCode == 200)  {

      commentBody = json.decode(responseComments.body);

      for(var cb in commentBody){
        postId = cb['postId'];
        id = cb['id'];
        name = cb['name'];
        email = cb['email'];
        body = cb['body'];

        comm = Comment(postId, id, name, email, body);

        listComments.add(comm);

      }
 
    }
    else{
      throw Exception();
    }


     return listComments;
    
 
  }


  @override
  Widget build(BuildContext context) {

    //Image blogImage = Image.network("https://via.placeholder.com/150/8985dc");
    AssetImage blogImage = AssetImage("images/first_flutter.png");
     var now = new DateTime.now();
      var year = now.year;
      var month = now.month;
      var day = now.day;

        return Scaffold(
          resizeToAvoidBottomPadding: false,
          appBar: AppBar(
            title: Text(post.title),
            
          ),
    
          body: Container(

            child: Column(

                 children: <Widget>[

                          Container(
                            child : Image.network("https://via.placeholder.com/150/8985dc", 
                            width: 500,
                            height: 200,
                             
                           
                          ),

                          ),
            
                         
                          
                       
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            
                            children: <Widget>[
                                
                                Row(

                                  children: <Widget>[
                                    Icon(Icons.person, color: Colors.teal,),
                                    SizedBox(width: 20,),
                                    Text("User ${post.userId}"),
                                 

                                  ],
                                ),

                                Row(
                                  children: <Widget>[
                                    Icon(Icons.calendar_today, color: Colors.teal, ),
                                     SizedBox(width: 20,),
                                    Text( year.toString() + "-" + month.toString() + "-" + day.toString() )

                                  ],
                                )

                             
                         
                            ],
                            
                       

                          ),

                          SizedBox(height: 20,),

                       

                          Column(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            
                            children: <Widget>[
                              Text(post.title, style: TextStyle(fontWeight: FontWeight.bold )),

                              SizedBox(height: 20,),

                              Container(
                       
                                child : Text(post.body),
                                width: 500,
                                margin: EdgeInsets.fromLTRB(10, 10, 10, 0)

                              ),

                            ],
                          ),

                          Divider(color: Colors.teal, thickness: 2, height: 30,),


                          Column( 
                           
                           children: <Widget>[

                      
                               FutureBuilder(
                                      future: getComments(),
                                      builder: (BuildContext context, AsyncSnapshot snapshot){
                                      
                                        if (snapshot.connectionState == ConnectionState.done){

                                            return ListView.builder(
                                                
                                                scrollDirection: Axis.vertical, 
                                                shrinkWrap: true,                                              
                                                itemCount: snapshot.data.length,
                                                itemBuilder: (BuildContext context, int index ){
                                              

                                              return  Container(
                                              
                                                child :
                                                  
                                                      ListTile(     
                                                       // isThreeLine: true,    
                                                        dense: true,                             
                                                        title: Text(snapshot.data[index].name),
                                                        subtitle: Text(snapshot.data[index].body),
                                                    ),

                                                ); 

                                     
                                            }
                                          );   
                                        }
                                        else{
                                            return Container(
                                              child: Center(
                                                child: CircularProgressIndicator(),
                                              // child : Text(snapshot.toString()),
                                              ),
                                            ); 
                                          
                                        
                                        }
                                    }
                                  
                                



                                  ),

                             
                                    
                                    
                                  
                                  
                                    

                                   

                                
                            
                                 
                           ],
                            

                          ),
                          
                     

                     
                           
                          


                          
                         

                          


                          

                       

                         





                          


                  
                    ],
              
            ),

          )
            
         
                  
            
          




             
                

              
            
      
         
        
      
    



    );
      

  }
}

