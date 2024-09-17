import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../presentation/views/card_view.dart';
import '../../presentation/views/home_view.dart';

class CurrentScreenIndex extends StatelessWidget {
  final int index;

  const CurrentScreenIndex(this.index, {super.key});

  @override
  Widget build(BuildContext context) {
    switch (index) {
      case 1:
        {
          return const HomeView();
        }
      case 2:
        {
          return const CardView();
        }
      case 3:
        {
          return const CardView();
        }
      default:
        {
          return const HomeView();
        }
    }
  }
}
