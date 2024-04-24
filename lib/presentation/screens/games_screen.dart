import 'package:flutter/material.dart';
import 'package:flutter_application_1/presentation/widgets/game_card.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../logic/authentication_cubit.dart';
import '../../logic/games_cubit.dart';
import '../../domain/models/game_model.dart';
import '../widgets/filter_button.dart';
import '../../constants/game_status.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class GamesScreen extends StatefulWidget {
  const GamesScreen({super.key});
  @override
  State<GamesScreen> createState() => _GamesScreenState();
}

class _GamesScreenState extends State<GamesScreen> {
  final ScrollController _scrollController = ScrollController();

  @override
  void initState() {
    super.initState();
    context.read<GamesCubit>().reloadGames();        
    _scrollController.addListener(_scrollListener);   
  }

  @override
  void dispose() {
    super.dispose();
    _scrollController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: const Color(0xFFA57DD8),
          centerTitle: true,
          title:  Text(
            AppLocalizations.of(context)!.gamesTitle,
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
        body: Column(
          children: [
            const SizedBox(height: 10),
            BlocBuilder<GamesCubit, GamesState>(
              builder: (context, state) {
                return  state.error != null
                        ? Expanded(child: Center(child: Text(state.error!.message(context))))
                        : Expanded(
                            child: RefreshIndicator(
                                    onRefresh: () => context.read<GamesCubit>().reloadGames(),
                                    child: ListView.separated(
                              separatorBuilder: (context, index) {
                                return const SizedBox(
                                  height: 5,
                                );
                              },
                              padding: const EdgeInsets.only(
                                  left: 20, top: 5, right: 15, bottom: 5),
                              itemCount: state.showGames!.length + 2,
                              itemBuilder: (context, index) {
                                if (index == 0) {
                                   return Row (
                                    children: [
                                    FilterButtonWidget(
                                        label: AppLocalizations.of(context)!.labelAll,
                                        highlight: state.showAll == true ? true : false,
                                        function: () => {context.read<GamesCubit>().filterGames()}),
                                    const SizedBox(width: 10),
                                    FilterButtonWidget(
                                        label: AppLocalizations.of(context)!.labelOpen,
                                        highlight: state.currentStatus == GameStatus.open && state.showAll == false ? true : false,
                                        function: () => {context.read<GamesCubit>().filterGames(status:GameStatus.open)}),
                                    const SizedBox(width: 10),
                                    FilterButtonWidget(
                                        label: AppLocalizations.of(context)!.labelFinished,
                                        highlight: state.currentStatus == GameStatus.finished && state.showAll == false ? true : false,
                                        function: () => {context.read<GamesCubit>().filterGames(status:GameStatus.finished)}),
                                    const SizedBox(width: 10),
                                    FilterButtonWidget(
                                        label: AppLocalizations.of(context)!.labelInProgress,
                                        highlight: state.currentStatus == GameStatus.inProgress && state.showAll == false ? true : false,
                                        function: () => {context.read<GamesCubit>().filterGames(status:GameStatus.inProgress)}),
                                    const SizedBox(width: 10),
                                    IconButton(onPressed: () => context.read<GamesCubit>().createGame(), icon: const Icon(Icons.add))
                                  ]);
                                } else if (index <= state.showGames!.length) {
                                  return listBuild(state.showGames![index - 1]);
                                } else {
                                  if (((state.currentStatus == null && state.hasMoreGamesAll) || (state.showAll == false && state.currentStatus == GameStatus.finished && state.hasMoreGamesFinished)
                                  || (state.showAll == false && state.currentStatus == GameStatus.inProgress && state.hasMoreGamesProgress) || (state.showAll == true && state.hasMoreGamesAll) ||
                                  (state.showAll == false && state.currentStatus == GameStatus.open && state.hasMoreGamesOpened)) && state.showGames!.length >= state.limit) {
                                    return const Center(
                                        child: CircularProgressIndicator());
                                  } else {
                                    return const SizedBox();
                                  }
                                }
                              },
                              controller: _scrollController,
                            ),
                          ));
              },
            )
          ],
        ));
  }

  Widget listBuild(GameModel gameModel) {
    return GameCard(gameModel: gameModel, playerName: context.read<AuthenticationCubit>().state.username);
  }

  void _scrollListener() {
    if (_scrollController.offset >=
            _scrollController.position.maxScrollExtent &&
        !_scrollController.position.outOfRange) {
      context.read<GamesCubit>().filterGames(loadMore: true);      
    }  
  }  
}
