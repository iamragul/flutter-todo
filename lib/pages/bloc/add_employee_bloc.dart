import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:rti_task/data/local/hive_storage.dart';

part 'add_employee_event.dart';
part 'add_employee_state.dart';

class AddEmployeeBloc extends Bloc<AddEmployeeEvent, AddEmployeeState> {
  final HiveStorage _hiveStorage = HiveStorage();
  AddEmployeeBloc() : super(AddEmployeeInitial()) {
    on<AddEmployeeSubmit>(_onAddEmployee);
  }

  Future<void> _onAddEmployee(
      AddEmployeeSubmit event, Emitter<AddEmployeeState> emit) async {
    emit(AddEmployeeLoading());
    var addEmp = await _hiveStorage.addEmployeeDetails(
        name: event.name,
        role: event.role,
        fromDate: event.fromDate,
        toDate: event.toDate);

    if (addEmp) {
      emit(AddEmployeeSuccess());
    } else {
      emit(const AddEmployeeFailed(error: 'unknown error occured'));
    }
  }
}
