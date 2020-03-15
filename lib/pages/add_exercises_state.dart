import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:training_app/localization/localization.dart';
import 'package:training_app/training_utility/exercise.dart';
import 'package:training_app/training_utility/exercise_list.dart';


class AddExercisesPage extends StatefulWidget {
  AddExercisesPage({Key key, this.title, this.signedInUser}) : super(key: key);

  final String title;
  final FirebaseUser signedInUser;

  @override
  _AddExercisesState createState() => _AddExercisesState();
}



class _AddExercisesState extends State<AddExercisesPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
        actions: <Widget>[
          IconButton(
              //the "next" icon
              icon: Icon(Icons.send),
              onPressed: _pushChosenExercises),
        ],
      ),
      body: _buildExerciseSuggestions(),
    );
  }

  void _pushChosenExercises() {
    Navigator.of(context).push(
      MaterialPageRoute<void>(
        builder: (BuildContext context) {
          final Iterable<ListTile> tiles = _chosenExercises.map(
            (Exercise exercise) {
              return ListTile(
                title: Text(
                  exercise.name,
                  style: _biggerFont,
                ),
              );
            },
          );
          final List<Widget> divided = ListTile.divideTiles(
            context: context,
            tiles: tiles,
          ).toList();

          return Scaffold(
            appBar: AppBar(
              title: Text(AppLocalizations.of(context).chosenExercises +
                  ' ' +
                  DateTime.now().day.toString() +
                  '/' +
                  DateTime.now().month.toString()),
            ),
            body: ListView(children: divided),
          );
        },
      ),
    );
  }

  
  final Set<Exercise> _chosenExercises = Set<Exercise>();
  final TextStyle _biggerFont = const TextStyle(fontSize: 18);
  //her retriever vi hardcoded data
  static ExerciseList exerciseList = new ExerciseList();
  final List<Exercise> _exerciseSuggestions = exerciseList.getExercises();

  Widget _buildExerciseSuggestions() {
    return ListView.builder(
        //padding for an individual tile
        padding: const EdgeInsets.fromLTRB(0, 8, 8, 8),
        itemCount: _exerciseSuggestions.length,
        itemBuilder: (BuildContext _context, int i) {
          return _buildRow(_exerciseSuggestions[i]);
        });
  }

  Widget _buildRow(Exercise exercise) {
    final bool isExerciseAlreadySaved = _chosenExercises.contains(exercise);
    return ListTile(
      //TODO: Add leading icon here which indicates muscle groups. Ex Leading: Iocns(Icons.<CUSTOMI_ICON>)
      //https://medium.com/@suragch/a-complete-guide-to-flutters-listtile-597a20a3d449
      //main tekst på tile
      title: Text(
        exercise.name,
        style: _biggerFont,
      ),
      //icon der kommer efter tekst
      trailing: Icon(
        isExerciseAlreadySaved ? Icons.check : Icons.add_box,
        color: isExerciseAlreadySaved ? Colors.red : null,
      ),
      onTap: () {
        setState(() {
          if (isExerciseAlreadySaved) {
            _chosenExercises.remove(exercise);
          } else {
            _chosenExercises.add(exercise);
          }
        });
      },
      //Makes the tile more compact.
      dense: true,
    );
  }
}
