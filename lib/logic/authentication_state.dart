part of 'authentication_cubit.dart';

class AuthenticationState extends Equatable{
    final bool loading;
    final AuthError? error;
    final int? userId;
    final String token;
    final String username;
    final bool registrationSuccess;

    const AuthenticationState(
      {
        this.loading = false,
        this.error,
        this.userId,
        this.registrationSuccess = false,
        this.token = '',
        this.username = '',
      }
    );

    AuthenticationState copyWith({bool? loading, AuthError? Function()? error, int? userId, bool? registrationSuccess, String? username, String? token}){
      return AuthenticationState(
        loading : loading ?? this.loading,
        error : error != null ? error () : this.error,
        userId : userId ?? this.userId,
        registrationSuccess: registrationSuccess ?? this.registrationSuccess,
        token : token ?? this.token,
        username : username ?? this.username
      );
    } 

    @override
    List<Object?> get props => [
      loading,
      error,
      userId,
      registrationSuccess,
      token,
      username
    ];
}