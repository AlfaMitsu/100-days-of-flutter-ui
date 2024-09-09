import 'package:flutter/material.dart';

class TaskDashboard extends StatefulWidget {
  @override
  _TaskDashboardState createState() => _TaskDashboardState();
}

class _TaskDashboardState extends State<TaskDashboard> {
  List<Task> tasks = [
    Task(
        name: 'Bath & Breakfast',
        time: '08:00 - 09:00',
        date: '01/09/2024',
        isCompleted: true),
    Task(
        name: 'Visit dad\'s shop',
        time: '10:00 - 11:00',
        date: '01/09/2024',
        isCompleted: false),
    Task(
        name: 'Team Meeting',
        time: '13:00 - 14:00',
        date: '01/09/2024',
        isCompleted: false),
  ];

  void _toggleTaskCompletion(int index) {
    setState(() {
      tasks[index].isCompleted = !tasks[index].isCompleted;
    });
  }

  void _addTask() {
    setState(() {
      tasks.add(Task(
          name: 'New Task',
          time: '09:00 - 10:00',
          date: '02/09/2024',
          isCompleted: false));
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
        child: _buildHeader(),
      ),
      body: Column(
        children: [
          _buildDateHeader(),
          _buildTodayTasksHeader(),
          _buildTasksSection(),
          _buildStatisticsSection(),
        ],
      ),
      bottomNavigationBar: _buildBottomNavigationBar(),
    );
  }

  Widget _buildHeader() {
    return Container(
      padding: const EdgeInsets.only(top: 40, left: 20, right: 20, bottom: 10),
      decoration: const BoxDecoration(
        color: Color(0xFF385997), // Adjust the header background color
        borderRadius: BorderRadius.vertical(
          bottom: Radius.circular(30),
        ),
      ),
      child: const Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            'Good morning\nRam',
            style: TextStyle(
                color: Colors.white, fontSize: 22, fontWeight: FontWeight.bold),
          ),
          CircleAvatar(
            radius: 30,
            backgroundImage:
                AssetImage('assets/profile.jpg'), // Add your profile image here
          ),
        ],
      ),
    );
  }

  Widget _buildDateHeader() {
    return Container(
      height: 70,
      padding: const EdgeInsets.symmetric(vertical: 10),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: List.generate(7, (index) {
          return Expanded(
            child: Column(
              children: [
                Text(
                  '0${index + 1}',
                  style: const TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
                Text(
                  ['M', 'T', 'W', 'T', 'F', 'S', 'S'][index],
                  style: const TextStyle(fontSize: 14, color: Colors.white),
                ),
              ],
            ),
          );
        }),
      ),
    );
  }

  Widget _buildTodayTasksHeader() {
    return Container(
      padding: const EdgeInsets.all(20.0),
      child: const Text(
        'Today Tasks',
        style: TextStyle(
            fontSize: 20, fontWeight: FontWeight.bold, color: Colors.white),
      ),
    );
  }

  Widget _buildTasksSection() {
    return Expanded(
      child: Container(
        decoration: const BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.vertical(top: Radius.circular(30)),
        ),
        child: ListView.builder(
          padding: const EdgeInsets.all(10),
          itemCount: tasks.length,
          itemBuilder: (context, index) {
            return _buildTaskItem(index);
          },
        ),
      ),
    );
  }

  Widget _buildTaskItem(int index) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 8, horizontal: 20),
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
                style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
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
  }

  Widget _buildStatisticsSection() {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
      child: Column(
        children: [
          const Text(
            'Statistics',
            style: TextStyle(
                fontSize: 20, fontWeight: FontWeight.bold, color: Colors.white),
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
    );
  }

  Widget _buildStatisticItem(String value, String label) {
    return Column(
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
    );
  }

  Widget _buildBottomNavigationBar() {
    return BottomNavigationBar(
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
        BottomNavigationBarItem(icon: Icon(Icons.settings), label: 'Settings'),
      ],
    );
  }
}

class Task {
  String name;
  String time;
  String date;
  bool isCompleted;

  Task(
      {required this.name,
      required this.time,
      required this.date,
      this.isCompleted = false});
}
