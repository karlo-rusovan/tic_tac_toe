part of 'current_game_cubit.dart';

class CurrentGameState extends Equatable {
  final DataError? error;
  final GameModel? gameModel;
  final bool loading;
  final int? shouldRefresh;

  const CurrentGameState({this.error, this.gameModel, this.loading = false, this.shouldRefresh});

  @override
  List<Object?> get props => [error, gameModel, loading, shouldRefresh];
}
