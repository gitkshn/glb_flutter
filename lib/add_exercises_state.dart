import 'package:flutter/material.dart';
import 'training_utility/exercise.dart';
import 'training_utility/exercise_list.dart';

//TODO: rename homepage to something more relatable
class HomePage extends StatefulWidget {
  HomePage({Key key, this.title}) : super(key: key);

  final String title;

  @override
  AddExercisesState createState() => AddExercisesState();
}

class AddExercisesState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Add your exercises'),
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
              title: Text('Chosen Exercises ' +
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
