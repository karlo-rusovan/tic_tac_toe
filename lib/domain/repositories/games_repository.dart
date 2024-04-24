import 'package:flutter_application_1/constants/game_status.dart';
import 'package:http/http.dart' as http;
import 'dart:convert' as convert;
import '../models/game_model.dart';

class GamesRepository {
  Future<List<GameModel>?> getGames({String? token, int limit = 10, int offset = 0, GameStatus? status}) async {
    Uri url = Uri.https('');
    if (status == null) {
      url = Uri.https('tictactoe.aboutdream.io', '/games/', {'limit': '$limit', 'offset': '$offset'});
    } else if (status == GameStatus.finished) {
      url = Uri.https('tictactoe.aboutdream.io', '/games/', {'limit': '$limit', 'offset': '$offset', 'status': 'finished'});
    } else if (status == GameStatus.inProgress) {
      url = Uri.https('tictactoe.aboutdream.io', '/games/', {'limit': '$limit', 'offset': '$offset', 'status': 'progress'});
    } else {
      url = Uri.https('tictactoe.aboutdream.io', '/games/', {'limit': '$limit', 'offset': '$offset', 'status': 'open'});
    }
    var response = await http.get(url, headers: <String, String>{
      'Authorization': 'Bearer $token',
    });

    if (response.statusCode == 200) {
      Map<String, dynamic> jsonResponse = convert.jsonDecode(response.body);
      List<GameModel> gameModels = (jsonResponse['results'] as List<dynamic>).map((item) => GameModel.fromJson(item)).toList();
      return gameModels;
    } else {
      return null;
    }
  }

  Future<void> createGame({String? token}) async {
    var url = Uri.https('tictactoe.aboutdream.io', '/games/');
    var response = await http.post(url, headers: <String, String>{
      'Authorization': 'Bearer $token',
    });
    if (response.statusCode != 200) {
      throw Exception();
    }
  }

  Future<void> joinGame({String? token, int? gameId}) async {
    var url = Uri.https("tictactoe.aboutdream.io", "/games/${gameId!.toString()}/join/");
    var response = await http.post(url, headers: <String, String>{
      'Authorization': 'Bearer $token',
    });
    if (response.statusCode != 200) {
      throw Exception();
    }
  }

  Future<GameModel> fetchGame({String? token, int? gameId}) async{
    var url = Uri.https("tictactoe.aboutdream.io", "/games/${gameId!.toString()}/");
    var response = await http.get(url, headers: <String, String>{
        'Authorization': 'Bearer $token',
      }
    );
     if (response.statusCode != 200) {
      throw Exception();
    } else {
      return GameModel.fromJson(convert.jsonDecode(response.body));
    }
  }

  Future<void> move({String? token, int? row, int? col, int? gameId}) async {
    var url = Uri.https("tictactoe.aboutdream.io", "/games/${gameId!.toString()}/move/");
    var response = await http.post(url, headers: <String, String>{
        'Authorization': 'Bearer $token',
      },
      body: {
        'row': row!.toString(),
        'col': col!.toString(),
      },
    );
    if (response.statusCode != 200) {
      throw Exception();
    }
  }
}
