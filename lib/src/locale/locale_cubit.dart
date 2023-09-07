import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:languages/app_locale_constant.dart';

part 'locale_state.dart';

class LocaleCubit extends Cubit<LocaleState> {
  LocaleCubit() : super(const SelectedLocale(Locale('en')));

  Future<void> changeLang(String langCode) async {
    final Locale locale = await setLocale(langCode);
    emit(SelectedLocale(locale));
  }
}
