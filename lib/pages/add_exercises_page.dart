import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:training_app/localization/localization.dart';
import 'package:training_app/training_utility/exercise.dart';

class AddExercisesPage extends StatefulWidget {
  AddExercisesPage({
    Key key,
    this.title,
    this.signedInUser,
  }) : super(key: key);

  final String title;
  final FirebaseUser signedInUser;
  final String tempExercisePic = 'https://i.imgur.com/I5nZbhZ.jpg';

  @override
  _AddExercisesState createState() => _AddExercisesState();
}

class _AddExercisesState extends State<AddExercisesPage> {
  final db = Firestore.instance;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('Welcome, ${_stripNameofEmail()}'),
          actions: <Widget>[
            IconButton(
                icon: Icon(Icons.list),
                onPressed: _pushChosenExercises),
          ],
        ),
        body: StreamBuilder<QuerySnapshot>(
          stream: db
              .collection(AppLocalizations.of(context).dbExerciseList)
              .orderBy("name")
              .snapshots(),
          builder: (context, snapshot) {
            if (snapshot.hasData && snapshot.data.documents.length > 0) {
              return _buildExerciseSuggestions(snapshot.data.documents);
            } else {
              // TODO: Make an proper error. Navigate to some error screen!
              // as of now, 07.04.2020, this will sometimes display when loading the initial data retrieval.
              // du kan måske lave en ny page der så poppes når at data retrieval er færdig.
              return SizedBox(
                child: Text(
                  'Could not find any data on database: \n ${AppLocalizations.of(context).dbExerciseList}',
                  style: TextStyle(fontSize: 20),
                ),
              );
            }
          },
        ));
  }

  String _stripNameofEmail() {
    return widget.signedInUser.email.substring(0, widget.signedInUser.email.indexOf('@'));
  }

  void _pushChosenExercises() {
    Navigator.of(context).push(
      MaterialPageRoute<void>(
        builder: (BuildContext context) {
          final Iterable<ListTile> tiles = _chosenExercises.map(
            (Exercise exercise) {
              return ListTile(
                leading: CircleAvatar(backgroundImage: NetworkImage(widget.tempExercisePic)),
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
              title: Text('${AppLocalizations.of(context).chosenExercises} ${_getDateAndMonth()}'),
            ),
            body: ListView(children: divided),
          );
        },
      ),
    );
  }

  String _getDateAndMonth() {
    return '${DateTime.now().day.toString()}/${DateTime.now().month}';
  }

  final Set<Exercise> _chosenExercises = Set<Exercise>();
  final TextStyle _biggerFont = const TextStyle(fontSize: 18);

  Widget _buildExerciseSuggestions(List<DocumentSnapshot> _documentSnapshots) {
    return ListView.builder(
        // padding for an individual tile
        padding: const EdgeInsets.fromLTRB(0, 8, 8, 8),
        itemCount: _documentSnapshots.length,
        itemBuilder: (BuildContext _context, int i) {
          return _buildRow(_documentSnapshots[i]);
        });
  }

  Widget _buildRow(DocumentSnapshot snapshot) {
    Exercise exercise = Exercise.fromDatabase(snapshot, 'name');
    final bool isExerciseAlreadySaved = _chosenExercises.contains(exercise);

    return ListTile(
      // TODO: Add leading icon here which indicates muscle groups. Ex Leading: Iocns(Icons.<CUSTOMI_ICON>)
      leading: CircleAvatar(backgroundImage: NetworkImage(widget.tempExercisePic)),
      // main text on tile
      title: Text(
        exercise.name,
        style: _biggerFont,
      ),
      // trailing icon for chosen exercises
      trailing: Icon(
        isExerciseAlreadySaved ? Icons.check : Icons.add,
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
      // Makes the tile more compact.
      dense: true,
    );
  }
}
