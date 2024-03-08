class MilkRecord {
  final String animalIdentificationNumber;
  final String milkingShift;
  final double milkQuantity;
  final String abnormalMilk;
  final String remarks;

  MilkRecord({
    required this.animalIdentificationNumber,
    required this.milkingShift,
    required this.milkQuantity,
    required this.abnormalMilk,
    required this.remarks,
  });

  Map<String, dynamic> toJson() {
    return {
      'animalIdentificationNumber': animalIdentificationNumber,
      'milkingShift': milkingShift,
      'milkQuantity': milkQuantity,
      'abnormalMilk': abnormalMilk,
      'remarks': remarks,
    };
  }
}
