import 'package:bloc/bloc.dart';
import '../models/nav_item.dart';
import '../states/navigation_state.dart';

class NavigationCubit extends Cubit<NavigationState> {
  NavigationCubit() : super(NavigationState(NavbarItem.day, 0));

  void getNavBarItem(NavbarItem navbarItem) {
    switch (navbarItem) {
      case NavbarItem.day:
        emit(NavigationState(NavbarItem.day, 0));
        break;
      case NavbarItem.week:
        emit(NavigationState(NavbarItem.week, 1));
        break;
    }
  }
}
