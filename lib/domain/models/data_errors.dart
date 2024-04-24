import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

abstract class DataError {
  String message(BuildContext context);
}

class GamesFetchError implements DataError {
   @override
   String message(BuildContext context){
      return AppLocalizations.of(context)!.gamesFetchError;    
   }
}

class GameCreateError implements DataError {
   @override
   String message(BuildContext context){
    return AppLocalizations.of(context)!.gameCreateError;      
   }
}

class GameJoinError implements DataError {
   @override
   String message(BuildContext context){
      return AppLocalizations.of(context)!.gameJoinError;     
   }
}

class GameMoveError implements DataError {
   @override
   String message(BuildContext context){
      return AppLocalizations.of(context)!.gameMoveError;    
   }
}

class FetchUsersError implements DataError {
   @override
   String message(BuildContext context){
      return AppLocalizations.of(context)!.fetchUsersError;      
   }
}