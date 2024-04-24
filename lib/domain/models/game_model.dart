import '../../constants/game_status.dart';

class GameModel {
  final int? id;
  final List<dynamic>? boardState;
  final int? winnerId;
  final String? winnerUsername;
  final GameStatus status;  
  final int? firstPlayerId;
  final String? firstPlayerUsername;
  final int? secondPlayerId;
  final String? secondPlayerUsername;
  final DateTime? created;
  int turn; //0 - nobodys, 1 - player1, 2- player2

  GameModel(
      {
        this.created,
        this.id,
        this.boardState,
        this.winnerId,
        this.status = GameStatus.open,
        this.winnerUsername,
        this.firstPlayerId,
        this.firstPlayerUsername,
        this.secondPlayerId,
        this.secondPlayerUsername,
        this.turn = 0
  });
 
  static GameModel fromJson(Map<String, dynamic> json) {
    int? winnerId;
    String winnerUsername = ""; 
    String secondPlayerUsername = "";
    int? secondPlayerId;

    if (json['winner'] != null){
        winnerId = json['winner']['id'];
        winnerUsername = json['winner']['username'];
    } 
    if (json['second_player'] != null){
        secondPlayerUsername = json['second_player']['username'];
        secondPlayerId = json['second_player']['id'];
    }  
 
    return  GameModel(
      id : json['id'],
      boardState : json['board'],
      winnerId : winnerId,
      winnerUsername : winnerUsername,
      firstPlayerId : json['first_player']['id'],
      secondPlayerId : secondPlayerId,
      firstPlayerUsername : json['first_player']['username'],
      secondPlayerUsername : secondPlayerUsername,
      status : GameStatusX.fromString(json['status']),
      created : DateTime.parse(json['created']),
      turn : 0,
    );
  }

  Map<String, dynamic> toJson() => {
        
  };

 
}
