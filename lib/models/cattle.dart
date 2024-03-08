class Cattle {
  final String userId;
  final String animalName;
  final String animalId;
  final int numberOfChilds;
  final String animalType;
  final String breed;
  final String animalGender;
  final String DOB;
  final double animalGirth;
  final double weight;
  final String pregnancyStatus;
  final String lastCalving;
  final String lastDateOfAutoInsemination;
  final int lactationNumber;
  final String currentMilkingStage;

  Cattle({
    required this.userId,
    required this.animalName,
    required this.animalId,
    required this.numberOfChilds,
    required this.animalType,
    required this.breed,
    required this.animalGender,
    required this.DOB,
    required this.animalGirth,
    required this.weight,
    required this.pregnancyStatus,
    required this.lastCalving,
    required this.lastDateOfAutoInsemination,
    required this.lactationNumber,
    required this.currentMilkingStage,
  });

  Map<String, dynamic> toJson() {
    return {
      "userId": userId,
      "animalName": animalName,
      "animalId": animalId,
      "numberOfChilds": numberOfChilds,
      "animalType": animalType,
      "breed": breed,
      "animalGender": animalGender,
      "DOB": DOB,
      "animalGirth": animalGirth,
      "weight": weight,
      "pregnancyStatus": pregnancyStatus,
      "lastCalving": lastCalving,
      "lastDateOfAutoInsemination": lastDateOfAutoInsemination,
      "lactationNumber": lactationNumber,
      "currentMilkingStage": currentMilkingStage,
    };
  }
}
