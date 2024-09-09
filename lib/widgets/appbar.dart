import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';

import '../application/auth_bloc/bloc/signOut_bloc.dart';
import '../application/auth_bloc/event/sign_out_events.dart';
import '../application/theme_bloc/bloc/theme_bloc.dart';
import '../presentation/constants.dart';
import '../presentation/pages/Welcome/welcome_screen.dart';
import '../services/signout.dart';

void _showDialog(BuildContext context) {
  showDialog(
    context: context,
    builder: (BuildContext context) {
      return AlertDialog(
        title: const Text("Alert!!"),
        content: const Text("You are awesome!"),
        actions: [
          MaterialButton(
            child: const Text("OK"),
            onPressed: () {
              Navigator.of(context).pop();
            },
          ),
        ],
      );
    },
  );
}

popupMenu(BuildContext context, String name) => PopupMenuButton<int>(
    padding: const EdgeInsets.all(0.0),
    itemBuilder: (context) => [
          PopupMenuItem(
            enabled: false,
            child: Center(
              child: Text(name,
                  style: TextStyle(
                      color: BlocProvider.of<ThemeBloc>(context)
                          .state
                          .blackColor)),
            ),
          ),
          const PopupMenuItem(
            value: 1,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(Icons.logout, color: Colors.red),
                SizedBox(
                  width: 5,
                ),
                Text("Sign out", style: TextStyle(color: Colors.red))
              ],
            ),
          ),
        ],
    color: BlocProvider.of<ThemeBloc>(context).state.whiteColor,
    elevation: 2,
    onSelected: (value) {
      if (value == 1) {
        BlocProvider.of<SignOutBloc>(context).add(StartSignOutEvent());
        signOut(context);
        Navigator.of(context).pushAndRemoveUntil(
            MaterialPageRoute(builder: (context) => const WelcomeScreen()),
            (route) => false);
      }
    },
    splashRadius: 20,
    icon:
        const Center(
      child: Center(
        child: CircleAvatar(
            backgroundColor: kPrimaryColor,
            child: Icon(Icons.person_outline_rounded, color: Colors.white)),
      ),
    ));

AppBar getAppBar(BuildContext context, String name) {
  return AppBar(
    toolbarHeight: 60,
    backgroundColor: BlocProvider.of<ThemeBloc>(context).state.whiteColor,    
    title: ShaderMask(
      shaderCallback: (Rect bounds) {
        return const LinearGradient(
          colors: [
            Color.fromARGB(188, 22, 202, 139),
            kPrimaryColor
          ], // Define your gradient colors here
          tileMode: TileMode.clamp,
        ).createShader(bounds);
      },
      child: Text(
        'Platform X',
        style: GoogleFonts.fuzzyBubbles(
          fontWeight: FontWeight.bold,
        ),
      ),
    ),
    actions: [
      IconButton(
        icon: const Icon(Icons.notifications_none),
        onPressed: () {
          // _showDialog(context);
        },
      ),
      Container(
          margin: const EdgeInsets.only(right: 10.0),
          child: popupMenu(context, name)),

    ],
  );
}
