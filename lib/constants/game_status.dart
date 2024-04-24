enum GameStatus { open, inProgress, finished}

extension GameStatusX on GameStatus {
  static GameStatus fromString(String string){
    if (string == 'open'){
      return GameStatus.open;
    } else if (string == 'finished'){
      return GameStatus.finished;
    } else {
      return GameStatus.inProgress;
    }
  }

  static String statusToString(GameStatus status){
    if (status == GameStatus.open){
      return "open";
    } else if (status == GameStatus.finished){
      return "finished";
    } else {
      return "in progress";
    }
  }
}