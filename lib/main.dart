import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:training_app/backend/login_page.dart';
import 'localization/localization.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      onGenerateTitle: (BuildContext context) => AppLocalizations.of(context).appBarTitle,
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
      //this is the normal code for adding an exercise, might have to refactor name
      //home: HomePage(),
      home: LoginPage(),
    );
  }
}



