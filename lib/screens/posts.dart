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

   var uid, utoken;

   List<Post> listPosts = [];
   Post post;
   User user;




  Future<List<Post>> getPosts()  async  {

   uid = await FirstFlutterApi().getId();
   utoken = await FirstFlutterApi().getToken();

    //http.Response responsePosts = await FirstFlutterApi().getRequest('posts');
    print("USER ID FROM POSTS $uid");
    http.Response responsePosts = await FirstFlutterApi().getRequest('posts?userId=$uid');

    if (responsePosts.statusCode == 200) {
     
        postsBody = json.decode(responsePosts.body);

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
      Image blogImage = Image.network("https://via.placeholder.com/150/8985dc");
      var now = new DateTime.now();
      var year = now.year;
      var month = now.month;
      var day = now.day;

      
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
                    return Card(
                      margin: EdgeInsets.fromLTRB(5.0, 5.0, 5.0, 5.0),
                      elevation: 5.0,
                      
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: <Widget>[
                             ListTile(
                                   
                                    trailing: blogImage,
                                    title: Text(snapshot.data[index].title),
                                    subtitle: Row(
                                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                      
                                  
                                      children: <Widget>[

                                        Text("by: user ${snapshot.data[index].userId} "),
                                        Text("published : " + year.toString() + "-" + month.toString() + "-" + day.toString() )
                                      ],
                                    ),
                             
                                  //title: Text(snapshot.data[index].userId.toString()),
                                // subtitle: Text(utoken),
                                  onTap: (){
                                    
                                    return Navigator.push(context, MaterialPageRoute(builder: (context){
                                     // print('POSTS SNAPSHOT DATA ' + snapshot.data[index].id.toString());
                                      return PostDetails(snapshot.data[index]);
                                      //return PostDetails(snapshot.data[index].id.toString());

                                    }));
                                    

                                  },



                               ),
                              /*
                               Image(
                                 image: splashImage,
                               )
                               */

                              

                              

                        ],
                      ),
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