import 'package:day_1/src/constants/colors.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class Constants {
  static List<Icon> iconList = [
    const Icon(
      Icons.mail_outline,
      color: kWhiteColor,
    ),
    const Icon(
      FontAwesomeIcons.paypal,
      color: kWhiteColor,
    ),
    const Icon(
      CupertinoIcons.settings,
      color: kWhiteColor,
    ),
  ];

  static List<String> titleList = [
    "Salary",
    "Paypal",
    "Car Repair",
  ];

  static List<String> subtitleList = [
    "Belong Interactive",
    "Webtech",
    "Car Engine repair",
  ];

  static List<int> amountList = [
    2010,
    12010,
    232010,
  ];

  static List<String> strList = [
    "1 \n Month",
    "6 \n Month",
    "1 \n Year",
  ];
}
