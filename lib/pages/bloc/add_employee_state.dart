part of 'add_employee_bloc.dart';

abstract class AddEmployeeState extends Equatable {
  const AddEmployeeState();

  @override
  List<Object> get props => [];
}

class AddEmployeeInitial extends AddEmployeeState {}

class AddEmployeeLoading extends AddEmployeeState {}

class AddEmployeeSuccess extends AddEmployeeState {}

class AddEmployeeFailed extends AddEmployeeState {
  final String error;

  const AddEmployeeFailed({required this.error});

  @override
  List<Object> get props => [error];
}
