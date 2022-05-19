import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:weather_app/screens/weather_day_screen.dart';
import 'package:weather_app/screens/weather_week_screen.dart';
import '../blocs/navigation_cubit.dart';
import '../blocs/weather_bloc.dart';
import '../events/weather_event.dart';
import '../models/nav_item.dart';
import '../states/navigation_state.dart';
import '../widget/searchbar.dart';

class RootScreen extends StatefulWidget {
  @override
  _RootScreenState createState() => _RootScreenState();

}


class _RootScreenState extends State<RootScreen> {

  final TextEditingController _cityTextController = TextEditingController();

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: BlocBuilder<NavigationCubit, NavigationState>(
        builder: (context, state) {
          return BottomNavigationBar(
            currentIndex: state.index,
            showUnselectedLabels: false,
            backgroundColor: Color.fromRGBO(254,250, 224, 1),
            items: [
              BottomNavigationBarItem(
                icon: Icon(Icons.today),
                label: "Today",
              ),
              BottomNavigationBarItem(
                icon: Icon(Icons.calendar_month),
                label: "Week",
              ),
            ],
            onTap: (index) {
              if (index == 0) {
                BlocProvider.of<NavigationCubit>(context)
                    .getNavBarItem(NavbarItem.day);
              } else if (index == 1) {
                BlocProvider.of<NavigationCubit>(context)
                    .getNavBarItem(NavbarItem.week);
              }
            },
          );
        },
      ),
      body: BlocBuilder<NavigationCubit, NavigationState>(
          builder: (context, state) {
            if (state.navbarItem == NavbarItem.day) {
              return WeatherDayScreen();
            } else if (state.navbarItem == NavbarItem.week) {
              return WeatherWeekScreen();
            }
            return Container();
          }),
      floatingActionButton: Padding(
        padding: const EdgeInsets.all(15.0),
        child: SearchBarAnimation(
          textEditingController: _cityTextController,
          isOriginalAnimation: true,
          enableKeyboardFocus: true,
          onFieldSubmitted: (String value){
            debugPrint(value);
            BlocProvider.of<WeatherBloc>(context)
                .add(WeatherEventRequested(city: value));
          },
          onExpansionComplete: () {
            debugPrint(
                'do something just after searchbox is opened.');
          },
          onCollapseComplete: () {
            debugPrint(
                'do something just after searchbox is closed.');
          },
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerTop,

    );
  }
}

