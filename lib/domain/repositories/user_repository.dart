import 'package:http/http.dart' as http;
import 'dart:convert' as convert;
import '../models/user_model.dart';

class UserRepository {
  Future<List<UserModel>?> getPlayers({String? token, int limit = 10, int offset = 0}) async {   
     
    var url = Uri.https('tictactoe.aboutdream.io', '/users/', {'limit': '$limit', 'offset': '$offset'});      
    var response = await http.get(url, headers: <String, String>{
      'Authorization': 'Bearer $token',
    });   

    if(response.statusCode == 200){
      Map<String ,dynamic> jsonResponse = convert.jsonDecode(response.body);
      List<UserModel> userModels = (jsonResponse['results'] as List<dynamic>)
      .map((item) => UserModel.fromJson(item))
      .toList();
      return userModels;
    } else{
      throw Exception;
    }    
  }
}