import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../event/sign_out_events.dart';
import '../state/sign_out_states.dart';

class SignOutBloc extends Bloc<SignOutEvent, SignOutStates> {
  SignOutBloc() : super(SignOutInitialState()) {
    on<StartSignOutEvent>(onSignOut);
  }

  onSignOut(SignOutEvent event, Emitter emit) async {
    emit(LoadingSignOutState());
    try {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      bool cleared = await prefs.clear();
      if (!cleared) throw Exception();
      emit(SignOutSuccessState());
    } on Exception {
      emit(SignOutFailedState());
    }
  }
}
