part of 'edit_employee_bloc.dart';

abstract class EditEmployeeState extends Equatable {
  const EditEmployeeState();

  @override
  List<Object> get props => [];
}

class EditEmployeeInitial extends EditEmployeeState {}

class EditEmployeeLoading extends EditEmployeeState {}

class EditEmployeeSuccess extends EditEmployeeState {}

class EditEmployeeFailed extends EditEmployeeState {
  final String error;

  const EditEmployeeFailed({required this.error});

  @override
  List<Object> get props => [error];
}
