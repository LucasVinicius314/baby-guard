import 'package:baby_guard/blocs/theme/theme_event.dart';
import 'package:baby_guard/blocs/theme/theme_state.dart';
import 'package:baby_guard/repositories/theme_repository.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ThemeBloc extends Bloc<ThemeEvent, ThemeState> {
  ThemeBloc({required this.themeRepository})
      : super(const ThemeState(themeMode: ThemeMode.system)) {
    on<LoadThemeEvent>((event, emit) async {
      final themeMode = await themeRepository.getTheme();

      emit(ThemeState(themeMode: themeMode));
    });

    on<SetThemeEvent>((event, emit) async {
      final themeMode = event.themeMode;

      await themeRepository.setTheme(themeMode);

      emit(ThemeState(themeMode: themeMode));
    });
  }

  final ThemeRepository themeRepository;
}
