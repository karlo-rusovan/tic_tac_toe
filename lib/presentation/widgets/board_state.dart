import 'package:flutter/material.dart';
import 'package:flutter_application_1/logic/current_game_cubit.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class GameBoard extends StatelessWidget {
  final List<dynamic> boardState;
  final int? firstPlayerId;
  final int? secondPlayerId;  
  final bool playerMove;
  final int? gameId;

  const GameBoard(
      {super.key,
      required this.boardState, 
      required this.firstPlayerId,
      required this.secondPlayerId,
      required this.playerMove,
      required this.gameId
  });

  @override
  Widget build(BuildContext context) {
    return GridView.builder(
      itemCount: 9,
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 3,
        crossAxisSpacing: 4.0,
        mainAxisSpacing: 4.0,
      ),
      itemBuilder: (BuildContext context, int index) {        
        int row = index ~/ 3;
        int col = index % 3;        
        int? cellValue = boardState[row][col];        
        Widget cellContent;
        if (cellValue == firstPlayerId) {          
          cellContent = Icon(Icons.close, size: 48, color: Colors.grey[100]);
        } else if (cellValue == secondPlayerId && secondPlayerId != null) {         
          cellContent = const Icon(Icons.circle_outlined, size: 48, color: Colors.black);
        } else {         
          cellContent = const SizedBox();
        }
        return GestureDetector(
          onTap: () {  
            if(playerMove && cellValue == null){
              context.read<CurrentGameCubit>().move(row: row, col: col, gameId: gameId);           
            }            
          },
          child: Container(
            color: playerMove && cellValue == null ? const Color.fromARGB(255, 217, 198, 243) : const Color(0xFFA57DD8),
            child: Center(child: cellContent),
          ),
        );
      },
    );
  }
}
