import 'package:flutter_bloc/flutter_bloc.dart';

class WeatherBlocObserver extends BlocObserver {
  @override
  void onEvent(Bloc bloc, Object? event) {
    // TODO: implement onEvent
    super.onEvent(bloc, event);
    print('onEvent $event');
  }
  @override
  void onTransition(Bloc bloc,Transition transition){
    super.onTransition(bloc, transition);
    print('onTransition $transition');
  }
}