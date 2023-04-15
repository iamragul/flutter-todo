import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'package:rti_task/pages/bloc/add_employee_bloc.dart';
import 'package:rti_task/pages/custom_from_date_picker.dart';
import 'package:rti_task/pages/custom_to_date_picker.dart';
import 'package:rti_task/themes/theme.dart';

class AddEmployee extends StatelessWidget {
  const AddEmployee({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => AddEmployeeBloc(),
      child: const AddEmployeePage(),
    );
  }
}

class AddEmployeePage extends StatefulWidget {
  const AddEmployeePage({super.key});

  @override
  State<AddEmployeePage> createState() => _AddEmployeePageState();
}

class _AddEmployeePageState extends State<AddEmployeePage> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  TextEditingController name = TextEditingController();
  TextEditingController role = TextEditingController();
  TextEditingController fromDate = TextEditingController();
  TextEditingController toDate = TextEditingController();

  DateTime selectedDate = DateTime.now();

  // ignore: avoid_init_to_null
  dynamic roleErr = null;

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
                      setState(() {
                        roleErr = null;
                      });
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
                      setState(() {
                        roleErr = null;
                      });

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
                      setState(() {
                        roleErr = null;
                      });
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
                      setState(() {
                        roleErr = null;
                      });
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
    if (role.text.trim() == '') {
      setState(() {
        roleErr = "role is required";
      });
      return;
    }
    if (fromDate.text.trim() == '') {
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
          backgroundColor: Colors.red, content: Text('from date is required')));
      return;
    }
    BlocProvider.of<AddEmployeeBloc>(context).add(AddEmployeeSubmit(
        name: name.text.trim(),
        role: role.text.trim(),
        fromDate: fromDate.text,
        toDate: toDate.text));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text("Add Employee Details"),
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
                ),
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
            BlocConsumer<AddEmployeeBloc, AddEmployeeState>(
              listener: (context, state) {
                if (state is AddEmployeeSuccess) {
                  Navigator.pop(context);
                }
              },
              builder: (context, state) {
                if (state is AddEmployeeLoading) {
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
        if (val.toString().isEmpty) {
          return 'name is required';
        }
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
          errorText: roleErr,
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
