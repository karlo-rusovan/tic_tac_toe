import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../constants/navbar_items.dart';

part 'navigation_state.dart';

class NavigationCubit extends Cubit<NavigationState> {
  NavigationCubit() : super(const NavigationState(NavbarItem.games));

  void getNavBarItem(NavbarItem navbarItem) {
    switch (navbarItem) {
      case NavbarItem.games:
        emit(const NavigationState(NavbarItem.games));
        break;
      case NavbarItem.leaderboard:
        emit(const NavigationState(NavbarItem.leaderboard));
        break;      
    }
  }
}
