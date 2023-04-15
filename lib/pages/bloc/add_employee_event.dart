part of 'add_employee_bloc.dart';

abstract class AddEmployeeEvent extends Equatable {
  const AddEmployeeEvent();

  @override
  List<Object> get props => [];
}

class AddEmployeeSubmit extends AddEmployeeEvent {
  final String name;
  final String role;
  final String fromDate;
  final String toDate;

  const AddEmployeeSubmit(
      {required this.name,
      required this.role,
      required this.fromDate,
      required this.toDate});
}
