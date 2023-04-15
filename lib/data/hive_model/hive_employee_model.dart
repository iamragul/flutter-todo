import 'package:hive/hive.dart';

part 'hive_employee_model.g.dart';

@HiveType(typeId: 0)
class HiveEmployeeModel extends HiveObject {
  @HiveField(0)
  late String name;

  @HiveField(1)
  late String role;

  @HiveField(2)
  late String fromDate;

  @HiveField(3)
  late String toDate;

  HiveEmployeeModel(
      {required this.name,
      required this.role,
      required this.fromDate,
      required this.toDate});
}
