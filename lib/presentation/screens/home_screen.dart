import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../logic/navigation_cubit.dart';
import 'games_screen.dart';
import 'leaderboard_screen.dart';
import '../../constants/navbar_items.dart';
import 'bottom_navigation.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});
  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return  Scaffold(      
      bottomNavigationBar: const BottomNavBar(),
      body: BlocBuilder<NavigationCubit, NavigationState>(
        builder: (context, state) {
          if (state.navbarItem == NavbarItem.games){
            return const GamesScreen();
          } else if (state.navbarItem == NavbarItem.leaderboard){
            return const LeaderboardScreen();
          } else {
            return const GamesScreen();
          }    
        }     
      )
    );
  }
}
