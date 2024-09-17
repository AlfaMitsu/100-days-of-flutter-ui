import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class GraphCard extends StatelessWidget {
  final String title;
  final Color activeColor, fontColor;
  final bool isActive;

  final int activeIndex;
  const GraphCard({
    super.key,
    required this.title,
    required this.activeColor,
    required this.fontColor,
    required this.isActive,
    required this.activeIndex,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 50,
      width: MediaQuery.of(context).size.width / 6.05,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(
          20.0,
        ),
        color: activeColor,
      ),
      child: Center(
        child: Text(
          title,
          textAlign: TextAlign.center,
          style: GoogleFonts.roboto(
            fontSize: 10,
            fontWeight: FontWeight.w500,
            color: fontColor,
          ),
        ),
      ),
    );
  }
}
