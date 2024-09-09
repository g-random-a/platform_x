import 'package:equatable/equatable.dart';

abstract class ThemeEvent extends Equatable {
  const ThemeEvent();
}

class ChangeThemeEvent extends ThemeEvent {

  @override
  List<Object> get props => [];

  const ChangeThemeEvent();
}

class LoadThemeEvent extends ThemeEvent {

  @override
  List<Object> get props => [];

  const LoadThemeEvent();
}
