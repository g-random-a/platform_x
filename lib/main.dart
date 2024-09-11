
import 'package:platform_x/application/auth_bloc/event/auth_events.dart';
import 'package:platform_x/application/bookmark_bloc/bloc/bookmark_bloc.dart';
import 'package:platform_x/application/bookmark_bloc/event/bookmark_event.dart';
import 'package:platform_x/infrustructure/tasks/data_provider/tasks_data_provider.dart';

import 'application/tasks_bloc/bloc/tasks_bloc.dart';
import 'infrustructure/tasks/repository/tasks_repo.dart';
import 'lib.dart';
import 'package:permission_handler/permission_handler.dart';


void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Permission.microphone.request();

  SystemChrome.setPreferredOrientations([ 
    DeviceOrientation.portraitUp,
    DeviceOrientation.landscapeLeft,
    DeviceOrientation.landscapeRight,
    DeviceOrientation.portraitDown,
  ]);

  SystemChrome.setEnabledSystemUIMode(SystemUiMode.manual,
      overlays: [SystemUiOverlay.top, SystemUiOverlay.bottom]);

  SharedPreferences prefs = await SharedPreferences.getInstance();
  var token = prefs.getString('token');
  bool isLoggedIn = token != null;

  final Dio dio = Dio();
  // set timeout for dio
  dio.options.connectTimeout = Duration(seconds: 10); //5s

  await dotenv.load();

  runApp(
    // MultiRepositoryProvider(
    // providers: [
    //   // RepositoryProvider(
    //   //   create: (context) => UploadRepository(
    //   //       uploadDataProvider:
    //   //           UploadDataProvider(dio: dio, uploadService: uploadService)),
    //   // ),
    //   // RepositoryProvider(
    //   //   create: (context) => SyncDataRepository(
    //   //       syncDataProvider:
    //   //           SyncDataProvider(dio: dio, uploadService: uploadService)),
    //   // ),
    // ],
    // child:
     MultiBlocProvider(
      providers: [
        BlocProvider(
            create: (context) => ThemeBloc()..add(const LoadThemeEvent())),
        BlocProvider(
            create: (context) => FeedbackBloc(
                feedbackRepository: FeedbackRepository(
                    feedbackDataProvider: FeedbackDataProvider(dio: dio)))),
        // BlocProvider(
        //     create: (context) => SyncDataBloc(
        //         prefs: prefs,
        //         syncDataRepo: context.read<SyncDataRepository>())),
        BlocProvider(
            create: (context) =>
                TasksBloc(tasksRepository: TasksRepository(tasksDataProvider: TasksDataProvider(dio: dio)))),
        BlocProvider(
            lazy: false,
            create: (context) =>
                CheckAuthBloc(prefs: prefs)..add(CheckAuthEvent())),
        BlocProvider(create: (context) => SignOutBloc()),
        // BlocProvider(
        //     create: (context) =>
        //         RecentUploadsBloc()..add(const LoadRecentUploadsEvent())),
        // BlocProvider(
        //   create: (context) =>
        //       UploadBloc(uploadRepo: context.read<UploadRepository>()),
        // ),
        // BlocProvider(
        //   create: (context) =>
        //       ScannedRecentBloc()..add(const LoadScannedUploadsEvent()),
        // ),
        // BlocProvider(
        //   create: (context) => DeleteRecentUploadsBloc(),
        // ),
        // BlocProvider(
        //   create: (context) => DetailPageBloc(),
        // ),
        BlocProvider(
          create: (context) => AuthBloc(
              authRepo: AuthRepo(authDataProvider: AuthDataProvider(dio: dio))),
        ),
        BlocProvider(
          create: (context) => ChangePasswordBloc(
              authRepo: AuthRepo(authDataProvider: AuthDataProvider(dio: dio))),
        ),
        BlocProvider(
          create: (context) => BookmarkBloc()..add(const LoadBookmarkEvent()),
        ),
        BlocProvider(
          create: (context) => RegisterationBloc(
              authRepo: AuthRepo(authDataProvider: AuthDataProvider(dio: dio))),
        ),
      ],
      child: MyApp(isLoggedIn: isLoggedIn),
    ),
  );
}

class MyApp extends StatelessWidget {
  final isLoggedIn;
  const MyApp({super.key, required this.isLoggedIn});
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ThemeBloc, ThemeState>(builder: (context, st) {
      return MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Platform X',
        home: BlocConsumer<CheckAuthBloc, CheckAuthStates>(
            listener: (context, checkAuthState) {
              if (checkAuthState is CheckAuthFailedState) {
                BlocProvider.of<AuthBloc>(context).add(TestLoginEvent());
              }
            },
            builder: (context, checkAuthState) {
          return checkAuthState is CheckAuthSuccessState ||
                  isLoggedIn && checkAuthState is LoadingCheckAuthState
              ? const MainScreen()
              : const WelcomeScreen();
        }),
        darkTheme: darkTheme,
        theme: lightTheme,
        themeMode: st is DarkThemeState ? ThemeMode.dark : ThemeMode.light,
      );
    });
  }
}