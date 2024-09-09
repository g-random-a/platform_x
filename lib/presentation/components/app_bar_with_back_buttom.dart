import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';


import '../../application/theme_bloc/bloc/theme_bloc.dart';

AppBar appBarTransparent(context) => AppBar(
      backgroundColor: Colors.transparent,
      elevation: 0,
      leading: InkWell(
        onTap: () {
          Navigator.of(context).pop();
        },
        child: Card(
          elevation: 5,
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
          color: BlocProvider.of<ThemeBloc>(context).state.whiteColor,
          child: Icon(
            Icons.chevron_left_rounded,
            size: 30,
            color: BlocProvider.of<ThemeBloc>(context).state.blackColor,
          ),
        ),
      ),
    );
