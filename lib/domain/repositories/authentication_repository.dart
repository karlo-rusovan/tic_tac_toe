import 'package:flutter_application_1/domain/models/auth_response.dart';
import 'package:http/http.dart' as http;
import 'dart:convert' as convert;

class AuthenticationRepository { 

  Future<AuthResponse> logIn({String? email, String? password}) async {
    AuthResponse authResponse;
    var url = Uri.https('tictactoe.aboutdream.io', '/login/');
    var response = await http.post(url, body : {'username' : email, 'password' : password}); 
    if (response.statusCode == 200){
      var jsonResponse = convert.jsonDecode(response.body) as Map<String, dynamic>;      
      authResponse =  AuthResponse(success: true, userId: jsonResponse['id'], token: jsonResponse['token'], username: jsonResponse['username']);
    } else if (response.statusCode == 401){
      authResponse = const AuthResponse(credentialError: true);
    } else {
       authResponse = const AuthResponse(loginError: true);
    }   
    return authResponse; 
  }

  Future<AuthResponse> signUp({String? email, String? password}) async {
    AuthResponse authResponse;
    var url = Uri.https('tictactoe.aboutdream.io', '/register/');
    var response = await http.post(url, body : {'username' : email, 'password' : password}); 
    if (response.statusCode == 200){
      authResponse = const AuthResponse(success: true);
    } else if (response.statusCode == 403){
      authResponse = const AuthResponse(emailInUse: true);
    } else {
       authResponse = const AuthResponse(registerError: true);
    }   
    return authResponse; 
  }

  Future<void> logOut({String? token}) async{
      var url = Uri.https('tictactoe.aboutdream.io', '/logout/');
      var response = await http.post(url, headers: <String, String>{
        'Authorization': 'Bearer $token',
      }); 
      if(response.statusCode != 200){
        throw Exception();
      }
  }
}

  













