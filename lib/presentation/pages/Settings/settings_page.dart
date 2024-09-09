import 'package:flutter/cupertino.dart';

import '../../../services/signout.dart';
import 'setting_page_imports.dart';

class SettingsPage extends StatefulWidget {
  const SettingsPage({super.key});

  @override
  _SettingsPageState createState() => _SettingsPageState();
}

class _SettingsPageState extends State<SettingsPage> {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ThemeBloc, ThemeState>(builder: (contexts, _) {
      return BlocBuilder<CheckAuthBloc, CheckAuthStates>(
          builder: (contexts, checkAuthst) {
        if (checkAuthst is CheckAuthSuccessState) {
          return Scaffold(
            appBar: AppBar(
              backgroundColor: Theme.of(context).scaffoldBackgroundColor,
              elevation: 0,
              centerTitle: true,
              leading: null,
              title: Text(
                "Settings",
                style: TextStyle(
                    fontSize: 25,
                    fontWeight: FontWeight.w500,
                    color:
                        BlocProvider.of<ThemeBloc>(context).state.blackColor),
              ),
            ),
            body: Container(
              padding: const EdgeInsets.only(left: 16, top: 1, right: 16),
              child: ListView(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Row(
                        children: [
                          const CircleAvatar(
                            radius: 40,
                            backgroundColor: kPrimaryColor,
                            child: Center(
                              child: Icon(
                                Icons.person,
                                color: Colors.white,
                                size: 50,
                              ),
                            ),
                          ),
                          const SizedBox(
                            width: 12,
                          ),
                          Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                checkAuthst.name,
                                style: TextStyle(
                                    fontSize: 20,
                                    fontWeight: FontWeight.bold,
                                    color: BlocProvider.of<ThemeBloc>(context)
                                        .state
                                        .blackColor),
                              ),
                              Text(
                                checkAuthst.email,
                                style: TextStyle(
                                  color: BlocProvider.of<ThemeBloc>(context)
                                      .state
                                      .blackColor,
                                  fontSize: 15,
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                      InkWell(
                        onTap: () {
                          BlocProvider.of<ThemeBloc>(context)
                              .add(const ChangeThemeEvent());
                        },
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: BlocProvider.of<ThemeBloc>(context).state
                                  is DarkThemeState
                              ? const Icon(Icons.light_mode,
                                  color: kPrimaryColor, size: 40)
                              : Icon(Icons.dark_mode,
                                  color: BlocProvider.of<ThemeBloc>(context)
                                      .state
                                      .blackColor,
                                  size: 40),
                        ),
                      )
                    ],
                  ),
                  const SizedBox(
                    height: 25,
                  ),
                  Text("Account Settings",
                      style: TextStyle(
                          fontSize: 20,
                          color: BlocProvider.of<ThemeBloc>(context)
                                      .state
                                      .blackColor ==
                                  Colors.white
                              ? const Color.fromARGB(255, 197, 196, 196)
                              : BlocProvider.of<ThemeBloc>(context)
                                  .state
                                  .blackColor)),
                  Divider(
                    height: 10,
                    thickness: 2,
                    color:
                        BlocProvider.of<ThemeBloc>(context).state.blackColor ==
                                Colors.white
                            ? greyColor[600]
                            : greyColor[300],
                  ),
                  const SizedBox(
                    height: 5,
                  ),
                  buildAccountOptionRow(
                      context, "Change password", Icons.lock_outline_rounded,
                      () {
                    Navigator.of(context).push(MaterialPageRoute(
                        builder: (context) => const ResetPassword()));
                  }),
                  // buildAccountOptionRow(context, "Sync your data", Icons.sync,
                  //     () {
                  //   Navigator.of(context).push(
                  //     MaterialPageRoute(builder: (context) => SyncDataPage()),
                  //   );
                  // }),
                  buildAccountOptionRow(context, "Sign Out", Icons.logout, () {
                    BlocProvider.of<SignOutBloc>(context)
                        .add(StartSignOutEvent());
                    signOut(context);
                    Navigator.of(context).pushAndRemoveUntil(
                        MaterialPageRoute(
                            builder: (context) => const WelcomeScreen()),
                        (route) => false);
                  }),
                  const SizedBox(
                    height: 15,
                  ),
                  Text("More Settings",
                      style: TextStyle(
                          fontSize: 20,
                          color: BlocProvider.of<ThemeBloc>(context)
                                      .state
                                      .blackColor ==
                                  Colors.white
                              ? const Color.fromARGB(255, 197, 196, 196)
                              : BlocProvider.of<ThemeBloc>(context)
                                  .state
                                  .blackColor)),
                  Divider(
                    height: 10,
                    thickness: 2,
                    color:
                        BlocProvider.of<ThemeBloc>(context).state.blackColor ==
                                Colors.white
                            ? greyColor[600]
                            : greyColor[300],
                  ),
                  const SizedBox(
                    height: 5,
                  ),
                  buildAccountOptionRow(context, "Give Us Feedback",
                      Icons.feedback_outlined, showFeedbackDialog(context)),
                  buildAccountOptionRow(
                      context, "About Us", Icons.info_outline_rounded, () {
                    Navigator.of(context)
                        .push(MaterialPageRoute(builder: (context) => const About()));
                  }),
                  buildAccountOptionRow(
                      context, "Terms And Conditions", Icons.list_alt_sharp,
                      () {
                    TermsAndConditions(context);
                  }),
                  buildAccountOptionRow(
                      context, "Rate App", Icons.rate_review_outlined, () {
                    _openAppStore();
                  }),
                  buildAccountOptionRow(context, "Share the app", Icons.share,
                      () async {
                    ShareResult result = await Share.share(
                        'Check out this awesome app! Download it now: https://your-app-url.com');
                    if (result.raw.isNotEmpty) {
                      showThankYouDialog(context);
                    }
                  }),
                  const SizedBox(
                    height: 5,
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  const SizedBox(
                    height: 50,
                  ),
                ],
              ),
            ),
          );
        } else {
          return Container(
              child: const Center(
                  child: Text(
                      "please re install the application, report if this problem persists.")));
        }
      });
    });
  }

  buildNotificationOptionRow(String title, bool isActive) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 10.0, vertical: 5),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            title,
            style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.w500,
                color: BlocProvider.of<ThemeBloc>(context).state.blackColor),
          ),
          Transform.scale(
              scale: 0.7,
              child: CupertinoSwitch(
                value: isActive,
                onChanged: (bool val) {},
              ))
        ],
      ),
    );
  }

  void _openAppStore() async {
    if (Platform.isAndroid) {
      final url = Uri(
          scheme: 'https',
          host: 'play.google.com',
          path: 'store/apps/details',
          queryParameters: {"id": "your.app.package"});
      if (await canLaunchUrl(url)) {
        await launchUrl(url, mode: LaunchMode.externalApplication);
      }
    } else if (Platform.isIOS) {
      final url = Uri(
        scheme: 'https',
        host: 'itunes.apple.com',
        path: 'app/your-app-name/idyourappid',
      );
      if (await canLaunchUrl(url)) {
        await launchUrl(url, mode: LaunchMode.externalApplication);
      } else {
        throw 'Could not launch $url';
      }
    } else {
      final url = Uri(
        scheme: 'https',
        host: 'itunes.apple.com',
        path: 'app/your-app-name/idyourappid',
      );
      if (await canLaunchUrl(url)) {
        await launchUrl(url, mode: LaunchMode.externalApplication);
      } else {
        throw 'Could not launch $url';
      }
    }
  }

  showFeedbackDialog(context) => () {
        showDialog(
            context: context,
            barrierDismissible: false,
            builder: (BuildContext context) {
              return FeedBack();
            });
      };
  GestureDetector buildAccountOptionRow(
      BuildContext context, String title, IconData icon, Function()? ontap) {
    return GestureDetector(
      onTap: ontap,
      child: ListTile(
        leading: Icon(icon, color: kPrimaryColor),
        title: Text(
          title,
          style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.w500,
              color: BlocProvider.of<ThemeBloc>(context).state.blackColor ==
                      Colors.white
                  ? const Color.fromARGB(255, 197, 196, 196)
                  : BlocProvider.of<ThemeBloc>(context).state.blackColor),
        ),
      ),
    );
  }
}
