import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart' show SynchronousFuture;

class AppLocalizations {
  AppLocalizations({
    this.locale,
  });

  final Locale locale;

  static AppLocalizations of(BuildContext buildContext) {
    return Localizations.of<AppLocalizations>(buildContext, AppLocalizations);
  }

  static Map<String, Map<String, String>> _localizedValues = {
    'en': {
      'AppBarTitle': 'Training App',
      'testTitle': 'Længere training app name',
    },
    'dk': {
      'AppBarTitle': 'Trænings App',
    },
    
  };

  String get appBarTitle {
    return _localizedValues[locale.languageCode]['AppBarTitle'];
  }

  String get testTitle {
    return _localizedValues[locale.languageCode]['testTitle'];
  }

  static String getLocale(BuildContext context) {
    return Localizations.localeOf(context).toString();
  }
}

class AppLocalizationsDelegate extends LocalizationsDelegate<AppLocalizations> {
  const AppLocalizationsDelegate();

  @override
  bool isSupported(Locale locale) => ['en', 'dk'].contains(locale.languageCode);


  @override
  Future<AppLocalizations> load(Locale locale) {
    return SynchronousFuture<AppLocalizations>(AppLocalizations(locale: locale));   //evt. slet locale:
  }

  @override
  bool shouldReload(LocalizationsDelegate<AppLocalizations> old) => false;
}
