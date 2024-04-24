import 'package:equatable/equatable.dart';
import 'package:flutter_application_1/domain/models/game_model.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../domain/repositories/games_repository.dart';
import '../domain/models/data_errors.dart';
import 'authentication_cubit.dart';
import '../constants/game_status.dart';

part 'games_state.dart';

class GamesCubit extends Cubit<GamesState> {
  final AuthenticationCubit authenticationCubit;
  final GamesRepository gamesRepository;
  GamesCubit(this.gamesRepository, this.authenticationCubit) : super(const GamesState());

  Future<void> reloadGames() async {
    emit(state.copyWith(offsetAll: 0, offsetOpened: 0, offsetFinished: 0, offsetProgress: 0,allGames: [], finishedGames: [], openGames: [], progressGames: [], showGames: []));
    if(state.showAll){
       getGames();
    } else {
       getGames(status: state.currentStatus);
    }   
  }

  Future<void> createGame() async {
    try{
      await gamesRepository.createGame(token : authenticationCubit.state.token);
      reloadGames();
    } on Exception {
      emit(state.copyWith(error: () => GameCreateError()));
    }
  }

  Future<void> filterGames({GameStatus? status, bool loadMore = false}) async{   
    if(loadMore == true){
      if(state.showAll){
          await getGames(); 
      } else {
          await getGames(status: state.currentStatus); 
      }      
    } else {
      if(status == null){
        emit(state.copyWith(currentStatus: status, showAll: true));
        await getGames(status: status);   
      } else {
        emit(state.copyWith(currentStatus: status, showAll: false));
        await getGames(status: status);   
      }     
    }   
  }

  Future<void> getGames({GameStatus? status}) async{      
    emit(state.copyWith(error: () => null, loading: true));
    try {
      List<GameModel>? response;
      if (status == null){
             response = await gamesRepository.getGames(token: authenticationCubit.state.token, limit: state.limit, offset: state.offsetAll, status: status);
          } else if(status == GameStatus.finished){
            response = await gamesRepository.getGames(token: authenticationCubit.state.token, limit: state.limit, offset: state.offsetFinished, status: status);
          } else if (status == GameStatus.open){
            response = await gamesRepository.getGames(token: authenticationCubit.state.token, limit: state.limit, offset: state.offsetOpened, status: status);
          } else {
            response = await gamesRepository.getGames(token: authenticationCubit.state.token, limit: state.limit, offset: state.offsetProgress, status: status);
          }     

      if (response != null){      
        if(response.isNotEmpty) {

          List<GameModel> games;   
          if (status == null){
            if (state.allGames != null){
              games = List.of(state.allGames!);
              games.addAll(response);
            } else {
              games = response;
            }         
            emit(state.copyWith(showGames: games, allGames: games, loading:false, offsetAll: state.offsetAll + response.length, hasMoreGamesAll: true));
          } else if(status == GameStatus.finished){
            if (state.finishedGames != null){
              games = List.of(state.finishedGames!);
              games.addAll(response);
            } else {
              games = response;
            }         
            emit(state.copyWith(showGames: games, finishedGames: games, loading:false, offsetFinished: state.offsetFinished + response.length, hasMoreGamesFinished: true));           
          } else if (status == GameStatus.open){
            if (state.openGames != null){
              games = List.of(state.openGames!);
              games.addAll(response);
            } else {
              games = response;
            }         
            emit(state.copyWith(showGames: games, openGames: games, loading:false, offsetOpened: state.offsetOpened + response.length, hasMoreGamesOpened: true));            
          } else {
            if (state.progressGames != null){
              games = List.of(state.progressGames!);
              games.addAll(response);
            } else {
              games = response;
            }         
            emit(state.copyWith(showGames: games, progressGames: games, loading:false, offsetProgress: state.offsetProgress + response.length, hasMoreGamesAll: true));            
          }   
                  
        } else {    
          if (status == null){
             emit(state.copyWith(hasMoreGamesAll: false,  showGames: state.allGames, loading: false));
          } else if(status == GameStatus.finished){
            emit(state.copyWith(hasMoreGamesFinished: false,  showGames: state.finishedGames, loading: false));
          } else if (status == GameStatus.open){
            emit(state.copyWith(hasMoreGamesOpened: false,  showGames: state.openGames, loading: false));
          } else {
            emit(state.copyWith(hasMoreGamesProgress: false, showGames: state.progressGames, loading: false));
          }
         
        }       
      } else {
        emit(state.copyWith(allGames: null, error: () => GamesFetchError(), loading:false));        
      }   
     
    }      
    on Exception{
      emit(state.copyWith(allGames: null, error: () => GamesFetchError(), loading:false));  
    }   
  }
}
