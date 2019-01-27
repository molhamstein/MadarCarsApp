import 'dart:async';
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class MadarLocalizations {
  MadarLocalizations(this.locale);

  final Locale locale;

  static MadarLocalizations of(BuildContext context) {
    return Localizations.of<MadarLocalizations>(context, MadarLocalizations);
  }

  Map<String, String> _sentences;

  Future<bool> load() async {
    String data = await rootBundle
        .loadString('assets/locale/${this.locale.languageCode}.json');
    Map<String, dynamic> _result = json.decode(data);

    this._sentences = new Map();
    _result.forEach((String key, dynamic value) {
      this._sentences[key] = value.toString();
    });

    return true;
  }

  String trans(String key) {
    return this._sentences[key];
  }
}

class MadarLocalizationsDelegate
    extends LocalizationsDelegate<MadarLocalizations> {
  const MadarLocalizationsDelegate();

  @override
  bool isSupported(Locale locale) => ['ar', 'en'].contains(locale.languageCode);

  @override
  Future<MadarLocalizations> load(Locale locale) async {
    MadarLocalizations localizations = new MadarLocalizations(locale);
    await localizations.load();

    return localizations;
  }

  @override
  bool shouldReload(MadarLocalizationsDelegate old) => true;
}
