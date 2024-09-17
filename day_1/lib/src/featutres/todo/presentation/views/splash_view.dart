import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../../../constants/colors.dart';
import '../../data/repositories/current_screen_index.dart';

class SplashView extends StatefulWidget {
  const SplashView({super.key});

  @override
  _SplashViewState createState() => _SplashViewState();
}

class _SplashViewState extends State<SplashView> {
  int selectedOptionIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: kBlackColor,
      bottomNavigationBar: _buildBottomNavigationBarPortrait(),
      body: CurrentScreenIndex(selectedOptionIndex),
    );
  }

  void _onItemTapped(int index) {
    setState(() {
      selectedOptionIndex = index;
    });
  }

  Widget _buildBottomNavigationBarPortrait() {
    return BottomNavigationBar(
      items: const [
        BottomNavigationBarItem(
          icon: Icon(CupertinoIcons.home),
          label: '',
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.credit_card),
          label: '',
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.comment),
          label: '',
        ),
        BottomNavigationBarItem(
          icon: Icon(CupertinoIcons.person),
          label: '',
        ),
      ],
      currentIndex: selectedOptionIndex,
      onTap: _onItemTapped,
      backgroundColor: kBlackColor,
      selectedItemColor: kPrimaryOrangeColor,
      unselectedItemColor: kWhiteColor,
      showUnselectedLabels: true,
      type: BottomNavigationBarType.fixed,
    );
  }
}
