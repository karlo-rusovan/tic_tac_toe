import 'package:flutter/material.dart';
import 'package:flutter_application_1/constants/game_status.dart';
import 'package:flutter_application_1/logic/authentication_cubit.dart';
import 'package:flutter_application_1/logic/current_game_cubit.dart';
import 'package:intl/intl.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import '../widgets/board_state.dart';

class GameDetailScreen extends StatefulWidget {
  const GameDetailScreen({super.key, required this.gameId});
  final int? gameId;

  @override
  State<GameDetailScreen> createState() => _GameDetailScreenState();
}

class _GameDetailScreenState extends State<GameDetailScreen> {
  @override
  void initState() {
    context.read<CurrentGameCubit>().startRefresh(gameId: widget.gameId);
    context.read<CurrentGameCubit>().refreshGame(gameId: widget.gameId);
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return PopScope(
      onPopInvoked : (didPop){
        context.read<CurrentGameCubit>().stopRefresh(gameId: widget.gameId);
      },
        child: Scaffold(
            appBar: AppBar(
              backgroundColor: const Color(0xFFA57DD8),
              centerTitle: true,
              title: Text(
                AppLocalizations.of(context)!.gameDetailTitle,
                style: const TextStyle(
                  color: Colors.white,
                ),
              ),
              actions: <Widget>[
                IconButton(
                  icon: const Icon(Icons.logout),
                  color: Colors.white,
                  onPressed: () {
                    context.read<AuthenticationCubit>().logOut();
                    Navigator.of(context).popUntil((route) => route.isFirst);
                  },
                ),
              ],
            ),
            body: BlocBuilder<CurrentGameCubit, CurrentGameState>(
                builder: (context, state) {
              return state.error != null
                  ? Center(child: Text(state.error!.message(context)))
                  : state.loading
                      ? const Center(child: CircularProgressIndicator())
                      : Column(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            const SizedBox(height: 20),
                            Text(
                              '${AppLocalizations.of(context)!.gameId}: ${state.gameModel!.id}',
                              style: const TextStyle(
                                  fontSize: 18, fontWeight: FontWeight.bold),
                            ),
                            const SizedBox(height: 10),
                            Text(
                              '${AppLocalizations.of(context)!.created}: ${DateFormat.yMd().add_Hms().format(state.gameModel!.created!.toLocal())}',
                              style: const TextStyle(fontSize: 16),
                            ),
                            const SizedBox(height: 10),
                            Text(
                              state.gameModel!.secondPlayerUsername == ""
                                  ? '${AppLocalizations.of(context)!.players}: ${state.gameModel!.firstPlayerUsername} vs. nobody yet'
                                  : '${AppLocalizations.of(context)!.players}: ${state.gameModel!.firstPlayerUsername} vs. ${state.gameModel!.secondPlayerUsername}',
                              style: const TextStyle(fontSize: 16),
                            ),
                            const SizedBox(height: 10),
                            Text(
                              '${AppLocalizations.of(context)!.status}: ${GameStatusX.statusToString(state.gameModel!.status)}',
                              style: const TextStyle(fontSize: 16),
                            ),
                            const SizedBox(height: 10),
                            state.gameModel!.status == GameStatus.inProgress
                                ? Text(
                                    state.gameModel!.turn == 1
                                        ? '${AppLocalizations.of(context)!.turn}: ${state.gameModel!.firstPlayerUsername}'
                                        : '${AppLocalizations.of(context)!.turn}: ${state.gameModel!.secondPlayerUsername}',
                                    style: const TextStyle(fontSize: 16),
                                  )
                                : const SizedBox(),
                            state.gameModel!.winnerId != null
                                ? Text(
                                    '${AppLocalizations.of(context)!.winner}: ${state.gameModel!.winnerUsername}',
                                    style: const TextStyle(fontSize: 16),
                                  )
                                : const SizedBox(),
                            const SizedBox(height: 10),
                            state.gameModel!.firstPlayerId !=
                                        context
                                            .read<AuthenticationCubit>()
                                            .state
                                            .userId &&
                                    state.gameModel!.secondPlayerId !=
                                        context
                                            .read<AuthenticationCubit>()
                                            .state
                                            .userId &&
                                    state.gameModel!.status == GameStatus.open
                                ? GestureDetector(
                                    onTap: () {
                                      context
                                          .read<CurrentGameCubit>()
                                          .joinGame(state.gameModel!.id);
                                    },
                                    child: Container(
                                      padding: const EdgeInsets.symmetric(
                                          horizontal: 10, vertical: 5),
                                      decoration: BoxDecoration(
                                          borderRadius:
                                              BorderRadius.circular(8),
                                          color: Colors.grey[800]),
                                      child: Text(
                                        AppLocalizations.of(context)!.joinGame,
                                        style: const TextStyle(
                                          color: Colors.white,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                    ),
                                  )
                                : const SizedBox(),
                            const SizedBox(height: 20),
                            Expanded(
                              child: GameBoard(
                                  boardState: state.gameModel!.boardState!,
                                  firstPlayerId: state.gameModel!.firstPlayerId,
                                  secondPlayerId:
                                      state.gameModel!.secondPlayerId,
                                  playerMove: (state.gameModel!.turn == 1 &&
                                              context
                                                      .read<
                                                          AuthenticationCubit>()
                                                      .state
                                                      .userId ==
                                                  state.gameModel!
                                                      .firstPlayerId) ||
                                          (state.gameModel!.turn == 2 &&
                                              context
                                                      .read<
                                                          AuthenticationCubit>()
                                                      .state
                                                      .userId ==
                                                  state.gameModel!
                                                      .secondPlayerId)
                                      ? true
                                      : false,
                                  gameId: state.gameModel!.id),
                            )
                          ],
                        );
            })));
  }
}
