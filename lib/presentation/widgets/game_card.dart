import 'package:flutter/material.dart';
import '../../domain/models/game_model.dart';
import '../screens/game_detail_screen.dart';
import 'package:intl/intl.dart';
import '../../constants/game_status.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class GameCard extends StatelessWidget {
  const GameCard(
      {super.key, required this.gameModel, required this.playerName});

  final GameModel gameModel;
  final String playerName; 

  @override
  Widget build(BuildContext context) {
    final localDateTime = gameModel.created!.toLocal();
    final formattedDateTime = DateFormat(AppLocalizations.of(context)!.dateFormat).format(localDateTime);
    return Container(
        decoration: BoxDecoration(
          color: const Color.fromARGB(255, 81, 59, 121),
          borderRadius: BorderRadius.circular(8.0), 
        ),
        child: ListTile(
          contentPadding: const EdgeInsets.fromLTRB(10, 0, 10, 0),
          title: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.fromLTRB(10, 0, 0, 0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "${AppLocalizations.of(context)!.created}: $formattedDateTime",
                      style: const TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 12,
                          color: Colors.white),
                    ),
                    const SizedBox(height: 5),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Expanded(
                          child: Text(
                            "${gameModel.firstPlayerUsername} vs. ${gameModel.secondPlayerUsername!.isEmpty ? 'nobody' : gameModel.secondPlayerUsername}",
                            maxLines: 2,
                            
                            overflow: TextOverflow.ellipsis,
                            style: TextStyle(
                              color: gameModel.firstPlayerUsername == playerName
                                  ? Colors.red
                                  : gameModel.secondPlayerUsername == playerName
                                      ? Colors.red
                                      : Colors.white,
                            ),
                          ),
                        ),
                        const SizedBox(
                            width: 10), 
                        Text(
                          "${AppLocalizations.of(context)!.status}: ${GameStatusX.statusToString(gameModel.status)}",
                          style: const TextStyle(color: Colors.white),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
          trailing: const Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(
                Icons.arrow_forward,
                color: Color(0xFFFFFFFF),
                size: 24,
              ),
            ],
          ),
          onTap: () => {           
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => GameDetailScreen(gameId: gameModel.id),
              ),
            ),
          },
        ));
  }
}
