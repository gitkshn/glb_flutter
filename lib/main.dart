import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:training_app/training_utility/exercise.dart';
import 'package:training_app/training_utility/exerciseList.dart';
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
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  void _pushSaved() {
    Navigator.of(context).push(
      MaterialPageRoute<void>(
        builder: (BuildContext context) {
          final Iterable<ListTile> tiles = _saved.map(
            (Exercise exercise) {
              return ListTile(
                title: Text(
                  exercise.name,
                  style: _biggerFont,
                ),
              );
            },
          );
          final List<Widget> divided = ListTile
            .divideTiles(
              context: context,
              tiles: tiles,
            )
            .toList();
            
            return Scaffold(
            appBar: AppBar(
              title: Text('Chosen Exercises ' + DateTime.now().day.toString() +'/'
              + DateTime.now().month.toString()),
              
            ),
            body: ListView(children: divided),
          );
        },
      ),
    );
  }
  static ExerciseList exerciseList = new ExerciseList(); 
  final List<Exercise> _suggestions = exerciseList.getExercises();
  final Set<Exercise> _saved = Set<Exercise>();
  final TextStyle _biggerFont = const TextStyle(fontSize: 18);

  

  void _addNewExercise() {
    setState(() {
      // This call to setState tells the Flutter framework that something has
      // changed in this State, which causes it to rerun the build method below
      // so that the display can reflect the updated values. If we changed
      // _counter without calling setState(), then the build method would not be
      // called again, and so nothing would appear to happen.
      
    });
  }

   Widget _buildSuggestions() {
    return ListView.builder(
      padding: const EdgeInsets.all(16),
      itemCount: _suggestions.length,
      itemBuilder: (BuildContext _context, int i) {
        
        return _buildRow(_suggestions[i]);
      }
    );
  }
  Widget _buildRow(Exercise exercise) {
    final bool alreadySaved = _saved.contains(exercise);
    return ListTile(
      title: Text(
        exercise.name,
        style: _biggerFont,
      ),
      trailing: Icon(
        alreadySaved ? Icons.add_box : Icons.add_box,
        color: alreadySaved ? Colors.red : null,
      ),
      onTap: () {
        setState(() {
          if (alreadySaved) {
            _saved.remove(exercise);
          } else {
            _saved.add(exercise);
          }
        });
      },
    );
  }


  @override                                 
  Widget build(BuildContext context) {
    return Scaffold (appBar: AppBar(
      title: Text('Add your exercises'),
      actions: <Widget>[
        IconButton(icon: Icon(Icons.send), onPressed: _pushSaved),
      ],
    ),
    body: _buildSuggestions(),
    );
  }
}
