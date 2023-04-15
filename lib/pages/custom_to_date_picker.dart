import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:intl/intl.dart';
import 'package:rti_task/themes/theme.dart';
import 'package:syncfusion_flutter_datepicker/datepicker.dart';

class CustomToDatePicker extends StatefulWidget {
  const CustomToDatePicker({super.key});

  @override
  State<CustomToDatePicker> createState() => _CustomToDatePickerState();
}

class _CustomToDatePickerState extends State<CustomToDatePicker> {
  DateTime selectedDate = DateTime.now();
  final DateRangePickerController _datePickerController =
      DateRangePickerController();
  bool todaySelected = false;
  bool noDateSelected = true;

  void _onSelectionChanged(DateRangePickerSelectionChangedArgs args) {
    setState(() {
      selectedDate = DateTime.parse(args.value.toString());
      var checkDate = DateFormat("dd MMM yyyy").format(selectedDate);
      var checkTodayDate = DateFormat("dd MMM yyyy").format(DateTime.now());

      if (checkDate.toString() == checkTodayDate.toString()) {
        todaySelected = true;
        noDateSelected = false;
      } else if (checkDate.toString() == '01 Jan 0000') {
        todaySelected = false;
        noDateSelected = true;
      } else {
        todaySelected = false;
        noDateSelected = false;
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    var date = DateFormat("dd MMM yyyy").format(selectedDate);
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Row(
          children: [
            Expanded(
              child: TextButton(
                  onPressed: () {
                    var monday = DateTime.now();

                    while (monday.weekday != DateTime.monday) {
                      monday = monday.add(const Duration(days: 1));
                    }

                    setState(() {
                      todaySelected = false;
                      noDateSelected = true;

                      _datePickerController.selectedDate = DateTime(0);
                    });
                  },
                  style: TextButton.styleFrom(
                    minimumSize: Size(70.w, 28.h),
                    backgroundColor:
                        noDateSelected ? Colors.blue : customBlueAccent,
                    foregroundColor:
                        noDateSelected ? Colors.white : Colors.blue,
                    textStyle: TextStyle(
                      color: Colors.white,
                      fontSize: 14.sp,
                      fontWeight: FontWeight.w500,
                    ),
                    padding: EdgeInsets.all(8.r),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.all(Radius.circular(6.r)),
                    ),
                  ),
                  child: const Text("No Date")),
            ),
            SizedBox(
              width: 16.w,
            ),
            Expanded(
              child: TextButton(
                  onPressed: () {
                    setState(() {
                      todaySelected = true;
                      noDateSelected = false;

                      _datePickerController.selectedDate = DateTime.now();
                    });
                  },
                  style: TextButton.styleFrom(
                    minimumSize: Size(70.w, 28.h),
                    backgroundColor:
                        todaySelected ? Colors.blue : customBlueAccent,
                    foregroundColor: todaySelected ? Colors.white : Colors.blue,
                    disabledForegroundColor: Colors.blueGrey[400],
                    textStyle: TextStyle(
                      color: Colors.white,
                      fontSize: 14.sp,
                      fontWeight: FontWeight.w500,
                    ),
                    padding: EdgeInsets.all(8.r),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.all(Radius.circular(6.r)),
                    ),
                  ),
                  child: const Text("Today")),
            ),
          ],
        ),
        SizedBox(
          height: 8.h,
        ),
        SfDateRangePicker(
          headerStyle:
              const DateRangePickerHeaderStyle(textAlign: TextAlign.center),
          onSelectionChanged: _onSelectionChanged,
          // initialSelectedDate: selectedDate,
          controller: _datePickerController,
          view: DateRangePickerView.month,
          toggleDaySelection: true,
          allowViewNavigation: true,
          showNavigationArrow: true,
          selectionMode: DateRangePickerSelectionMode.single,
        ),
        Divider(
          height: 16.h,
        ),
        Padding(
          padding: EdgeInsets.symmetric(vertical: 0.r),
          child: Row(
            children: [
              const Icon(
                Icons.calendar_today_outlined,
                color: Colors.blue,
              ),
              SizedBox(
                width: 8.w,
              ),
              noDateSelected ? const Text("No Date") : Text(date),
              const Spacer(),
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
                width: 8.w,
              ),
              ElevatedButton(
                  onPressed: () {
                    if (noDateSelected) {
                      Navigator.pop(context);
                    } else {
                      Navigator.pop(context, date);
                    }
                  },
                  style: ElevatedButton.styleFrom(
                    elevation: 0,
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
                  child: const Text("Save"))
            ],
          ),
        )
      ],
    );
  }
}
