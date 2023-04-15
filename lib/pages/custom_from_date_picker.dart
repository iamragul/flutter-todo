import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:intl/intl.dart';
import 'package:rti_task/themes/theme.dart';
import 'package:syncfusion_flutter_datepicker/datepicker.dart';

class CustomDatePicker extends StatefulWidget {
  const CustomDatePicker({super.key});

  @override
  State<CustomDatePicker> createState() => _CustomDatePickerState();
}

class _CustomDatePickerState extends State<CustomDatePicker> {
  DateTime selectedDate = DateTime.now();
  final DateRangePickerController _datePickerController =
      DateRangePickerController();
  bool todaySelected = true;
  bool mondaySelected = false;
  bool tuesdaySelected = false;
  bool weekSelected = false;

  void _onSelectionChanged(DateRangePickerSelectionChangedArgs args) {
    var monday = DateTime.now();

    while (monday.weekday != DateTime.monday) {
      monday = monday.add(const Duration(days: 1));
    }
    var tuesday = DateTime.now();

    while (tuesday.weekday != DateTime.tuesday) {
      tuesday = tuesday.add(const Duration(days: 1));
    }
    var week = DateTime.now();

    while (week.weekday != DateTime.monday) {
      week = week.add(const Duration(days: 3));
    }

    setState(() {
      selectedDate = DateTime.parse(args.value.toString());
      var checkDate = DateFormat("dd MMM yyyy").format(selectedDate);
      var checkTodayDate = DateFormat("dd MMM yyyy").format(DateTime.now());
      var checkMondayDate = DateFormat("dd MMM yyyy").format(monday);
      var checkTuesdayDate = DateFormat("dd MMM yyyy").format(tuesday);
      var checkWeekDate = DateFormat("dd MMM yyyy").format(week);

      if (checkDate.toString() == checkTodayDate.toString()) {
        todaySelected = true;
        mondaySelected = false;
        tuesdaySelected = false;
        weekSelected = false;
      } else if (checkDate.toString() == checkMondayDate.toString()) {
        todaySelected = false;
        mondaySelected = true;
        tuesdaySelected = false;
        weekSelected = false;
      } else if (checkDate.toString() == checkTuesdayDate.toString()) {
        todaySelected = false;
        mondaySelected = false;
        tuesdaySelected = true;
        weekSelected = false;
      } else if (checkDate.toString() == checkWeekDate.toString()) {
        todaySelected = false;
        mondaySelected = false;
        tuesdaySelected = false;
        weekSelected = true;
      } else {
        todaySelected = false;
        mondaySelected = false;
        tuesdaySelected = false;
        weekSelected = false;
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
                    setState(() {
                      todaySelected = true;
                      mondaySelected = false;
                      tuesdaySelected = false;
                      weekSelected = false;
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
            SizedBox(
              width: 16.w,
            ),
            Expanded(
              child: TextButton(
                  onPressed: () {
                    var monday = DateTime.now();

                    while (monday.weekday != DateTime.monday) {
                      monday = monday.add(const Duration(days: 1));
                    }

                    setState(() {
                      todaySelected = false;
                      mondaySelected = true;
                      tuesdaySelected = false;
                      weekSelected = false;
                      _datePickerController.selectedDate = monday;
                    });
                  },
                  style: TextButton.styleFrom(
                    minimumSize: Size(70.w, 28.h),
                    backgroundColor:
                        mondaySelected ? Colors.blue : customBlueAccent,
                    foregroundColor:
                        mondaySelected ? Colors.white : Colors.blue,
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
                  child: const Text("Next Monday")),
            ),
          ],
        ),
        SizedBox(
          height: 8.h,
        ),
        Row(
          children: [
            Expanded(
              child: TextButton(
                  onPressed: () {
                    var tuesday = DateTime.now();

                    while (tuesday.weekday != DateTime.tuesday) {
                      tuesday = tuesday.add(const Duration(days: 1));
                    }

                    setState(() {
                      todaySelected = false;
                      mondaySelected = false;
                      tuesdaySelected = true;
                      weekSelected = false;
                      _datePickerController.selectedDate = tuesday;
                    });
                  },
                  style: TextButton.styleFrom(
                    minimumSize: Size(70.w, 28.h),
                    backgroundColor:
                        tuesdaySelected ? Colors.blue : customBlueAccent,
                    foregroundColor:
                        tuesdaySelected ? Colors.white : Colors.blue,
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
                  child: const Text("Next Tuesday")),
            ),
            SizedBox(
              width: 16.w,
            ),
            Expanded(
              child: TextButton(
                  onPressed: () {
                    var week = DateTime.now();

                    while (week.weekday != DateTime.monday) {
                      week = week.add(const Duration(days: 3));
                    }

                    setState(() {
                      todaySelected = false;
                      mondaySelected = false;
                      tuesdaySelected = false;
                      weekSelected = true;
                      _datePickerController.selectedDate = week;
                    });
                  },
                  style: TextButton.styleFrom(
                    minimumSize: Size(70.w, 28.h),
                    backgroundColor:
                        weekSelected ? Colors.blue : customBlueAccent,
                    foregroundColor: weekSelected ? Colors.white : Colors.blue,
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
                  child: const Text("After 1 week")),
            ),
          ],
        ),
        SizedBox(
          height: 8.w,
        ),
        SfDateRangePicker(
          headerStyle:
              const DateRangePickerHeaderStyle(textAlign: TextAlign.center),
          onSelectionChanged: _onSelectionChanged,
          initialSelectedDate: selectedDate,
          controller: _datePickerController,
          view: DateRangePickerView.month,
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
              Text(date),
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
                    Navigator.pop(context, date);
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
