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
  List<Task> _filteredTasks = [];
  int _todayCount = 0;
  int _thisWeekCount = 0;
  int _importantCount = 0;

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
    _updateStatistics();
    _filterTasksForSelectedDay();
  }

  void _calculateWeekDays() {
    final today = DateTime.now();
    final monday = today.subtract(Duration(days: today.weekday - 1));

    setState(() {
      _weekDays =
          List.generate(7, (index) => monday.add(Duration(days: index)));
    });
  }

  void _updateStatistics() {
    final today = DateTime.now();
    final thisWeekStart = today.subtract(Duration(days: today.weekday - 1));
    final thisWeekEnd = thisWeekStart.add(const Duration(days: 6));

    setState(() {
      _todayCount = tasks.where((task) {
        final taskDate = DateFormat.yMMMd().parse(task.date);
        return taskDate.isSameDay(today);
      }).length;

      _thisWeekCount = tasks.where((task) {
        final taskDate = DateFormat.yMMMd().parse(task.date);
        return taskDate
                .isAfter(thisWeekStart.subtract(const Duration(days: 1))) &&
            taskDate.isBefore(thisWeekEnd.add(const Duration(days: 1)));
      }).length;

      _importantCount = tasks.where((task) => task.isCompleted).length;
    });
  }

  void _onDaySelected(DateTime date) {
    setState(() {
      _selectedDate = date;
      _updateTodayTasksCount(); // Update count when day is selected
    });
  }

  void _filterTasksForSelectedDay() {
    setState(() {
      _filteredTasks = tasks.where((task) {
        final taskDate = DateFormat.yMMMd().parse(task.date);
        return taskDate.isSameDay(_selectedDate);
      }).toList();
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
    _updateStatistics();
  }

  void _editTask(int index) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        TextEditingController taskNameController =
            TextEditingController(text: tasks[index].name);

        TimeOfDay selectedTime;
        DateTime selectedDate;

        try {
          DateTime taskDateTime = DateFormat.jm().parse(tasks[index].time);
          selectedTime = TimeOfDay.fromDateTime(taskDateTime);
        } catch (e) {
          selectedTime = TimeOfDay.now();
        }

        try {
          selectedDate = DateFormat.yMMMd().parse(tasks[index].date);
        } catch (e) {
          selectedDate = DateTime.now();
        }

        String formatTimeOfDay(TimeOfDay time) {
          final now = DateTime.now();
          final dt =
              DateTime(now.year, now.month, now.day, time.hour, time.minute);
          final format = DateFormat.jm();
          return format.format(dt);
        }

        return StatefulBuilder(
          builder: (context, setState) {
            return AlertDialog(
              title: const Text('Edit Task'),
              content: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  TextField(
                    controller: taskNameController,
                    decoration: const InputDecoration(labelText: 'Task Name'),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text('Time: ${formatTimeOfDay(selectedTime)}'),
                      TextButton(
                        onPressed: () async {
                          TimeOfDay? pickedTime = await showTimePicker(
                            context: context,
                            initialTime: selectedTime,
                          );
                          if (pickedTime != null) {
                            setState(() {
                              selectedTime = pickedTime;
                            });
                          }
                        },
                        child: const Text('Pick Time'),
                      ),
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text('Date: ${DateFormat.yMMMd().format(selectedDate)}'),
                      TextButton(
                        onPressed: () async {
                          DateTime? pickedDate = await showDatePicker(
                            context: context,
                            initialDate: selectedDate,
                            firstDate: DateTime(2000),
                            lastDate: DateTime(2101),
                          );
                          if (pickedDate != null) {
                            setState(() {
                              selectedDate = pickedDate;
                            });
                          }
                        },
                        child: const Text('Pick Date'),
                      ),
                    ],
                  ),
                ],
              ),
              actions: [
                TextButton(
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                  child: const Text('Cancel'),
                ),
                ElevatedButton(
                  onPressed: () {
                    setState(() {
                      tasks[index] = Task(
                        name: taskNameController.text,
                        time: formatTimeOfDay(selectedTime),
                        date: DateFormat.yMMMd().format(selectedDate),
                        isCompleted: false,
                      );
                    });
                    Navigator.of(context).pop();
                  },
                  child: const Text('Save'),
                ),
              ],
            );
          },
        );
      },
    );
  }

  void _deleteTask(int index) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Delete Task'),
          content: const Text('Are you sure you want to delete this task?'),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: const Text('Cancel'),
            ),
            ElevatedButton(
              onPressed: () {
                setState(() {
                  tasks.removeAt(index);
                });
                _updateStatistics(); // Update statistics after deleting a task
                Navigator.of(context).pop();
              },
              child: const Text('Delete'),
            ),
          ],
        );
      },
    );
  }

  void _updateTodayTasksCount() {
    setState(() {
      _todayCount = _filteredTasks.length;
    });
  }

  void _addTask() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        TextEditingController taskNameController = TextEditingController();
        TimeOfDay selectedTime = TimeOfDay.now();
        DateTime selectedDate = DateTime.now();

        String formatTimeOfDay(TimeOfDay time) {
          final now = DateTime.now();
          final dt =
              DateTime(now.year, now.month, now.day, time.hour, time.minute);
          final format = DateFormat.jm();
          return format.format(dt);
        }

        return StatefulBuilder(
          builder: (context, setState) {
            return AlertDialog(
              title: const Text('Add Task'),
              content: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  TextField(
                    controller: taskNameController,
                    decoration: const InputDecoration(labelText: 'Task Name'),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text('Time: ${formatTimeOfDay(selectedTime)}'),
                      TextButton(
                        onPressed: () async {
                          TimeOfDay? pickedTime = await showTimePicker(
                            context: context,
                            initialTime: selectedTime,
                          );
                          if (pickedTime != null) {
                            setState(() {
                              selectedTime = pickedTime;
                            });
                          }
                        },
                        child: const Text('Pick Time'),
                      ),
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text('Date: ${DateFormat.yMMMd().format(selectedDate)}'),
                      TextButton(
                        onPressed: () async {
                          DateTime? pickedDate = await showDatePicker(
                            context: context,
                            initialDate: selectedDate,
                            firstDate: DateTime(2000),
                            lastDate: DateTime(2101),
                          );
                          if (pickedDate != null) {
                            setState(() {
                              selectedDate = pickedDate;
                            });
                          }
                        },
                        child: const Text('Pick Date'),
                      ),
                    ],
                  ),
                ],
              ),
              actions: [
                TextButton(
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                  child: const Text('Cancel'),
                ),
                ElevatedButton(
                  onPressed: () {
                    setState(() {
                      tasks.add(Task(
                        name: taskNameController.text,
                        time: formatTimeOfDay(selectedTime),
                        date: DateFormat.yMMMd().format(selectedDate),
                        isCompleted: false,
                      ));

                      // Update statistics
                      if (selectedDate.isSameDay(_selectedDate)) {
                        _todayCount++;
                      }
                      _thisWeekCount++;
                    });
                    Navigator.of(context).pop();
                  },
                  child: const Text('Add'),
                ),
              ],
            );
          },
        );
      },
    );
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
                  itemCount: _filteredTasks.length,
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
                            value: _filteredTasks[index].isCompleted,
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
                                _filteredTasks[index].name,
                                style: const TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.black,
                                ),
                              ),
                              Text(
                                '${_filteredTasks[index].time} - ${_filteredTasks[index].date}',
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
                    _buildStatisticItem('$_thisWeekCount', 'This Week'),
                    _buildStatisticItem('$_importantCount', 'Important'),
                    _buildStatisticItem('$_todayCount', 'Today Tasks'),
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
        type: BottomNavigationBarType.fixed,
        onTap: (index) {
          if (index == 2) {
            _addTask();
          }
        },
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
