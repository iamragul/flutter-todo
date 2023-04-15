import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:rti_task/data/hive_model/hive_employee_model.dart';
import 'package:rti_task/pages/add_employee.dart';
import 'package:rti_task/pages/edit_employee.dart';

class Home extends StatelessWidget {
  const Home({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Employee List")),
      body: SingleChildScrollView(
        child: ValueListenableBuilder(
            valueListenable:
                Hive.box<HiveEmployeeModel>('employee').listenable(),
            builder: (context, box, widget) {
              final emp = box.values.toList().cast<HiveEmployeeModel>();

              var currentEmp = emp.where((element) => element.toDate == '');

              var prevEmp = emp.where((element) => element.toDate != '');

              return emp.isEmpty
                  ? SizedBox(
                      height: 0.7.sh,
                      width: 1.sw,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          SizedBox(
                              height: 200,
                              child: Image.asset('assets/Images/no-emp.png')),
                        ],
                      ),
                    )
                  : Column(
                      children: [
                        Container(
                          color: Colors.grey[300],
                          height: 40.h,
                          alignment: Alignment.centerLeft,
                          padding: EdgeInsets.symmetric(horizontal: 20.w),
                          child: Text(
                            "Current Employees",
                            style: TextStyle(
                                fontSize: 14.sp,
                                color: Colors.blue,
                                fontWeight: FontWeight.w500),
                          ),
                        ),
                        SizedBox(
                          height: 0.35.sh,
                          child: ListView.builder(
                              shrinkWrap: true,
                              itemCount: emp.length,
                              itemBuilder: (context, index) {
                                return currentEmp.isEmpty
                                    ? SizedBox(
                                        height: 60.h,
                                        child: const Center(
                                            child: Padding(
                                          padding: EdgeInsets.all(8.0),
                                          child: Text("No data found"),
                                        )))
                                    : emp[index].toDate != ''
                                        ? const SizedBox.shrink()
                                        : Dismissible(
                                            key: Key(emp[index].key.toString()),
                                            onDismissed: (direction) {
                                              box.deleteAt(index);
                                              ScaffoldMessenger.of(context)
                                                  .showSnackBar(const SnackBar(
                                                      content: Text(
                                                          'Employee data has been deleted')));
                                            },
                                            background: Container(
                                              color: Colors.red,
                                              child: Row(
                                                mainAxisAlignment:
                                                    MainAxisAlignment.end,
                                                children: [
                                                  const Icon(
                                                      Icons
                                                          .delete_forever_rounded,
                                                      color: Colors.white),
                                                  SizedBox(
                                                    width: 16.w,
                                                  ),
                                                ],
                                              ),
                                            ),
                                            child: InkWell(
                                              onTap: () {
                                                Navigator.push(
                                                    context,
                                                    MaterialPageRoute(
                                                        builder: (_) =>
                                                            EditEmployee(
                                                              index: index,
                                                              hiveEmployeeModel:
                                                                  emp[index],
                                                            )));
                                              },
                                              child: Column(
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.start,
                                                children: [
                                                  Padding(
                                                    padding:
                                                        EdgeInsets.symmetric(
                                                            horizontal: 20.w,
                                                            vertical: 8.h),
                                                    child: Column(
                                                      crossAxisAlignment:
                                                          CrossAxisAlignment
                                                              .start,
                                                      children: [
                                                        Text(
                                                          emp[index].name,
                                                          style: TextStyle(
                                                              fontSize: 16.sp,
                                                              fontWeight:
                                                                  FontWeight
                                                                      .w600),
                                                        ),
                                                        SizedBox(
                                                          height: 4.h,
                                                        ),
                                                        Text(emp[index].role,
                                                            style: TextStyle(
                                                                fontSize: 12.sp,
                                                                color:
                                                                    Colors.grey,
                                                                fontWeight:
                                                                    FontWeight
                                                                        .w500)),
                                                        SizedBox(
                                                          height: 4.h,
                                                        ),
                                                        Wrap(
                                                          children: [
                                                            Text(
                                                              "From ",
                                                              style: TextStyle(
                                                                  fontSize:
                                                                      12.sp,
                                                                  color: Colors
                                                                      .grey,
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .w500),
                                                            ),
                                                            Text(
                                                              emp[index]
                                                                  .fromDate,
                                                              style: TextStyle(
                                                                  fontSize:
                                                                      12.sp,
                                                                  color: Colors
                                                                      .grey,
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .w500),
                                                            ),
                                                          ],
                                                        )
                                                      ],
                                                    ),
                                                  ),
                                                  Divider(
                                                    height: 8.h,
                                                  )
                                                ],
                                              ),
                                            ),
                                          );
                              }),
                        ),
                        Container(
                          color: Colors.grey[300],
                          height: 40.h,
                          alignment: Alignment.centerLeft,
                          padding: EdgeInsets.symmetric(horizontal: 20.w),
                          child: Text(
                            "Previous Employees",
                            style: TextStyle(
                                fontSize: 14.sp,
                                color: Colors.blue,
                                fontWeight: FontWeight.w500),
                          ),
                        ),
                        SizedBox(
                          height: 0.35.sh,
                          child: ListView.builder(
                              shrinkWrap: true,
                              itemCount: emp.length,
                              itemBuilder: (context, index) {
                                return prevEmp.isEmpty
                                    ? SizedBox(
                                        height: 60.h,
                                        child: const Center(
                                            child: Padding(
                                          padding: EdgeInsets.all(8.0),
                                          child: Text("No data found"),
                                        )))
                                    : emp[index].toDate == ''
                                        ? const SizedBox.shrink()
                                        : Dismissible(
                                            key: Key(emp[index].key.toString()),
                                            onDismissed: (direction) {
                                              box.deleteAt(index);
                                              ScaffoldMessenger.of(context)
                                                  .showSnackBar(const SnackBar(
                                                      content: Text(
                                                          'Employee data has been deleted')));
                                            },
                                            background: Container(
                                              color: Colors.red,
                                              child: Row(
                                                mainAxisAlignment:
                                                    MainAxisAlignment.end,
                                                children: [
                                                  const Icon(
                                                      Icons
                                                          .delete_forever_rounded,
                                                      color: Colors.white),
                                                  SizedBox(
                                                    width: 16.w,
                                                  ),
                                                ],
                                              ),
                                            ),
                                            child: InkWell(
                                              onTap: () {
                                                Navigator.push(
                                                    context,
                                                    MaterialPageRoute(
                                                        builder: (_) =>
                                                            EditEmployee(
                                                              index: index,
                                                              hiveEmployeeModel:
                                                                  emp[index],
                                                            )));
                                              },
                                              child: Column(
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.start,
                                                children: [
                                                  Padding(
                                                    padding:
                                                        EdgeInsets.symmetric(
                                                            horizontal: 20.w,
                                                            vertical: 8.h),
                                                    child: Column(
                                                      crossAxisAlignment:
                                                          CrossAxisAlignment
                                                              .start,
                                                      children: [
                                                        Text(
                                                          emp[index].name,
                                                          style: TextStyle(
                                                              fontSize: 16.sp,
                                                              fontWeight:
                                                                  FontWeight
                                                                      .w600),
                                                        ),
                                                        SizedBox(
                                                          height: 4.h,
                                                        ),
                                                        Text(emp[index].role,
                                                            style: TextStyle(
                                                                fontSize: 12.sp,
                                                                color:
                                                                    Colors.grey,
                                                                fontWeight:
                                                                    FontWeight
                                                                        .w500)),
                                                        SizedBox(
                                                          height: 4.h,
                                                        ),
                                                        Wrap(
                                                          children: [
                                                            Text(
                                                                emp[index]
                                                                    .fromDate,
                                                                style: TextStyle(
                                                                    fontSize:
                                                                        12.sp,
                                                                    color: Colors
                                                                        .grey,
                                                                    fontWeight:
                                                                        FontWeight
                                                                            .w500)),
                                                            const Text(" - "),
                                                            Text(
                                                                emp[index]
                                                                    .toDate,
                                                                style: TextStyle(
                                                                    fontSize:
                                                                        12.sp,
                                                                    color: Colors
                                                                        .grey,
                                                                    fontWeight:
                                                                        FontWeight
                                                                            .w500))
                                                          ],
                                                        ),
                                                      ],
                                                    ),
                                                  ),
                                                  Divider(
                                                    height: 8.h,
                                                  )
                                                ],
                                              ),
                                            ),
                                          );
                              }),
                        )
                      ],
                    );
            }),
      ),
      floatingActionButton: FloatingActionButton(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8.r)),
        onPressed: () {
          Navigator.push(
              context, MaterialPageRoute(builder: (_) => const AddEmployee()));
        },
        tooltip: 'Add Employee',
        child: const Icon(Icons.add),
      ),
    );
  }
}
