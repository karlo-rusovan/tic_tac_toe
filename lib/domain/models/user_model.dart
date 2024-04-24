import 'package:equatable/equatable.dart';

class UserModel extends Equatable {
  final int? id;
  final String? userName;
  final int? gameCount;
  final double? winRate;

  const UserModel(
      {
        this.id,
        this.userName,
        this.gameCount,
        this.winRate
  });

  static UserModel fromJson(Map<String, dynamic> json) { 
    return  UserModel(
      id : json['id'],
      userName : json['username'],
      gameCount : json['game_count'],
      winRate : json['win_rate']
    );
  }

  Map<String, dynamic> toJson() => {
        
  };

  @override
  List<Object?> get props => [id, userName, gameCount, winRate];
}
