import 'package:baby_guard/blocs/theme/theme_bloc.dart';
import 'package:baby_guard/blocs/theme/theme_event.dart';
import 'package:baby_guard/blocs/theme/theme_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ThemeExpansionTile extends StatefulWidget {
  const ThemeExpansionTile({super.key});

  @override
  State<ThemeExpansionTile> createState() => _ThemeExpansionTileState();
}

class _ThemeExpansionTileState extends State<ThemeExpansionTile> {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ThemeBloc, ThemeState>(
      builder: (context, state) {
        return ExpansionTile(
          title: const Text('Tema'),
          children: [
            RadioListTile<ThemeMode>(
              groupValue: state.themeMode,
              value: ThemeMode.system,
              title: const Text('Sistema'),
              onChanged: (value) {
                if (value == null) {
                  return;
                }

                BlocProvider.of<ThemeBloc>(context)
                    .add(SetThemeEvent(themeMode: value));
              },
            ),
            RadioListTile<ThemeMode>(
              groupValue: state.themeMode,
              value: ThemeMode.dark,
              title: const Text('Escuro'),
              onChanged: (value) {
                if (value == null) {
                  return;
                }

                BlocProvider.of<ThemeBloc>(context)
                    .add(SetThemeEvent(themeMode: value));
              },
            ),
            RadioListTile<ThemeMode>(
              groupValue: state.themeMode,
              value: ThemeMode.light,
              title: const Text('Claro'),
              onChanged: (value) {
                if (value == null) {
                  return;
                }

                BlocProvider.of<ThemeBloc>(context)
                    .add(SetThemeEvent(themeMode: value));
              },
            ),
          ],
        );
      },
    );
  }
}
