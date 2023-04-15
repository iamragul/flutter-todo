import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:rti_task/data/hive_model/hive_employee_model.dart';

class HiveStorage {
  Future<dynamic> addEmployeeDetails(
      {required String name,
      required String role,
      required String fromDate,
      required String toDate}) async {
    try {
      final emp = HiveEmployeeModel(
        name: name,
        role: role,
        fromDate: fromDate,
        toDate: toDate,
      );

      final box = Hive.box<HiveEmployeeModel>('employee');
      box.add(emp);
      return true;
    } catch (e) {
      debugPrint(e.toString());
      return false;
    }
  }

  Future<dynamic> updateEmployeeDetails(
      {required int index,
      required String name,
      required String role,
      required String fromDate,
      required String toDate}) async {
    try {
      final emp = HiveEmployeeModel(
        name: name,
        role: role,
        fromDate: fromDate,
        toDate: toDate,
      );

      final box = Hive.box<HiveEmployeeModel>('employee');
      box.putAt(index, emp);

      return true;
    } catch (e) {
      debugPrint(e.toString());
      return false;
    }
  }
}
