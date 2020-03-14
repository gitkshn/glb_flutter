import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:training_app/localization/localization.dart';
import 'training_utility/exercise.dart';
import 'training_utility/exercise_list.dart';

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
        //grabs the text before the @ in the email and appends it to the title.
        title: Text(widget.title +
            " " +
            widget.signedInUser.email
                .substring(0, widget.signedInUser.email.indexOf('@'))),
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

  static ExerciseList exerciseList = new ExerciseList();
  final List<Exercise> _exerciseSuggestions = exerciseList.getExercises();
  final Set<Exercise> _chosenExercises = Set<Exercise>();
  final TextStyle _biggerFont = const TextStyle(fontSize: 18);

  Widget _buildExerciseSuggestions() {
    return ListView.builder(
        padding: const EdgeInsets.all(16),
        itemCount: _exerciseSuggestions.length,
        itemBuilder: (BuildContext _context, int i) {
          return _buildRow(_exerciseSuggestions[i]);
        });
  }

  Widget _buildRow(Exercise exercise) {
    final bool isExerciseAlreadySaved = _chosenExercises.contains(exercise);
    return ListTile(
      title: Text(
        exercise.name,
        style: _biggerFont,
      ),
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
    );
  }
}
