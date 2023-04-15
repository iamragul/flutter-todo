import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:rti_task/data/local/hive_storage.dart';

part 'edit_employee_event.dart';
part 'edit_employee_state.dart';

class EditEmployeeBloc extends Bloc<EditEmployeeEvent, EditEmployeeState> {
  final HiveStorage _hiveStorage = HiveStorage();

  EditEmployeeBloc() : super(EditEmployeeInitial()) {
    on<EditEmployeeSubmit>(_onEditEmployee);
  }

  Future<void> _onEditEmployee(
      EditEmployeeSubmit event, Emitter<EditEmployeeState> emit) async {
    emit(EditEmployeeLoading());
    var addEmp = await _hiveStorage.updateEmployeeDetails(
        index: event.index,
        name: event.name,
        role: event.role,
        fromDate: event.fromDate,
        toDate: event.toDate);

    if (addEmp) {
      emit(EditEmployeeSuccess());
    } else {
      emit(const EditEmployeeFailed(error: 'unknown error occured'));
    }
  }
}
