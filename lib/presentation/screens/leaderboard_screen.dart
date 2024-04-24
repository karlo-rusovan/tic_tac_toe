import 'package:flutter/material.dart';
import 'package:flutter_application_1/domain/models/user_model.dart';
import 'package:flutter_application_1/logic/leaderboard_cubit.dart';
import 'package:flutter_application_1/presentation/widgets/user_card.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../logic/authentication_cubit.dart';

class LeaderboardScreen extends StatefulWidget {
  const LeaderboardScreen({super.key});
  @override
  State<LeaderboardScreen> createState() => _LeaderboardScreenState();
}

class _LeaderboardScreenState extends State<LeaderboardScreen> {

  final ScrollController _scrollController = ScrollController();

  @override
  void initState() {
    super.initState();
    context.read<LeaderboardCubit>().reloadUsers();
    _scrollController.addListener(_scrollListener);  
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      appBar: AppBar(
          backgroundColor: const Color(0xFFA57DD8), // Background color
          centerTitle: true, // Center the title
          title: Text(
            AppLocalizations.of(context)!.leaderboardTitle,
            style: const TextStyle(
              color: Colors.white, // Text color
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
      body: BlocBuilder<LeaderboardCubit, LeaderboardState>(        
        builder: (context, state) => 
          state.loading && state.offset == 0 ? 
          const Center(child: CircularProgressIndicator())
          :
          state.error != null ?
          Center(child: Text(state.error!.message(context)))
          :
          Expanded(                 
            child: ListView.separated(
              separatorBuilder: (context, index) {
                return const SizedBox(
                  height: 5,
                );
              },
              padding: const EdgeInsets.only(
                  left: 20, top: 5, right: 15, bottom: 5),
              itemCount: state.users!.length + 1,
              itemBuilder: (context, index) {
                if (index < state.users!.length) {
                  return listBuild(state.users![index]);
                } else {
                  if (state.hasMoreUsers) {
                    return const Center(
                        child: CircularProgressIndicator());
                  } else {
                    return const SizedBox();
                  }
                }
              },
              controller: _scrollController,
            )
          )
      )
    );
  }

  Widget listBuild(UserModel user) {
    return UserCard(userModel: user);
  }

  void _scrollListener() {
    if (_scrollController.offset >=
            _scrollController.position.maxScrollExtent &&
        !_scrollController.position.outOfRange) {
      context.read<LeaderboardCubit>().getUsers();      
    }  
  }  
}
