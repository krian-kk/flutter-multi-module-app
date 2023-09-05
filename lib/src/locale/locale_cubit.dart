import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:meta/meta.dart';
import 'package:origa/languages/app_locale_constant.dart';

part 'locale_state.dart';

class LocaleCubit extends Cubit<LocaleState> {
  LocaleCubit() : super(SelectedLocale(const Locale('en')));

  void changeLang(String langCode) async {
    final Locale _locale = await setLocale(langCode);
    emit(SelectedLocale(_locale));
  }
}
