import 'dart:async';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';
import '../domain/models/auth_errors.dart';
import '../domain/repositories/authentication_repository.dart';
import '../domain/models/auth_response.dart';

part 'authentication_state.dart';

class AuthenticationCubit extends Cubit<AuthenticationState>{
  final AuthenticationRepository authenticationRepository;
  AuthenticationCubit(this.authenticationRepository) : super(const AuthenticationState());

  _validateEmail(String email){
    String pattern = r'^.+@.+\..+$';
    RegExp regExp = RegExp(pattern);
    if (!regExp.hasMatch(email)) {
      return InvalidEmailError();
    }
    return null;
  }  

  _checkCredentials(String email, String password){
      if (email.isEmpty){
         return EmptyEmailError();
      } else if ( password.isEmpty){
        return EmptyPasswordError();
      } else if (_validateEmail(email) != null){
        return InvalidEmailError();
      } else {
        return null;
      }        
  }

  Future<void> logIn({String? email, String? password}) async{       
    emit(const AuthenticationState(loading: true, error: null, userId: null));
    if(email != null && password != null){
        var check = _checkCredentials(email, password);
        if (check != null){
          emit(state.copyWith(error: () => check, loading: false));
        } else {
          try{
            AuthResponse response = await authenticationRepository.logIn(email: email,password: password);        
            if (response.success){
              emit(state.copyWith(error: () => null, loading: false, userId: response.userId, token: response.token, username: response.username));
            } else if (response.credentialError) {
              emit(state.copyWith(loading: false, error:() => CredentialError()));
            } else {
              emit(state.copyWith(loading: false, error:() => LoginError()));
            }
          } on Exception  {
            emit(state.copyWith(loading: false, error:() => LoginError()));
          }       
        }        
    }     
  }       

  Future<void> signUp({String? email, String? password}) async{       
    emit(const AuthenticationState(loading: true, error: null, userId: null));
    if(email != null && password != null){
        var check = _checkCredentials(email, password);
        if (check != null){
          emit(state.copyWith(error: () => check, loading: false));
        } else {
          try{
            AuthResponse response = await authenticationRepository.signUp(email: email,password: password);        
            if (response.success){
              emit(state.copyWith(error: () => SuccessfulRegister(), loading: false, registrationSuccess: true));
            } else if (response.emailInUse) {
              emit(state.copyWith(loading: false, error: () => EmailInUseError()));
            } else {
              emit(state.copyWith(loading: false, error: () => RegistrationError()));
            }
          }on Exception  {
              emit(state.copyWith(loading: false, error: () => RegistrationError()));
          }       
        }        
    }     
  }   

  Future<void> logOut() async{ 
    try{
      await authenticationRepository.logOut(token: state.token);
      emit(const AuthenticationState());
    } on Exception {
      emit(state.copyWith(error:() => LogOutError()));
    }
  }

}