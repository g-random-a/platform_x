import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../infrustructure/auth/repository/auth_repo.dart';
import '../registeration_bloc.dart';

class RegisterationBloc extends Bloc<RegisterEvents, RegisterStates> {
  final AuthRepo authRepo;

  RegisterationBloc({required this.authRepo})
      : super(RegisterationInitialState()) {
    on<StartRegistionEvent>(onRegister);
    on<InitialRegistionEvent>((InitialRegistionEvent event, Emitter emit) {
      emit(RegisterationInitialState());
    });
  }

  onRegister(StartRegistionEvent event, Emitter emit) async {
    emit(RegisterLoadingState());
    try {
      bool registered = await authRepo.register(
          event.fullname, event.username, event.password);
      if (!registered) throw Exception("Failed to register");
      emit(RegisterSuccessState());
    } on Exception {
      emit(RegisterFailedState());
    }
  }
}
