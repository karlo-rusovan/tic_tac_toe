part of 'games_cubit.dart';

class GamesState extends Equatable {
  final List<GameModel>? allGames;
  final List<GameModel>? showGames;
  final List<GameModel>? openGames;
  final List<GameModel>? finishedGames;
  final List<GameModel>? progressGames;
  final DataError? error;
  final bool loading;
  final int limit;
  final int offsetAll; 
  final int offsetFinished; 
  final int offsetOpened; 
  final int offsetProgress; 
  final bool hasMoreGamesAll;
  final bool hasMoreGamesOpened;
  final bool hasMoreGamesProgress;
  final bool hasMoreGamesFinished;
  final GameStatus? currentStatus;
  final bool showAll;

  const GamesState({this.allGames, this.error, this.loading = false, this.limit = 10, this.offsetAll = 0, this.offsetFinished = 0, this.offsetOpened = 0,
   this.offsetProgress = 0,
   this.hasMoreGamesAll = true, this.currentStatus, this.showGames, this.showAll = true, this.hasMoreGamesFinished = true, this.hasMoreGamesOpened = true,
   this.hasMoreGamesProgress = true, this.openGames, this.progressGames, this.finishedGames});

  GamesState copyWith({List<GameModel>? allGames, DataError? Function()? error, 
  bool? loading, int? limit,  bool? hasMoreGamesAll, bool? hasMoreGamesFinished, bool? hasMoreGamesOpened, bool? hasMoreGamesProgress,
  GameStatus? currentStatus, List<GameModel>? showGames, bool?showAll, int? offsetAll, int? offsetOpened, int? offsetProgress, int? offsetFinished,
  List<GameModel>? openGames, List<GameModel>? progressGames, List<GameModel>? finishedGames}){
      return GamesState(
        allGames : allGames ?? this.allGames,
        progressGames:  progressGames ?? this.progressGames,
        openGames:  openGames ?? this.openGames,
        finishedGames: finishedGames ?? this.finishedGames,
        error : error != null ? error() : this.error,
        loading : loading ?? this.loading, 
        limit : limit ?? this.limit,
        offsetAll : offsetAll ?? this.offsetAll,
        offsetFinished : offsetFinished ?? this.offsetFinished,
        offsetOpened : offsetOpened ?? this.offsetOpened,
        offsetProgress : offsetProgress ?? this.offsetProgress,
        hasMoreGamesAll : hasMoreGamesAll ?? this.hasMoreGamesAll,
        hasMoreGamesFinished : hasMoreGamesFinished ?? this.hasMoreGamesFinished,
        hasMoreGamesOpened : hasMoreGamesOpened ?? this.hasMoreGamesOpened,
        hasMoreGamesProgress : hasMoreGamesProgress ?? this.hasMoreGamesProgress,
        currentStatus: currentStatus ?? this.currentStatus,
        showGames : showGames ?? this.showGames,
        showAll : showAll ?? this.showAll
      );
  } 

  @override
  List<Object?> get props => [allGames, error, loading, limit, offsetAll, offsetOpened, offsetFinished, offsetProgress, hasMoreGamesAll, currentStatus, showGames, showAll,
  hasMoreGamesFinished, hasMoreGamesOpened, hasMoreGamesProgress, openGames, progressGames, finishedGames];
}
