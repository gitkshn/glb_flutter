

import 'dart:convert';
import 'dart:io';
import 'dart:async';
import 'package:training_app/training_utility/exercise.dart';

class ExerciseList {
  //skal gøre private så du initter først og returnere listen via en get function
  List<Exercise> _exerciseList = new List<Exercise>();

  ExerciseList() {
    _initExerciseList();
  }

  void _initExerciseList() {
    _exerciseList.add(new Exercise(name: 'Varmup'));
    _exerciseList.add(new Exercise(name: 'Sumo Deadlift'));
    _exerciseList.add(new Exercise(name: 'Bench'));
    _exerciseList.add(new Exercise(name: 'Dips'));
    _exerciseList.add(new Exercise(name: 'Backwards Lunges'));
    _exerciseList.add(new Exercise(name: 'Deadlift'));
    _exerciseList.add(new Exercise(name: 'Tricep tov extensions'));
    _exerciseList.add(new Exercise(name: 'Chest flys'));
    _exerciseList.add(new Exercise(name: 'Bench Press'));
    _exerciseList.add(new Exercise(name: 'Pull-ups'));
  }

  List<Exercise> getExercises() {
    return _exerciseList;
  }
}