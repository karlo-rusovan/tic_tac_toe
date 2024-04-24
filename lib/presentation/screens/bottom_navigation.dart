import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../constants/navbar_items.dart';
import '../../logic/navigation_cubit.dart';

class BottomNavBar extends StatefulWidget {
  const BottomNavBar({super.key});
  @override
  State<BottomNavBar> createState() => _BottomNavBarState();
}

class _BottomNavBarState extends State<BottomNavBar> {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<NavigationCubit, NavigationState>(
      builder: (context, state) {
        return Container(
          clipBehavior: Clip.hardEdge,
          height: 50,
          decoration: const BoxDecoration(
            color: Color(0xFFA57DD8),
            borderRadius: BorderRadius.only(
              topRight: Radius.circular(24),
              topLeft: Radius.circular(24),
            ),
            boxShadow: [
              BoxShadow(
                  color: Color(0xFFA57DD8), spreadRadius: 0, blurRadius: 20),
            ],
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Expanded(
                  child: state.navbarItem == NavbarItem.games
                      ? IconButton(
                          icon:
                              const Icon(Icons.home, color: Color.fromARGB(255, 247, 243, 243)),
                          onPressed: () => context
                              .read<NavigationCubit>()
                              .getNavBarItem(NavbarItem.games))
                      : IconButton(
                          icon:
                              const Icon(Icons.home, color: Color.fromARGB(176, 217, 217, 217)),
                          onPressed: () => context
                              .read<NavigationCubit>()
                              .getNavBarItem(NavbarItem.games))),
              Expanded(
                child: state.navbarItem == NavbarItem.leaderboard
                    ? IconButton(
                        icon:
                            const Icon(Icons.person, color: Color.fromARGB(255, 247, 247, 247)),
                        onPressed: () => context
                            .read<NavigationCubit>()
                            .getNavBarItem(NavbarItem.leaderboard))
                    : IconButton(
                        icon:
                            const Icon(Icons.person, color: Color.fromARGB(176, 217, 217, 217)),
                        onPressed: () => context
                            .read<NavigationCubit>()
                            .getNavBarItem(NavbarItem.leaderboard)),
              )
            ],
          ),
        );
      },
    );
  }

  void onNavButtonPressed(NavbarItem item) {
    context.read<NavigationCubit>().getNavBarItem(item);
  }
}
