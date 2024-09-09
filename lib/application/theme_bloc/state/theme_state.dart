import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';

abstract class ThemeState extends Equatable {
  Color _whiteColor = Colors.white;
  Color _blackColor = Colors.black;
  Color _detailPageTextColor = const Color(0xFF2C2C2C);

  Color get whiteColor => _whiteColor;
  Color get blackColor => _blackColor;
  Color get detailPageTextColor => _detailPageTextColor;

  set whiteColor(Color color) {
    _whiteColor = color;
  }

  set blackColor(Color color) {
    _blackColor = color;
  }

  set detailPageTextColor(Color color) {
    _detailPageTextColor = color;
  }

  ThemeState();
}

class InitialThemeState extends ThemeState {
  @override
  Color whiteColor = Colors.white;
  @override
  final blackColor = Colors.black;
  @override
  final detailPageTextColor = const Color(0xFF2C2C2C);
  @override
  List<Object?> get props => [];
}

class DarkThemeState extends ThemeState {
  @override
  final whiteColor = const Color(0xFF121212);
  @override
  final blackColor = Colors.white;
  @override
  final detailPageTextColor = const Color(0xFF2C2C2C);

  final double defaultPadding = 16.0;

  @override
  List<Object?> get props => [];
}

class LightThemeState extends ThemeState {
  @override
  final whiteColor = Colors.white;
  @override
  final blackColor = Colors.black;
  @override
  final detailPageTextColor = const Color(0xFF2C2C2C);

  @override
  List<Object?> get props => [];
}
