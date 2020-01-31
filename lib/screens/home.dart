import 'package:first_flutter/screens/posts.dart';
import 'package:first_flutter/screens/users.dart';
import 'package:first_flutter/screens/login.dart';
import 'package:first_flutter/api/api.dart';
import 'package:flutter/material.dart';


class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {

  var id, token;
  var idTokenMap = Map();

  Future<Map<String, String>> getCurrentId() async {
      id = await FirstFlutterApi().getId();
      token = await FirstFlutterApi().getToken();

      idTokenMap['id'] = id;
      idTokenMap['token'] = token;

     // print(idTokenMap);

      return idTokenMap;
      

      
     
  }



  @override
  Widget build(BuildContext context) {

   id = FirstFlutterApi().getId().toString();
   token = FirstFlutterApi().getToken().toString();

    return Scaffold(
        appBar: AppBar(
          title: Text("Flutter"),
        ),
        
        drawer: Drawer(
          elevation: 12,


          child: ListView(
            children: <Widget>[
             
             UserAccountsDrawerHeader(
               currentAccountPicture: CircleAvatar(
                 backgroundColor: Colors.orange[300],
                 child: IconButton(
                   icon: Icon(Icons.person),
                   onPressed: (){
                     print("Avatar tapped");
                   },
                 ),

               ),
               accountName: Text("Ninz Flutter"),
               accountEmail: Text("ninz.lobert@flutter.com"),

               otherAccountsPictures: <Widget>[
                CircleAvatar(
                  backgroundColor: Colors.orange[300],
                  child: IconButton(
                   icon: Icon(Icons.mode_edit),
                   onPressed: (){
                     print("Edit tapped");
                   },
                 ),

               ),
               ],


             ),
              

            ListTile(
              title: Text("Users"),
              trailing: Icon(Icons.person),
              onTap: (){
                 Navigator.of(context).pop();
                 Navigator.push(context, MaterialPageRoute(builder: (context) {
                        return Users();
                  }));
               
                },
            ),

            ListTile(
              title: Text("Posts"),
              trailing: Icon(Icons.local_post_office),
              onTap: (){
                 Navigator.of(context).pop();
                 Navigator.push(context, MaterialPageRoute(builder: (context) {
                        return Posts();
                  }));
                

              },
            ),

            ListTile(
              title: Text("Albums"),
              trailing: Icon(Icons.photo_album),
              onTap: (){},
            ),

            ListTile(
              title: Text("Todos"),
              trailing: Icon(Icons.note),
              onTap: (){},
            ),

            Divider(),
               ListTile(
                  title: Text("Logout"),
                  trailing: Icon(Icons.arrow_downward),
                  onTap: (){
                     Navigator.push(context, MaterialPageRoute(builder: (context) {
                        return Login();
                     }));
                  },
                  
               )
            
          ],
        ),
      ),

      body: FutureBuilder(
        future: getCurrentId(),
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
                            title: Text(snapshot.data[index].id.toString()),
                            subtitle: Text(snapshot.data[index].token.toString()),
                            onTap: (){
                              
                

                            },



                          );

                      
                        
                      }
                  

                    );

          }

        }
      )
    );

   
   
      
    
  }
}