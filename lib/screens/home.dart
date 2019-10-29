import 'package:first_flutter/screens/posts.dart';
import 'package:first_flutter/screens/users.dart';
import 'package:first_flutter/screens/login.dart';
import 'package:flutter/material.dart';


class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  @override
  Widget build(BuildContext context) {
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

    );
  }
}