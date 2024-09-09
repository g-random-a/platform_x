import '../../../lib.dart';
import '../auth.dart';

class AuthBloc extends Bloc<AuthEvents, AuthStates> {
  final AuthRepo authRepo;

  AuthBloc({required this.authRepo}) : super(LoggingInitialState()) {
    on<LoginEvent>(onLogin);
    on<InitialEvent>((InitialEvent event, Emitter emit) {
      emit(LoggingInitialState());
    });
    on<TestLoginEvent>(onLoginTest);
  }

  onLogin(LoginEvent event, Emitter emit) async {
    emit(LoggingInState());
    try {
      String accessToken = await authRepo.login(event.username, event.password);
      emit(LoggedInState());
    } on Exception {
      emit(LoginFailedState());
    }
  }

  onLoginTest(TestLoginEvent event, Emitter emit) async {
    emit(LoggingInState());
    try {
      String accessToken = await authRepo.testLogin();
      emit(LoggedInState());
    } on Exception {
      emit(LoginFailedState());
    }
  }
}
