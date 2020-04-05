import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:training_app/backend/login_page.dart';
import 'localization/localization.dart';

void main() => runApp(InitApp());

class InitApp extends StatelessWidget {

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      onGenerateTitle: (BuildContext context) => AppLocalizations.of(context).gainsLogBook,
      localizationsDelegates: [
        const AppLocalizationsDelegate(), 
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
      ],
      supportedLocales: [
        const Locale('en', ''),
        const Locale('dk', ''),
      ],
      theme: ThemeData(
        primaryColor: Colors.blueAccent[300],
      ),
      //TODO: add login navigation here if the user is already logged in on device.
      home: LoginPage(),
      //home: AddExercisesPage(title: 'No user login',),
      
    );
  }

  
}



