import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'localization/localization.dart';

import 'package:training_app/add_exercises_state.dart';
import 'package:training_app/training_utility/exercise.dart';
import 'package:training_app/training_utility/exercise_list.dart';

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
      home: HomePage(),
    );
  }
}

class HomePage extends StatefulWidget {
  HomePage({Key key, this.title}) : super(key: key);

  final String title;

  @override
  AddExercisesState createState() => AddExercisesState();
  
}

