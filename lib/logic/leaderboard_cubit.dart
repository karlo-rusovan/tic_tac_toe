import 'package:equatable/equatable.dart';
import 'package:flutter_application_1/logic/authentication_cubit.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../domain/repositories/user_repository.dart';
import '../domain/models/data_errors.dart';
import '../domain/models/user_model.dart';

part 'leaderboard_state.dart';

class LeaderboardCubit extends Cubit<LeaderboardState> {
  final UserRepository userRepository;
  final AuthenticationCubit authenticationCubit;
  LeaderboardCubit(this.userRepository, this.authenticationCubit) : super(const LeaderboardState());

  Future<void> reloadUsers() async {
    emit(state.copyWith(offset: 0, users: []));
    getUsers();
  }

  Future<void> getUsers() async{
    try {
       emit(state.copyWith(error: () => null, loading: true));
       List<UserModel>? response = await userRepository.getPlayers(token: authenticationCubit.state.token, limit: state.limit, offset: state.offset);
       if(response != null){
          if(response.isNotEmpty){
            List<UserModel> allUsers =  List.of(state.users!);
            allUsers.addAll(response);           
            emit(state.copyWith(error: null,loading: false, offset: state.offset + response.length, users: allUsers, hasMoreUsers: true));
          } else {
            emit(state.copyWith(error: null, loading: false, hasMoreUsers: false));
          }
       }else {
        emit(state.copyWith(loading: false, error: () => FetchUsersError()));
       }
    } on Exception {
      emit(state.copyWith(loading: false, error: () => FetchUsersError()));
    }
  }  
  
}
