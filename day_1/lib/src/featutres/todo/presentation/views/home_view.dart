import 'package:bezier_chart_plus/bezier_chart_plus.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';

import '../../../../constants/colors.dart';
import '../../../../constants/constants.dart';
import '../widgets/graph_card.dart';

class HomeView extends StatefulWidget {
  const HomeView({
    super.key,
  });

  @override
  _HomeViewState createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {
  final numberFormat = NumberFormat("##,###.00#", "en_US");
  Color color = kBlackColor;
  Color fcolor = kGreyColor;
  bool isActive = false;
  late int activeIndex;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: kBlackColor,
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.only(
            left: 15,
            right: 15,
            top: 30,
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Icon(
                    Icons.short_text,
                    color: kWhiteColor,
                  ),
                  Icon(
                    Icons.more_vert,
                    color: kWhiteColor,
                  )
                ],
              ),
              const SizedBox(
                height: 30,
              ),
              Text(
                "Your Balance",
                style: GoogleFonts.roboto(
                  fontSize: 25,
                  fontWeight: FontWeight.w700,
                  color: kWhiteColor,
                ),
              ),
              const SizedBox(
                height: 20,
              ),
              Text(
                "Money Received",
                style: GoogleFonts.roboto(
                  fontSize: 15,
                  fontWeight: FontWeight.w500,
                  color: kGreyColor,
                ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    r'$' + numberFormat.format(27802.05),
                    style: GoogleFonts.openSans(
                      fontSize: 40,
                      fontWeight: FontWeight.w600,
                      color: kWhiteColor,
                    ),
                  ),
                  Row(
                    children: [
                      Text(
                        "15%",
                        style: GoogleFonts.roboto(
                          fontSize: 12,
                          fontWeight: FontWeight.w500,
                          color: kWhiteColor,
                        ),
                      ),
                      const Icon(
                        Icons.arrow_upward,
                        color: kWhiteColor,
                      ),
                    ],
                  )
                ],
              ),
              Center(
                child: SizedBox(
                  height: MediaQuery.of(context).size.height / 2.5,
                  width: MediaQuery.of(context).size.width,
                  child: BezierChart(
                    bezierChartScale: BezierChartScale.custom,
                    selectedValue: 1,
                    xAxisCustomValues: const [1, 5, 10, 15, 20, 25, 30],
                    series: const [
                      BezierLine(
                        label: "june",
                        lineColor: kPrimaryOrangeColor,
                        dataPointStrokeColor: kWhiteColor,
                        dataPointFillColor: kPrimaryOrangeColor,
                        lineStrokeWidth: 3,
                        data: [
                          DataPoint<double>(value: 100, xAxis: 1),
                          DataPoint<double>(value: 130, xAxis: 5),
                          DataPoint<double>(value: 300, xAxis: 10),
                          DataPoint<double>(value: 150, xAxis: 15),
                          DataPoint<double>(value: 75, xAxis: 20),
                          DataPoint<double>(value: 100, xAxis: 25),
                          DataPoint<double>(value: 250, xAxis: 30),
                        ],
                      ),
                    ],
                    config: BezierChartConfig(
                      startYAxisFromNonZeroValue: true,
                      verticalIndicatorFixedPosition: false,
                      bubbleIndicatorColor: kBlackColor,
                      bubbleIndicatorLabelStyle:
                          const TextStyle(color: kWhiteColor),
                      bubbleIndicatorTitleStyle:
                          const TextStyle(color: kWhiteColor),
                      bubbleIndicatorValueStyle:
                          const TextStyle(color: kWhiteColor),
                      footerHeight: 40,
                      displayYAxis: false,
                      stepsYAxis: 15,
                      displayLinesXAxis: false,
                      xAxisTextStyle: const TextStyle(
                        color: kBlackColor,
                      ),
                      backgroundGradient: const LinearGradient(
                        colors: [
                          kBlackColor,
                          kBlackColor,
                          kBlackColor,
                          kBlackColor
                        ],
                        begin: Alignment.topCenter,
                        end: Alignment.bottomCenter,
                      ),
                      snap: false,
                    ),
                  ),
                ),
              ),
              Row(
                children: [
                  Container(
                    height: 50,
                    width: MediaQuery.of(context).size.width / 3.4,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(20.0),
                      color: kPrimaryOrangeColor,
                    ),
                    child: Center(
                      child: Text(
                        "Apr to Jun",
                        style: GoogleFonts.roboto(
                          fontSize: 15,
                          fontWeight: FontWeight.w600,
                          color: kWhiteColor,
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(
                    width: 10,
                  ),
                  GraphCard(
                    title: Constants.strList[0],
                    activeColor: color,
                    fontColor: fcolor,
                    isActive: isActive,
                    activeIndex: 0,
                  ),
                  const SizedBox(
                    width: 10,
                  ),
                  GraphCard(
                    title: Constants.strList[1],
                    activeColor: color,
                    fontColor: fcolor,
                    isActive: isActive,
                    activeIndex: 1,
                  ),
                  const SizedBox(
                    width: 10,
                  ),
                  GraphCard(
                    title: Constants.strList[2],
                    activeColor: color,
                    fontColor: fcolor,
                    isActive: isActive,
                    activeIndex: 0,
                  ),
                ],
              ),
              const SizedBox(
                height: 20,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    "Income",
                    style: GoogleFonts.roboto(
                      fontSize: 15,
                      fontWeight: FontWeight.w500,
                      color: kGreyColor,
                    ),
                  ),
                  Row(
                    children: [
                      Text(
                        "75%",
                        style: GoogleFonts.roboto(
                          fontSize: 15,
                          fontWeight: FontWeight.w500,
                          color: kGreyColor,
                        ),
                      ),
                      const Icon(
                        Icons.arrow_downward,
                        color: kWhiteColor,
                      ),
                    ],
                  )
                ],
              ),
              const SizedBox(
                height: 20,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    "Outcome",
                    style: GoogleFonts.roboto(
                      fontSize: 15,
                      fontWeight: FontWeight.w500,
                      color: kGreyColor,
                    ),
                  ),
                  Row(
                    children: [
                      Text(
                        "25%",
                        style: GoogleFonts.roboto(
                          fontSize: 15,
                          fontWeight: FontWeight.w500,
                          color: kGreyColor,
                        ),
                      ),
                      const Icon(
                        Icons.arrow_upward,
                        color: kWhiteColor,
                      ),
                    ],
                  )
                ],
              ),
              const SizedBox(
                height: 10,
              )
            ],
          ),
        ),
      ),
    );
  }
}
