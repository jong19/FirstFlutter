
import 'dart:core';
import 'dart:io';

import 'package:first_flutter/models/address.dart';
import 'package:first_flutter/models/user.dart';
import 'package:first_flutter/screens/userDetails.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:async';
import 'dart:convert';



class Users extends StatefulWidget {


  @override
  _UsersState createState() => _UsersState();
}


class _UsersState extends State<Users> {
  
  Address address;
  var jsonUsers;
  var street, suite, city, zipcode;
  User user;
  List<User> listUsers = [];

  
  Future<List<User>> getUsers() async {

  // http.Response dataUsers = await http.get("https://jsonplaceholder.typicode.com/users");
  http.Response dataUsers = await http.get("http://localhost:3000/users");
  

    //print(dataUsers.statusCode);
    //print(dataUsers.body); 
   
    if (dataUsers.statusCode == 200) {
      jsonUsers = json.decode(dataUsers.body);
      

    //print(dataUsers.statusCode);
   // print(jsonUsers);
   // print( dataUsers.headers.toString());
    }
    
    for(var ju in jsonUsers){

      street = ju["address"]["street"];
      suite = ju["address"]["suite"];
      city = ju["address"]["city"];
      zipcode = ju["address"]["zipcode"];
     // print("$street, $suite, $city, $zipcode");

  
     user = User(ju["id"], ju["name"], ju["username"], ju["email"], 
            street, suite, city, zipcode,
            ju["phone"],ju["website"]);
    
     
     listUsers.add(user);

    }

    

    return listUsers;

  }

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: AppBar(
        title: Text("All Users"),
      ),
      body: Container(
        child: FutureBuilder(
          future: getUsers(),
          builder: (BuildContext context, AsyncSnapshot snapshot){

            
            if (snapshot.data == null){
                return Container(
                  child: Center(
                    child: CircularProgressIndicator(),
                  ),
                );    
            }
            

            else {
              return ListView.builder(
                itemCount: snapshot.data.length,
                itemBuilder: (BuildContext context, int index ){
                    return ListTile(
                    // trailing: snapshot.data[index].avatar,
                      title: Text(snapshot.data[index].name),
                      subtitle: Text(snapshot.data[index].email),
                      onTap: (){
                        return Navigator.push(context, MaterialPageRoute(builder: (context){
                          return UserDetails(snapshot.data[index]);

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