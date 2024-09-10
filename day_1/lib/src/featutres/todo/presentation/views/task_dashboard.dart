import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../../data/data_sources/tasks_data.dart';
import '../../data/models/task_model.dart';

class TaskDashboard extends StatefulWidget {
  const TaskDashboard({super.key});

  @override
  _TaskDashboardState createState() => _TaskDashboardState();
}

class _TaskDashboardState extends State<TaskDashboard> {
  DateTime _selectedDate = DateTime.now();
  List<DateTime> _weekDays = [];

  String _getGreetingMessage() {
    final hour = DateTime.now().hour;
    if (hour < 12) {
      return 'Good Morning User';
    } else if (hour < 18) {
      return 'Good Afternoon User';
    } else {
      return 'Good Evening User';
    }
  }

  @override
  void initState() {
    super.initState();
    _calculateWeekDays();
  }

  void _calculateWeekDays() {
    final today = DateTime.now();
    final monday = today.subtract(Duration(days: today.weekday - 1));

    setState(() {
      _weekDays =
          List.generate(7, (index) => monday.add(Duration(days: index)));
    });
  }

  void _onDaySelected(DateTime date) {
    setState(() {
      _selectedDate = date;
    });
  }

  String _getTaskTitle() {
    final DateFormat monthFormat = DateFormat('MMMM dd yyyy');

    if (_selectedDate.isAtSameMomentAs(DateTime.now())) {
      return monthFormat.format(DateTime.now());
    } else {
      return monthFormat.format(_selectedDate);
    }
  }

  void _toggleTaskCompletion(int index) {
    setState(() {
      tasks[index].isCompleted = !tasks[index].isCompleted;
    });
  }

  void _editTask(int index) {
    setState(() {
      tasks[index] = Task(
          name: 'Edited Task',
          time: '10:00 - 11:00',
          date: '02/09/2024',
          isCompleted: false);
    });
  }

  void _deleteTask(int index) {
    setState(() {
      tasks.removeAt(index);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(100),
        child: Container(
          padding:
              const EdgeInsets.only(top: 40, left: 20, right: 20, bottom: 10),
          decoration: const BoxDecoration(
            color: Color(0xFF385997),
            borderRadius: BorderRadius.vertical(
              bottom: Radius.circular(30),
            ),
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                _getGreetingMessage(),
                style: const TextStyle(
                  color: Colors.white,
                  fontSize: 22,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const CircleAvatar(
                radius: 30,
                backgroundImage: AssetImage('assets/profile.jpg'),
              ),
            ],
          ),
        ),
      ),
      body: Column(
        children: [
          const SizedBox(height: 15),
          SizedBox(
            height: 60,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: List.generate(7, (index) {
                final date = _weekDays[index];
                return Expanded(
                  child: GestureDetector(
                    onTap: () => _onDaySelected(date),
                    child: Container(
                      margin: const EdgeInsets.symmetric(horizontal: 5),
                      decoration: BoxDecoration(
                        color: _selectedDate.isSameDay(date)
                            ? Colors.blueAccent
                            : const Color(0xFF597BBE),
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            date.day.toString().padLeft(2),
                            style: const TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                              color: Colors.white,
                            ),
                          ),
                          Text(
                            ['M', 'T', 'W', 'T', 'F', 'S', 'S'][index],
                            style: const TextStyle(
                              fontSize: 14,
                              color: Colors.white,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                );
              }),
            ),
          ),
          const SizedBox(height: 10),
          Text(
            _getTaskTitle(),
            style: const TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
              color: Colors.white,
            ),
          ),
          const SizedBox(height: 10),
          Expanded(
            child: Container(
              decoration: const BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.vertical(
                  top: Radius.circular(30),
                ),
              ),
              child: Scrollbar(
                thumbVisibility: true,
                child: ListView.builder(
                  padding: const EdgeInsets.all(10),
                  itemCount: tasks.length,
                  itemBuilder: (context, index) {
                    return Container(
                      margin: const EdgeInsets.symmetric(
                          vertical: 8, horizontal: 20),
                      padding: const EdgeInsets.all(10),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(15),
                        boxShadow: const [
                          BoxShadow(
                            color: Colors.black26,
                            blurRadius: 4,
                            offset: Offset(0, 2),
                          ),
                        ],
                      ),
                      child: Row(
                        children: [
                          Checkbox(
                            value: tasks[index].isCompleted,
                            onChanged: (bool? newValue) {
                              _toggleTaskCompletion(index);
                            },
                            activeColor: Colors.blue,
                          ),
                          const SizedBox(width: 10),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                tasks[index].name,
                                style: const TextStyle(
                                    fontSize: 16, fontWeight: FontWeight.bold),
                              ),
                              Text(
                                '${tasks[index].time} - ${tasks[index].date}',
                                style: TextStyle(color: Colors.grey[600]),
                              ),
                            ],
                          ),
                          const Spacer(),
                          IconButton(
                            icon: Icon(Icons.edit, color: Colors.grey[700]),
                            onPressed: () => _editTask(index),
                          ),
                          IconButton(
                            icon: const Icon(Icons.delete, color: Colors.red),
                            onPressed: () => _deleteTask(index),
                          ),
                        ],
                      ),
                    );
                  },
                ),
              ),
            ),
          ),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
            child: Column(
              children: [
                const Text(
                  'Statistics',
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    _buildStatisticItem('35', 'This Week'),
                    _buildStatisticItem('8', 'Important'),
                    _buildStatisticItem('7', 'Today Tasks'),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
      bottomNavigationBar: BottomNavigationBar(
        backgroundColor: const Color(0xFF385997),
        selectedItemColor: Colors.white,
        unselectedItemColor: Colors.grey[400],
        type: BottomNavigationBarType.fixed, // Ensures it takes the full width
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Home'),
          BottomNavigationBarItem(
              icon: Icon(Icons.calendar_today), label: 'Calendar'),
          BottomNavigationBarItem(
              icon: Icon(Icons.add_circle_outline), label: 'Add'),
          BottomNavigationBarItem(
              icon: Icon(Icons.notifications), label: 'Notifications'),
          BottomNavigationBarItem(
              icon: Icon(Icons.settings), label: 'Settings'),
        ],
      ),
    );
  }

  Widget _buildStatisticItem(String value, String label) {
    return Container(
      margin: const EdgeInsets.all(5),
      padding: const EdgeInsets.all(10),
      decoration: BoxDecoration(
        color: const Color(0xFF385997),
        borderRadius: BorderRadius.circular(10),
      ),
      child: Column(
        children: [
          Text(
            value,
            style: const TextStyle(
              fontSize: 24,
              fontWeight: FontWeight.bold,
              color: Colors.white,
            ),
          ),
          Text(label, style: const TextStyle(color: Colors.white)),
        ],
      ),
    );
  }
}

extension DateUtils on DateTime {
  bool isSameDay(DateTime other) {
    return year == other.year && month == other.month && day == other.day;
  }
}
