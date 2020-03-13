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
      'gainsLogBook': 'Gains Log Book',
      'signIn' : 'Sign in',
      'email' : 'Email',
      'password' : 'Password',
      'typeValidEmail' : 'Please type an valid email',
      'invalidPassword' : 'The password must be above 6 characters',
      'welcome' : 'Welcome',
      'chosenExercises' : 'Session Overview:',
      'dbExerciseList' : 'exercises',
    },
    'dk': {
      'gainsLogBook': 'Trænings App',
    },
    
  };

  static String getLocale(BuildContext context) {
    return Localizations.localeOf(context).toString();
  }
  String get dbExerciseList {
    return _localizedValues[locale.languageCode]['dbExerciseList'];
  }
  
  String get gainsLogBook {
    return _localizedValues[locale.languageCode]['gainsLogBook'];
  }

  String get signIn {
    return _localizedValues[locale.languageCode]['signIn'];
  }

  String get email {
    return _localizedValues[locale.languageCode]['email'];
  }

  String get password {
    return _localizedValues[locale.languageCode]['password'];
  }

  String get typeValidEmail {
    return _localizedValues[locale.languageCode]['typeValidEmail'];
  }

  String get invalidPassword {
    return _localizedValues[locale.languageCode]['invalidPassword'];
  }

  String get welcome {
    return _localizedValues[locale.languageCode]['welcome'];
  }

  String get chosenExercises {
    return _localizedValues[locale.languageCode]['chosenExercises'];
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
