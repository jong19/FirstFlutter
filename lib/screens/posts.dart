import 'dart:convert';

import 'package:first_flutter/api/api.dart';
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
   
   var postsBody;
   var postsAllBody;
   var userId, postId, postTitle, postBody;

   List<Post> listPosts = [];
   Post post;
   User user;


  Future<List<Post>> getPosts()  async  {

    var uid = await FirstFlutterApi().getId();

    // var data = {
    //   'userId' : userId,
    //   'id' : postId,
    //   'title' : postTitle,
    //   'body' : postBody
    // };

    print(uid);

 
    http.Response responsePosts = await FirstFlutterApi().getRequest('posts');

    print(uid);

    if (responsePosts.statusCode == 200) {
     
        postsBody = json.decode(responsePosts.body);

       // print('POSTS BODY $postsBody');

          for(var pb in postsBody){
              userId = pb["userId"];
              postId = pb["id"];
              postTitle = pb["title"];
              postBody = pb["body"];
            
              post = Post(userId, postId, postTitle, postBody);
              listPosts.add(post);

        }
        
    }
    else{
      print(throw new Exception());
    }

    return listPosts;

  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Posts"),
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
                     // trailing: Text(snapshot.data.length.toString()),
                      title: Text(snapshot.data[index].id.toString() + ' ' + snapshot.data[index].title),
                      subtitle: Text(snapshot.data[index].userId.toString()),
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