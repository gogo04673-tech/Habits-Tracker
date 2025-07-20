import 'package:flutter/material.dart';
import 'package:habit_track/controllers/state_management/habit_provider.dart';
import 'package:provider/provider.dart';
import 'package:table_calendar/table_calendar.dart';

class CalendarTable extends StatefulWidget {
  const CalendarTable({super.key});

  @override
  State<CalendarTable> createState() => _CalendarTableState();
}

class _CalendarTableState extends State<CalendarTable> {
  DateTime _focusedDay = DateTime.now();

  @override
  Widget build(BuildContext context) {
    return TableCalendar(
      firstDay: DateTime.utc(2020, 1, 1),
      lastDay: DateTime.utc(2030, 12, 31),
      startingDayOfWeek: StartingDayOfWeek.monday,
      focusedDay: _focusedDay,
      selectedDayPredicate: (day) =>
          isSameDay(context.watch<HabitProvider>().selectedDay, day),
      onDaySelected: (selectedDay, focusedDay) {
        setState(() {
          _focusedDay = focusedDay;
        });

        Provider.of<HabitProvider>(
          context,
          listen: false,
        ).updateSelectedDay(selectedDay);
      },

      headerStyle: const HeaderStyle(
        titleTextStyle: TextStyle(
          color: Colors.white,
          fontWeight: FontWeight.bold,
        ),
        titleCentered: true,
        formatButtonVisible: false,
        formatButtonShowsNext: false,
        formatButtonTextStyle: TextStyle(color: Colors.white),
        formatButtonDecoration: BoxDecoration(color: Colors.white),
        leftChevronIcon: Icon(Icons.chevron_left, color: Colors.white),
        rightChevronIcon: Icon(Icons.chevron_right, color: Colors.white),
      ),

      daysOfWeekStyle: DaysOfWeekStyle(
        weekdayStyle: const TextStyle(
          color: Colors.white,
          fontWeight: FontWeight.bold,
          fontSize: 12,
        ),

        weekendStyle: const TextStyle(
          color: Colors.white,
          fontWeight: FontWeight.bold,
          fontSize: 12,
        ),
        dowTextFormatter: (date, locale) {
          switch (date.weekday) {
            case DateTime.monday:
              return 'M';
            case DateTime.tuesday:
              return 'T';
            case DateTime.wednesday:
              return 'W';
            case DateTime.thursday:
              return 'T';
            case DateTime.friday:
              return 'F';
            case DateTime.saturday:
              return 'S';
            case DateTime.sunday:
              return 'S';
          }
          return '';
        },
      ),

      calendarBuilders: CalendarBuilders(
        markerBuilder: (context, date, events) {
          final habitProvider = Provider.of<HabitProvider>(context);

          // نحول التاريخ إلى اليوم فقط بدون وقت
          final dateOnly = DateTime(date.year, date.month, date.day);

          // نبحث هل هناك أي عادة تحتوي هذا اليوم في completedDays
          int completedCount = habitProvider.habits.where((habit) {
            return habit.completedDays.any(
              (d) => habitProvider.isSameDay(d, dateOnly),
            );
          }).length;

          // لو فيه عادات مكتملة في ذلك اليوم، نعرض علامة
          if (completedCount > 0) {
            return Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(Icons.check_circle, size: 16, color: Colors.green),
                if (completedCount > 1)
                  Padding(
                    padding: const EdgeInsets.only(left: 4.0),
                    child: Text(
                      '$completedCount',
                      style: const TextStyle(
                        color: Colors.green,
                        fontSize: 12,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
              ],
            );
          }

          return null;
        },

        defaultBuilder: (context, day, focusedDay) {
          // Check if it's Sunday
          if (day.weekday == DateTime.sunday) {
            return Center(
              child: Text(
                '${day.day}',
                style: const TextStyle(
                  color: Color(0xFFFFA500),
                  fontSize: 13,
                  fontWeight: FontWeight.bold,
                ),
              ),
            );
          }

          // Other days default behavior
          return Center(
            child: Text(
              '${day.day}',
              style: TextStyle(
                color: day.day == focusedDay.day
                    ? const Color(0xFF0bda57) // custom green for focused day
                    : Colors.white, // white for normal Sundays
                fontSize: day.day == focusedDay.day ? 15 : 13,
                fontWeight: FontWeight.bold,
              ),
            ),
          );
        },
      ),
      calendarStyle: const CalendarStyle(
        cellMargin: EdgeInsets.all(4.0),
        cellAlignment: Alignment.center,
        defaultTextStyle: TextStyle(
          color: Colors.white,
          fontWeight: FontWeight.bold,
          fontSize: 14,
        ),
        weekendTextStyle: TextStyle(
          color: Colors.white,
          fontWeight: FontWeight.bold,
          fontSize: 14,
        ),
        todayTextStyle: TextStyle(
          color: Colors.black,
          fontWeight: FontWeight.bold,
          fontSize: 14,
        ),
        selectedTextStyle: TextStyle(
          color: Colors.black,
          fontWeight: FontWeight.bold,
          fontSize: 14,
        ),

        todayDecoration: BoxDecoration(
          color: Color(0xFF47b4ea),
          shape: BoxShape.circle,
        ),
        selectedDecoration: BoxDecoration(
          color: Colors.orange,
          shape: BoxShape.circle,
        ),
      ),
    );
  }
}
