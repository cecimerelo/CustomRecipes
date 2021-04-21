import 'package:hive/hive.dart';

part 'step.g.dart';

@HiveType(typeId: 1)
class Step {
  @HiveField(0)
  final int stepNumber;
  @HiveField(1)
  final String stepDescription;

  Step(this.stepNumber, this.stepDescription);
}