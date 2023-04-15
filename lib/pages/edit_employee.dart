// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:intl/intl.dart';

import 'package:rti_task/data/hive_model/hive_employee_model.dart';
import 'package:rti_task/pages/bloc/edit_employee_bloc.dart';
import 'package:rti_task/pages/custom_from_date_picker.dart';
import 'package:rti_task/pages/custom_to_date_picker.dart';
import 'package:rti_task/themes/theme.dart';

class EditEmployee extends StatelessWidget {
  final int index;
  final HiveEmployeeModel hiveEmployeeModel;
  const EditEmployee({
    Key? key,
    required this.hiveEmployeeModel,
    required this.index,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => EditEmployeeBloc(),
      child: EditEmployeePage(
        index: index,
        hiveEmployeeModel: hiveEmployeeModel,
      ),
    );
  }
}

class EditEmployeePage extends StatefulWidget {
  final int index;

  final HiveEmployeeModel hiveEmployeeModel;
  const EditEmployeePage(
      {super.key, required this.hiveEmployeeModel, required this.index});

  @override
  State<EditEmployeePage> createState() => _EditEmployeePageState();
}

class _EditEmployeePageState extends State<EditEmployeePage> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  TextEditingController name = TextEditingController();
  TextEditingController role = TextEditingController();
  TextEditingController fromDate = TextEditingController();
  TextEditingController toDate = TextEditingController();

  DateTime selectedDate = DateTime.now();

  @override
  void initState() {
    assignValues();
    super.initState();
  }

  void assignValues() {
    name = TextEditingController(text: widget.hiveEmployeeModel.name);
    role = TextEditingController(text: widget.hiveEmployeeModel.role);
    fromDate = TextEditingController(text: widget.hiveEmployeeModel.fromDate);
    toDate = TextEditingController(text: widget.hiveEmployeeModel.toDate);
  }

  @override
  void dispose() {
    name.dispose();
    role.dispose();
    fromDate.dispose();
    toDate.dispose();
    super.dispose();
  }

  void showDropDown(BuildContext context) {
    showModalBottomSheet(
        isDismissible: true,
        context: context,
        shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.vertical(
          top: Radius.circular(16.r),
        )),
        builder: (context) => Container(
              padding: EdgeInsets.symmetric(vertical: 8.h),
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.vertical(
                top: Radius.circular(16.r),
              )),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  InkWell(
                    onTap: () {
                      role.text = "Product Designer";
                      Navigator.pop(context);
                    },
                    child: Padding(
                      padding: EdgeInsets.all(8.r),
                      child: Text(
                        "Product Designer",
                        style: TextStyle(fontSize: 16.sp),
                      ),
                    ),
                  ),
                  const Divider(),
                  InkWell(
                    onTap: () {
                      role.text = "Flutter Developer";
                      Navigator.pop(context);
                    },
                    child: Padding(
                      padding: EdgeInsets.all(8.r),
                      child: Text(
                        "Flutter Developer",
                        style: TextStyle(fontSize: 16.sp),
                      ),
                    ),
                  ),
                  const Divider(),
                  InkWell(
                    onTap: () {
                      role.text = "QA Tester";
                      Navigator.pop(context);
                    },
                    child: Padding(
                      padding: EdgeInsets.all(8.r),
                      child: Text(
                        "QA Tester",
                        style: TextStyle(fontSize: 16.sp),
                      ),
                    ),
                  ),
                  const Divider(),
                  InkWell(
                    onTap: () {
                      role.text = "Product Owner";
                      Navigator.pop(context);
                    },
                    child: Padding(
                      padding: EdgeInsets.all(8.r),
                      child: Text(
                        "Product Owner",
                        style: TextStyle(fontSize: 16.sp),
                      ),
                    ),
                  ),
                ],
              ),
            ));
  }

  void submit() {
    BlocProvider.of<EditEmployeeBloc>(context).add(EditEmployeeSubmit(
        index: widget.index,
        name: name.text.trim(),
        role: role.text.trim(),
        fromDate: fromDate.text,
        toDate: toDate.text));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text("Edit Employee Details"),
        ),
        body: Padding(
            padding: EdgeInsets.symmetric(vertical: 12.h, horizontal: 12.w),
            child: Form(
              key: _formKey,
              child: Column(children: [
                nameTextField(),
                SizedBox(
                  height: 16.h,
                ),
                selectRoleTextField(),
                SizedBox(
                  height: 16.h,
                ),
                Row(
                  children: [
                    Flexible(child: fromTextField()),
                    SizedBox(
                      width: 32.w,
                      child: Padding(
                          padding: EdgeInsets.symmetric(horizontal: 8.w),
                          child: Icon(
                            Icons.arrow_forward,
                            size: 16.sp,
                            color: Colors.blue,
                          )),
                    ),
                    Flexible(child: toTextField()),
                  ],
                )
              ]),
            )),
        floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
        floatingActionButton: Row(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            TextButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                style: TextButton.styleFrom(
                  minimumSize: Size(70.w, 32.h),
                  backgroundColor: customBlueAccent,
                  foregroundColor: Colors.blue,
                  disabledForegroundColor: Colors.blueGrey[400],
                  textStyle: TextStyle(
                    color: Colors.white,
                    fontSize: 14.sp,
                    fontWeight: FontWeight.w500,
                  ),
                  padding: EdgeInsets.all(12.r),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.all(Radius.circular(6.r)),
                  ),
                ),
                child: const Text("Cancel")),
            SizedBox(
              width: 16.w,
            ),
            BlocConsumer<EditEmployeeBloc, EditEmployeeState>(
              listener: (context, state) {
                if (state is EditEmployeeSuccess) {
                  Navigator.pop(context);
                }
              },
              builder: (context, state) {
                if (state is EditEmployeeLoading) {
                  return ElevatedButton(
                      onPressed: () {},
                      style: ElevatedButton.styleFrom(
                        minimumSize: Size(70.w, 32.h),
                        textStyle: TextStyle(
                          color: Colors.white,
                          fontSize: 14.sp,
                          fontWeight: FontWeight.w500,
                        ),
                        padding: EdgeInsets.all(12.r),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.all(Radius.circular(6.r)),
                        ),
                      ),
                      child: const SizedBox(
                          height: 14,
                          width: 14,
                          child: CircularProgressIndicator(
                            color: Colors.white,
                          )));
                }
                return ElevatedButton(
                    onPressed: () {
                      if (_formKey.currentState!.validate()) {
                        submit();
                      }
                    },
                    style: ElevatedButton.styleFrom(
                      minimumSize: Size(70.w, 32.h),
                      textStyle: TextStyle(
                        color: Colors.white,
                        fontSize: 14.sp,
                        fontWeight: FontWeight.w500,
                      ),
                      padding: EdgeInsets.all(12.r),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.all(Radius.circular(6.r)),
                      ),
                    ),
                    child: const Text("Save"));
              },
            ),
            SizedBox(
              width: 16.w,
            ),
          ],
        ));
  }

  selectToDate(BuildContext context) async {
    var res = await showDialog<String>(
        context: context,
        builder: (BuildContext context) => Dialog(
              insetPadding: EdgeInsets.all(12.r),
              clipBehavior: Clip.antiAliasWithSaveLayer,
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.all(Radius.circular(16.r))),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Container(
                      width: double.infinity,
                      padding: EdgeInsets.all(14.r),
                      child: const CustomToDatePicker()),
                ],
              ),
            ));
    if (res != null) {
      toDate.text = res;
    } else {
      toDate.text = '';
    }
  }

  selectFromDate(BuildContext context) async {
    var res = await showDialog<String>(
        context: context,
        builder: (BuildContext context) => Dialog(
              insetPadding: EdgeInsets.all(12.r),
              clipBehavior: Clip.antiAliasWithSaveLayer,
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.all(Radius.circular(16.r))),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Container(
                      width: double.infinity,
                      padding: EdgeInsets.all(14.r),
                      child: const CustomDatePicker()),
                ],
              ),
            ));
    if (res != null) {
      fromDate.text = res;
    }
  }

  Widget toTextField() {
    return TextFormField(
      controller: toDate,
      readOnly: true,
      onTap: () => selectToDate(context),
      textInputAction: TextInputAction.next,
      keyboardType: TextInputType.text,
      decoration: const InputDecoration(
        hintText: 'No date',
        errorMaxLines: 2,
        prefixIcon: Icon(
          Icons.calendar_today_outlined,
          color: Colors.blue,
        ),
      ),
      style: TextStyle(fontSize: 12.sp),
      autovalidateMode: AutovalidateMode.onUserInteraction,
      validator: (val) {
        return null;
      },
    );
  }

  Widget fromTextField() {
    return TextFormField(
      controller: fromDate,
      readOnly: true,
      onTap: () => selectFromDate(context),
      textInputAction: TextInputAction.next,
      keyboardType: TextInputType.text,
      decoration: const InputDecoration(
        hintText: 'No date',
        errorMaxLines: 2,
        prefixIcon: Icon(
          Icons.calendar_today_outlined,
          color: Colors.blue,
        ),
      ),
      style: TextStyle(fontSize: 12.sp),
      autovalidateMode: AutovalidateMode.onUserInteraction,
      validator: (val) {
        return null;
      },
    );
  }

  Widget nameTextField() {
    return TextFormField(
      controller: name,
      textInputAction: TextInputAction.next,
      keyboardType: TextInputType.text,
      decoration: const InputDecoration(
        hintText: 'Employee name',
        errorMaxLines: 2,
        prefixIcon: Icon(
          Icons.person_2_outlined,
          color: Colors.blue,
        ),
      ),
      autovalidateMode: AutovalidateMode.onUserInteraction,
      validator: (val) {
        return null;
      },
    );
  }

  Widget selectRoleTextField() {
    return TextFormField(
      controller: role,
      onTap: () => showDropDown(context),
      textInputAction: TextInputAction.next,
      readOnly: true,
      keyboardType: TextInputType.text,
      decoration: InputDecoration(
          hintText: 'Select role',
          errorMaxLines: 2,
          prefixIcon: const Icon(
            Icons.card_travel_outlined,
            color: Colors.blue,
          ),
          suffixIcon: Icon(
            Icons.arrow_drop_down,
            color: Colors.blue,
            size: 24.sp,
          )),
      autovalidateMode: AutovalidateMode.onUserInteraction,
      validator: (val) {
        return null;
      },
    );
  }
}
