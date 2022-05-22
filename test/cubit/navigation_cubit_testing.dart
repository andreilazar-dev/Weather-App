import 'package:bloc_test/bloc_test.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:weather_app/cubit/navigation_cubit.dart';
import 'package:weather_app/models/nav_item.dart';
import 'package:weather_app/states/navigation_state.dart';


void main() {
  group('NavigationCubit',() {
    late NavigationCubit navigationCubit;
    setUp((){
      navigationCubit = NavigationCubit();
    });
    tearDown((){
      navigationCubit.close();
    });

    test('cubit initial state  as [day , 0] ',(){
        expect(navigationCubit.state,NavigationState(NavbarItem.day, 0));
    });

    blocTest('should emit [NavigationState(NavbarItem.week, 1)]',
        build: () => navigationCubit,
        act: (NavigationCubit cubit) => cubit.getNavBarItem(NavbarItem.week),
        expect: () => [NavigationState(NavbarItem.week,1)]
    );

    blocTest('should emit [NavigationState(NavbarItem.week, 1)]',
        build: () => navigationCubit,
        act: (NavigationCubit cubit) => cubit.getNavBarItem(NavbarItem.day),
        expect: () => [NavigationState(NavbarItem.day,0)] 
    );
  });
}