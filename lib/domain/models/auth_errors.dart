import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

abstract class AuthError {
  String message(BuildContext context);
}

class EmptyEmailError implements AuthError {
   @override
   String message(BuildContext context){
      return AppLocalizations.of(context)!.emptyEmailError;
   }
}

class EmptyPasswordError implements AuthError{
  @override
  String message(BuildContext context){
    return AppLocalizations.of(context)!.emptyPasswordError; 
  }
}

class InvalidEmailError implements AuthError{
  @override
  String message(BuildContext context){
    return AppLocalizations.of(context)!.invalidEmailError;   
  }
}

class LoginError implements AuthError{
  @override
  String message(BuildContext context){
    return AppLocalizations.of(context)!.loginError;    
  }
}

class CredentialError implements AuthError{
  @override
  String message(BuildContext context){
    return AppLocalizations.of(context)!.credentialError;    
  }
}

class SuccessfulRegister implements AuthError{
  @override
  String message(BuildContext context){
    return AppLocalizations.of(context)!.successfulRegister;   
  }
}

class EmailInUseError implements AuthError{
  @override
  String message(BuildContext context){
    return AppLocalizations.of(context)!.emailInUseError;   
  }
}

class RegistrationError implements AuthError{
  @override
  String message(BuildContext context){
    return AppLocalizations.of(context)!.registrationError;   
  }
}

class LogOutError implements AuthError{
  @override
  String message(BuildContext context){
    return AppLocalizations.of(context)!.logOutError;  
  }
}