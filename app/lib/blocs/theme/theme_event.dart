import 'package:flutter/material.dart';

abstract class ThemeEvent {}

class LoadThemeEvent extends ThemeEvent {}

class SetThemeEvent extends ThemeEvent {
  SetThemeEvent({required this.themeMode});

  final ThemeMode themeMode;
}
