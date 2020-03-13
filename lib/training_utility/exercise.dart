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

  Exercise.fromDatabase(DocumentSnapshot snapshot, String fieldInDoc):
    name = snapshot.data[fieldInDoc];

  // EQUALS OVERRIDE, only compares on name! add others as needed
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
