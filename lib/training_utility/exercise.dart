class Exercise {
  final String name;
  final int weight;
  final int reps;
  final int sets;
  int weightload;

  Exercise({
    this.name,
    this.weight,
    this.reps,
    this.sets,

  });
   
  
  // EQUALS OVERRIDE
  // https://stackoverflow.com/questions/29567322/how-does-a-set-determine-that-two-objects-are-equal-in-dart
  @override
  bool operator==(other) {
    if(other is! Exercise) {
      return false;
    }
    return name == (other).name;
  }

  int _hashCode;
  @override
  int get hashCode {
    if(_hashCode == null) {
      _hashCode = name.hashCode;
    }
    return _hashCode;
  }
}
