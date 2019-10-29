import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

class FirstFlutterApi{
 
 final String _baseUrl = 'http://localhost:3000/';
 // final String _baseUrl = 'http://10.0.2.2:3000/';
 // final String _baseUrl = 'http://127.0.0.1:3000/';
 //final String _baseUrl = 'http://170.168.38.52:3000/';
 //final String _baseUrl = 'https://gorest.co.in/public-api/';


  postRequest(data, apiRoot) async{
    var fullUrl = _baseUrl + apiRoot + await _getToken();

    return await http.post(
      fullUrl,
      body: jsonEncode(data),
      headers: _setHeaders()

    );
  }

  getRequest(data, apiRoot) async{
    var fullUrl = _baseUrl + apiRoot + await _getToken();
    return await http.get(
      fullUrl,
      headers: _setHeaders()

    );
  }


  _setHeaders() => {
    'Content-type' : 'application/json',
    'Accept' : 'application/json',
  };

  _getToken() async {
    SharedPreferences localStorage = await SharedPreferences.getInstance();
    var token = localStorage.getString('token');
    return '?token=$token';

  }







}