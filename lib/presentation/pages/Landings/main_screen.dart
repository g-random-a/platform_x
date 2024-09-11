import '../stat/stat_screen.dart';
import 'main_screen_imports.dart';
import 'package:iconsax/iconsax.dart';

class MainScreen extends StatefulWidget {
  const MainScreen({super.key});

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  int currentTab = 1;
  final List<Widget> screens = [
    HomePage(),
    // SyncDataPage(),
    BookmarkPage(),
    StatPage(),
    SettingsPage(),

  ];

  final PageStorageBucket bucket = PageStorageBucket();

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: BlocListener<ThemeBloc, ThemeState>(
        listener: (context, CheckAuthst) {
            if (CheckAuthst is! CheckAuthSuccessState) {
              Navigator.of(context).pushAndRemoveUntil(
                  MaterialPageRoute(builder: (context) => const WelcomeScreen()),
                  (route) => false);
            }
          },
        child: BlocConsumer<CheckAuthBloc, CheckAuthStates>(
              listener: (context, CheckAuthst) {
            if (CheckAuthst is! CheckAuthSuccessState) {
              Navigator.of(context).pushAndRemoveUntil(
                  MaterialPageRoute(builder: (context) => const WelcomeScreen()),
                  (route) => false);
            }
          }, builder: (context, CheckAuthst) {
            if (CheckAuthst is CheckAuthSuccessState) {
              return LoaderOverlay(
                overlayColor:
                    BlocProvider.of<ThemeBloc>(context).state.blackColor,
                useDefaultLoading: false,
                overlayWidgetBuilder: (context) => Builder(
                  builder: (BuildContext context) => const SpinKitPulsingGrid(
                    color: kPrimaryColor,
                    size: 100.0,
                  ),
                ),
                child: LayoutBuilder(
                  builder: (context, _) => Scaffold(
                    drawerEnableOpenDragGesture: false,
                    body: PageStorage(
                        bucket: bucket, child: screens[currentTab - 1]),
                    appBar: currentTab != 1
                        ? null
                        : getAppBar(context, CheckAuthst.name),
                    
                    bottomNavigationBar: BottomAppBar(
                      elevation: 10,
                      shadowColor: BlocProvider.of<ThemeBloc>(context)
                          .state
                          .blackColor,
                      color: BlocProvider.of<ThemeBloc>(context)
                          .state
                          .whiteColor,
                      clipBehavior: Clip.hardEdge,
                      padding: const EdgeInsets.all(0),
                      height: 45,
                      child: Row(
                        mainAxisAlignment:
                            MainAxisAlignment.spaceEvenly,
                        children: <Widget>[
                          IconButton(
                            padding: const EdgeInsets.all(0),
                            tooltip: "Home",
                            onPressed: () {
                              setState(() {
                                currentTab = 1;
                              });
                            },
                            icon: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Icon(currentTab == 1 ? Iconsax.home1 : Iconsax.home,
                                    color: currentTab == 1
                                        ? kPrimaryColor
                                        : BlocProvider.of<ThemeBloc>(
                                                context)
                                            .state
                                            .blackColor,
                                      size: 20,),
                                            Text(
                            "Home",
                            style: TextStyle(
                                color: currentTab == 1
                                    ? kSecondaryColor
                                    : BlocProvider.of<ThemeBloc>(
                                            context)
                                        .state
                                        .blackColor,
                                        fontSize: 10),
                          ),
                              ],
                            ),
                          ),
                          
                          IconButton(
                            padding: const EdgeInsets.all(0),
                            tooltip: "Favorites",
                            onPressed: () {
                              BlocProvider.of<BookmarkBloc>(context)
                                  .add(const LoadBookmarkEvent());
                              setState(() {
                                currentTab = 2;
                              });
                            },
                            icon: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Icon(
                                  currentTab == 2 ? Iconsax.heart5 : Iconsax.heart,
                                  color: currentTab == 2
                                      ? kPrimaryColor
                                      : BlocProvider.of<ThemeBloc>(context)
                                          .state
                                          .blackColor,
                                          size: 20
                                ),
                                Text(
                                "Favorites",
                                style: TextStyle(
                                    color: currentTab == 2
                                        ? kSecondaryColor
                                        : BlocProvider.of<ThemeBloc>(
                                                context)
                                            .state
                                            .blackColor,
                                            fontSize: 10),
                                )
                              ],
                            ),
                          ),
                          
                                          
                          IconButton(
                            padding: EdgeInsets.all(0),
                            tooltip: "Stat",
                            onPressed: () {
                              BlocProvider.of<BookmarkBloc>(context)
                                  .add(const LoadBookmarkEvent());
                              setState(() {
                                currentTab = 3;
                              });
                            },
                            icon: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Icon(
                                  currentTab == 3 ? Iconsax.task_square5 : Iconsax.task_square,
                                  color: currentTab == 3
                                      ? kPrimaryColor
                                      : BlocProvider.of<ThemeBloc>(context)
                                          .state
                                          .blackColor,
                                size: 20
                                ),
                                Text(
                                "stat",
                                style: TextStyle(
                                    color: currentTab == 3
                                        ? kSecondaryColor
                                        : BlocProvider.of<ThemeBloc>(
                                                context)
                                            .state
                                            .blackColor,
                                            fontSize: 10),
                                )
                              ],
                            ),
                          ),
                          
                          IconButton(
                            padding: EdgeInsets.all(0),
                            tooltip: "Profile",
                            onPressed: () {
                              setState(() {
                                currentTab = 4;
                              });
                            },
                            icon: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Icon( currentTab == 4 ? Iconsax.profile_2user5 : Iconsax.profile_2user,
                                    color: currentTab == 4
                                        ? kPrimaryColor
                                        : BlocProvider.of<ThemeBloc>(
                                                context)
                                            .state
                                            .blackColor,
                                      size: 20),
                                Text(
                                "Profile",
                                style: TextStyle(
                                    color: currentTab == 4
                                        ? kSecondaryColor
                                        : BlocProvider.of<ThemeBloc>(
                                                context)
                                            .state
                                            .blackColor,
                                            fontSize: 10),
                                )
                                          
                              ],
                            ),
                          ),
                        
                        ],
                      ),
                    ),
                  ),
                ),
              );
            } else {
              return Container(
                child: const Center(
                  child: Text("Auth Error"),
                ),
              );
            }
          }),),
        
        );
  }
}
