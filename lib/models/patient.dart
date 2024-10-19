class Patient {
  final String name;
  final int age;
  final String condition;

  Patient({
    required this.name,
    required this.age,
    required this.condition,
  });

  Map<String, dynamic> toMap() {
    return {
      'name': name,
      'age': age,
      'condition': condition,
    };
  }
}
