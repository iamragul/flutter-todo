part of 'edit_employee_bloc.dart';

abstract class EditEmployeeEvent extends Equatable {
  const EditEmployeeEvent();

  @override
  List<Object> get props => [];
}

class EditEmployeeSubmit extends EditEmployeeEvent {
  final int index;
  final String name;
  final String role;
  final String fromDate;
  final String toDate;

  const EditEmployeeSubmit(
      {required this.index,
      required this.name,
      required this.role,
      required this.fromDate,
      required this.toDate});
}
