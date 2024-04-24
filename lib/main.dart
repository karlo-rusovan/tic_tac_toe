import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:flutter_application_1/domain/repositories/authentication_repository.dart';
import 'package:flutter_application_1/domain/repositories/user_repository.dart';
import 'package:flutter_application_1/logic/current_game_cubit.dart';
import 'package:flutter_application_1/logic/leaderboard_cubit.dart';
import 'package:flutter_application_1/presentation/screens/root_screen.dart';
import 'package:flutter_application_1/logic/authentication_cubit.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_application_1/logic/navigation_cubit.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'domain/repositories/games_repository.dart';
import 'logic/games_cubit.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    return MultiRepositoryProvider(
        providers: [
          RepositoryProvider<AuthenticationRepository>(
              create: (context) => AuthenticationRepository()),
          RepositoryProvider<GamesRepository>(
              create: (context) => GamesRepository()),
          RepositoryProvider<UserRepository>(
            create: (context) => UserRepository()),
        ],
        child: MultiBlocProvider(
            providers: [
              BlocProvider<NavigationCubit>(
                  create: (context) => NavigationCubit()),
              BlocProvider<AuthenticationCubit>(
                  create: (context) => AuthenticationCubit(
                      context.read<AuthenticationRepository>())),
              BlocProvider<GamesCubit>(
                  create: (context) => GamesCubit(
                      context.read<GamesRepository>(),
                      context.read<AuthenticationCubit>())),
              BlocProvider<CurrentGameCubit>(
                  create: (context) => CurrentGameCubit(
                      context.read<GamesRepository>(), context.read<AuthenticationCubit>()
                  )),
              BlocProvider<LeaderboardCubit>(
                  create: (context) => LeaderboardCubit(
                      context.read<UserRepository>(), context.read<AuthenticationCubit>()
                  )),
            ],
            child: MaterialApp(
              localizationsDelegates: const [
                AppLocalizations.delegate,
                GlobalMaterialLocalizations.delegate,
                GlobalWidgetsLocalizations.delegate,
                GlobalCupertinoLocalizations.delegate,
              ],
              supportedLocales: const [
                Locale('en', ''),
              ],
              title: 'Flutter Demo',
              theme: ThemeData(
                colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
                useMaterial3: true,
              ),
              home: const RootScreen(),
            )));
  }
}
