import 'package:cloud_firestore/cloud_firestore.dart';

class Exercise {
  final String name;
  int weight;
  int reps;
  int sets;
  int weightload;

  Exercise({
    this.name,
    this.weight,
    this.reps,
    this.sets,
  });

  Exercise.fromDatabase(DocumentSnapshot snapshot):
    name = snapshot.data['name'];

  // EQUALS OVERRIDE
  // https://stackoverflow.com/questions/29567322/how-does-a-set-determine-that-two-objects-are-equal-in-dart
  @override
  bool operator ==(other) {
    if (other is! Exercise) {
      return false;
    }
    return name == (other).name;
  }

  int _hashCode;
  @override
  int get hashCode {
    if (_hashCode == null) {
      _hashCode = name.hashCode;
    }
    return _hashCode;
  }
}
