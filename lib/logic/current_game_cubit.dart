import 'package:equatable/equatable.dart';
import 'package:flutter_application_1/constants/game_status.dart';
import 'package:flutter_application_1/logic/authentication_cubit.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../domain/repositories/games_repository.dart';
import '../domain/models/data_errors.dart';
import '../domain/models/game_model.dart';

part 'current_game_state.dart';

class CurrentGameCubit extends Cubit<CurrentGameState> {
  final GamesRepository gamesRepository;
  final AuthenticationCubit authenticationCubit;
  CurrentGameCubit(this.gamesRepository, this.authenticationCubit) : super(const CurrentGameState());   

  Future<void> refreshGame({int? gameId}) async{
    while(state.shouldRefresh != null && state.shouldRefresh == gameId){
      if(state.gameModel == null){
      await fetchGame(gameId: gameId, loading: true);
      } else {
      await fetchGame(gameId: gameId, loading: false);
      }    
      await Future.delayed(const Duration(seconds: 2));   
    }    
  }

  void startRefresh({int? gameId}){
    emit(CurrentGameState(shouldRefresh: gameId));
  }

  void stopRefresh({int? gameId}){
    emit(const CurrentGameState(shouldRefresh: null, loading: true));
  }
    
  Future<void> fetchGame({int? gameId, bool loading = true}) async{
    try{
      if(loading){
        emit(CurrentGameState(error: null, loading: true, gameModel: state.gameModel, shouldRefresh: state.shouldRefresh));
      } else {
         emit(CurrentGameState(error: null, loading: false, gameModel: state.gameModel, shouldRefresh: state.shouldRefresh));}
      
      GameModel game = await gamesRepository.fetchGame(token: authenticationCubit.state.token,gameId: gameId);  
           
      if(game.status == GameStatus.inProgress){
        int firstPlayerMoves = 0;
        int secondPlayerMoves = 0;
        for(List<dynamic> row in game.boardState!){
          for(dynamic cell in row){
            if(cell == game.firstPlayerId){
              firstPlayerMoves += 1;
            } else if (cell == game.secondPlayerId){
              secondPlayerMoves += 1;
            }
          }
        }
        if(firstPlayerMoves == secondPlayerMoves){
          game.turn = 1;
        } else {
          game.turn = 2;
        }
      } else {
        game.turn = 0;
      }               
      emit(CurrentGameState(error: null, loading: false, gameModel: game, shouldRefresh: state.shouldRefresh)); 

    } on Exception {
      emit(CurrentGameState(error: GamesFetchError(), shouldRefresh: state.shouldRefresh));
    }
  }

  Future<void> move({int? row, int? col, int? gameId}) async{
    try{
      emit(CurrentGameState(error: null, loading: true, shouldRefresh: state.shouldRefresh));
      await gamesRepository.move(token: authenticationCubit.state.token, row: row, col: col, gameId: gameId);
      await fetchGame(gameId: gameId, loading: true);
    }on Exception{
      emit(CurrentGameState(error: GameMoveError(), shouldRefresh: state.shouldRefresh));
    }
  }

  Future<void> joinGame(int? gameId) async{
    try{
      emit(CurrentGameState(error: null, loading: true, shouldRefresh: state.shouldRefresh));
      await gamesRepository.joinGame(token: authenticationCubit.state.token, gameId: gameId);
      await fetchGame(gameId: gameId, loading: true);
    }      
    on Exception {
      emit(CurrentGameState(error: GameJoinError(), shouldRefresh: state.shouldRefresh));
    }
  }
}
