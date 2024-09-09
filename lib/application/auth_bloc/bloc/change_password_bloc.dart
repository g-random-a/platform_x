import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../infrustructure/auth/repository/auth_repo.dart';
import '../event/change_password_event.dart';
import '../state/change_password_state.dart';

class ChangePasswordBloc
    extends Bloc<ChangePasswordEvents, ChangePasswordStates> {
  final AuthRepo authRepo;

  ChangePasswordBloc({required this.authRepo})
      : super(ChangePasswordInitialState()) {
    on<ChangePasswordEvent>(onChangePasswordEvent);
    on<LoadChangePasswordEvent>(onLoadChangePassword);
  }

  onChangePasswordEvent(ChangePasswordEvent event, Emitter emit) async {
    emit(LoadingChangePasswordState());
    try {
      await authRepo.changePassword(event.password);
      emit(ChangePasswordSuccessState());
    } on Exception {
      emit(ChangePasswordFailedState());
    }
  }

  onLoadChangePassword(LoadChangePasswordEvent event, Emitter emit) async {
    emit(ChangePasswordInitialState());
  }
}
