part of 'leaderboard_cubit.dart';

class LeaderboardState extends Equatable {
  final DataError? error;
  final List<UserModel>? users;
  final int limit;
  final int offset;
  final bool loading;
  final bool hasMoreUsers;

  const LeaderboardState({this.error, this.users, this.limit = 10, this.offset = 0, this.loading = true, this.hasMoreUsers = true});

  LeaderboardState copyWith({ DataError? Function()? error, List<UserModel>? users, int? limit, int? offset, bool? loading, bool? hasMoreUsers}){
      return LeaderboardState(
        error : error != null ? error() : this.error,
        users : users ?? this.users,
        limit : limit ?? this.limit,
        offset : offset ?? this.offset,
        loading : loading ?? this.loading,
        hasMoreUsers : hasMoreUsers ?? this.hasMoreUsers        
      );
  } 

  @override
  List<Object?> get props => [error, users, limit, offset, loading, hasMoreUsers];
}
