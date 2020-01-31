import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:jaguar_jwt/jaguar_jwt.dart';
import 'package:shared_preferences/shared_preferences.dart';

class FirstFlutterApi{
 
 final baseUrl = 'http://localhost:3000/';


  postRequest(data, apiRoot) async{
    var fullUrl = baseUrl + apiRoot + await getToken();

    return await http.post(
      fullUrl,
      headers: _setHeaders(),
      body: jsonEncode(data),
      

    );
  }

  getRequest(apiRoot) async{
    var fullUrl = baseUrl + apiRoot; //+ await getId();
    
    return await http.get(
      fullUrl,
      headers: _setHeaders(),
      


    );


  }

  
  _setHeaders() => {
    'Content-type' : 'application/json',
    'Accept' : 'application/json',
    
  };


  
   Future<bool> setToken(String token) async {
    SharedPreferences localStorage = await SharedPreferences.getInstance();
     return localStorage.setString('accessToken', token);
    
   } 


   Future<String> getToken() async {
    SharedPreferences localStorage = await SharedPreferences.getInstance();
    var token = localStorage.getString('accessToken');
    return '?token=$token';

   } 


   Future<bool> setId(String id) async {
    
      SharedPreferences localStorage = await SharedPreferences.getInstance();
      return localStorage.setString('sub', id);
    

   }


   Future<String> getId() async {
    
    SharedPreferences localStorage = await SharedPreferences.getInstance();
    var userId = localStorage.getString('sub');
    //return '?userId=$userId';
    return '$userId';

   }

  

   String decodeToken(String token) {

        final parts = token.split('.');
        final payLoad = parts[1];

        final String toDecode = B64urlEncRfc7515.decodeUtf8(payLoad);

        return toDecode;

   }







}