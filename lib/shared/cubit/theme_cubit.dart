import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hive/hive.dart';

class ThemeCubit extends Cubit<ThemeMode> {
  ThemeCubit(super.initialTheme);

  void toggleTheme(bool isDark) async {
    final newTheme = isDark ? ThemeMode.dark : ThemeMode.light;
    emit(newTheme);

    final box = await Hive.openBox('settings');
    await box.put('themeMode', newTheme.index); // index of ThemeMode enum
  }
}
