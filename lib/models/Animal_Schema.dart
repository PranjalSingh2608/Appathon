class AnimalSchema {
  String userId;
  String animalName;
  String animalId;
  int numberOfChilds;
  String animalType;
  String breed;
  String animalGender;
  DateTime DOB;
  int age;
  double animalGirth;
  double weight;
  String pregnancyStatus;
  DateTime lastCalving;
  DateTime lastDateOfAutoInsemination;
  int lactationNumber;
  String currentMilkingStage;

  AnimalSchema({
    required this.userId,
    required this.animalName,
    required this.animalId,
    required this.numberOfChilds,
    required this.animalType,
    required this.breed,
    required this.animalGender,
    required this.DOB,
    required this.age,
    required this.animalGirth,
    required this.weight,
    required this.pregnancyStatus,
    required this.lastCalving,
    required this.lastDateOfAutoInsemination,
    required this.lactationNumber,
    required this.currentMilkingStage,
  });

  factory AnimalSchema.fromJson(Map<String, dynamic> json) {
    return AnimalSchema(
      userId: json['userId'],
      animalName: json['animalName'],
      animalId: json['animalId'],
      numberOfChilds: json['numberOfChilds'],
      animalType: json['animalType'],
      breed: json['breed'],
      animalGender: json['animalGender'],
      DOB: DateTime.parse(json['DOB']),
      age: json['age'],
      animalGirth: (json['animalGirth'] as num).toDouble(),
      weight: (json['weight'] as num).toDouble(),
      pregnancyStatus: json['pregnancyStatus'],
      lastCalving: DateTime.parse(json['lastCalving']),
      lastDateOfAutoInsemination:
          DateTime.parse(json['lastDateOfAutoInsemination']),
      lactationNumber: json['lactationNumber'],
      currentMilkingStage: json['currentMilkingStage'],
    );
  }
}
