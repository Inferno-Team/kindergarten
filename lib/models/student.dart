class Student {
  final int id;
  final String name;
  final String levelName;
  final String divisionName;
  final String gender;

  Student(
      {required this.id,
      required this.name,
      required this.levelName,
      required this.divisionName,
      required this.gender});

  factory Student.fromJson(dynamic json) {
    var id = json['id'] ?? -1;
    var name = json['name'] ?? "";
    var gender = json['gender'] ?? "";
    var levelName = json['level_Name'] ?? "";
    var divisionName = json['division_Name'] ?? "";

    return Student(
        id: id,
        name: name,
        gender: gender,
        levelName: levelName,
        divisionName: divisionName);
  }
}
