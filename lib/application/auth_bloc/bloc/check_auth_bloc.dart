import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../event/check_auth_event.dart';
import '../state/check_auth_state.dart';

class CheckAuthBloc extends Bloc<CheckAuthEvents, CheckAuthStates> {
  SharedPreferences prefs;

  CheckAuthBloc({required this.prefs}) : super(CheckAuthInitialState()) {
    on<CheckAuthEvent>(onCheckAuth);
  }

  onCheckAuth(CheckAuthEvents event, Emitter emit) async {
    emit(LoadingCheckAuthState());
    try {
      // bool cleared = await prefs.clear();
      // if (!cleared) throw Exception();
      // final Box<DetectedLeaf> detectedLeafBox = Boxes.getDetectedLeaf();
      // detectedLeafBox.clear();
      String? token = prefs.getString("token");
      String? name = prefs.getString("name");
      String? email = prefs.getString("email");
      String? password = prefs.getString("password");

      if (token != null && name != null && email != null && password != null) {
        emit(CheckAuthSuccessState(
            token: token, name: name, password: password, email: email));
      } else {
        throw Exception("");
      }
    } on Exception {
      emit(CheckAuthFailedState());
    }
  }
}
