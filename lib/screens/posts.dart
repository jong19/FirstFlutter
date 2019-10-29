import 'dart:convert';

import 'package:first_flutter/models/post.dart';
import 'package:first_flutter/models/user.dart';
import 'package:first_flutter/screens/postDetails.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;


class Posts extends StatefulWidget {
  @override
  _PostsState createState() => _PostsState();
}



class _PostsState extends State<Posts> {
   
   var jsonPosts;
   var userId, postId, postTitle, postBody;
   List<Post> listPosts = [];
   Post post;
   User user;

  Future<List<Post>> getPosts()  async  {
    /*
    http.Response dataPosts = await http.get("https://jsonplaceholder.typicode.com/posts", 
    headers: {
      "Accept" : "application/json",
      "Content-Type" : "application/json"
    });
    */

    http.Response dataPosts = await http.get("http://localhost:3000/posts");

  
    
    if (dataPosts.statusCode == 200) {
           jsonPosts = json.decode(dataPosts.body);
    }

    for(var jp in jsonPosts){
       userId = jp["userId"];
       postId = jp["id"];
       postTitle = jp["title"];
       postBody = jp["body"];
      // print("$userId, $postId, $postTitle, $postBody");


        post = Post(userId, postId, postTitle, postBody);
       listPosts.add(post);

    }

    return listPosts;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("All Posts"),
      ),
      body: Container(
        child: FutureBuilder(
          future: getPosts(),
          builder: (BuildContext context, AsyncSnapshot snapshot){

            
            if (snapshot.data == null){
                return Container(
                  child: Center(
                    child: CircularProgressIndicator(),
                   // child : Text(snapshot.toString()),
                  ),
                );    
            }
            

            else {
              return ListView.builder(
                itemCount: snapshot.data.length,
                itemBuilder: (BuildContext context, int index ){
                    return ListTile(
                    // trailing: snapshot.data[index].avatar,
                      title: Text(snapshot.data[index].title),
                      subtitle: Text(snapshot.data[index].body),
                      onTap: (){
                        
                        return Navigator.push(context, MaterialPageRoute(builder: (context){
                          return PostDetails(snapshot.data[index]);

                        }));
                        

                      },


                    );
                  
                }
            

              );

          }




          },
        ),
      ),

    );
  }
}