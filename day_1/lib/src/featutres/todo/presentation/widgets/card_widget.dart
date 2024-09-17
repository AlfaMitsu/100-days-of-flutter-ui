import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../../constants/colors.dart';

class CardWidget extends StatelessWidget {
  final int index;

  const CardWidget({
    super.key,
    required this.index,
  });

  @override
  Widget build(BuildContext context) {
    if (index == 0) {
      return Container(
        padding: const EdgeInsets.only(
          left: 5,
          right: 5,
        ),
        child: Container(
          height: 175,
          width: MediaQuery.of(context).size.width - 55,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(20),
            color: kPrimaryOrangeColor,
          ),
          child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  IconButton(
                    icon: const Icon(
                      Icons.credit_card,
                      color: kWhiteColor,
                    ),
                    onPressed: () {},
                    tooltip: 'KYC',
                  ),
                  Container(
                    padding: const EdgeInsets.only(
                        left: 15, top: 25, bottom: 10, right: 20),
                    child: Text(
                      'VISA',
                      style: GoogleFonts.roboto(
                        fontSize: 20,
                        fontWeight: FontWeight.w700,
                        color: kWhiteColor,
                      ),
                    ),
                  ),
                ],
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(
                    padding: const EdgeInsets.only(
                      left: 15,
                      top: 10,
                      bottom: 15,
                    ),
                    child: Text(
                      '4562 1122 4595 7852',
                      style: GoogleFonts.roboto(
                        fontSize: 18,
                        fontWeight: FontWeight.w600,
                        color: kWhiteColor,
                      ),
                    ),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Container(
                            padding: const EdgeInsets.only(
                              left: 15,
                              top: 25,
                              bottom: 10,
                              right: 20,
                            ),
                            child: Text(
                              'CARD HOLDER',
                              style: GoogleFonts.roboto(
                                fontSize: 7,
                                fontWeight: FontWeight.w500,
                                color: kWhiteColor,
                              ),
                            ),
                          ),
                          Container(
                            padding: const EdgeInsets.only(
                              left: 15,
                              top: 0,
                              bottom: 10,
                              right: 20,
                            ),
                            child: Text(
                              'Ghulam',
                              style: GoogleFonts.roboto(
                                fontSize: 12,
                                fontWeight: FontWeight.w600,
                                color: kWhiteColor,
                              ),
                            ),
                          ),
                        ],
                      ),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Container(
                            padding: const EdgeInsets.only(
                              left: 15,
                              top: 25,
                              bottom: 10,
                              right: 20,
                            ),
                            child: Text(
                              'Expiry Date',
                              style: GoogleFonts.roboto(
                                fontSize: 7,
                                fontWeight: FontWeight.w500,
                                color: kWhiteColor,
                              ),
                            ),
                          ),
                          Container(
                            padding: const EdgeInsets.only(
                              left: 15,
                              top: 0,
                              bottom: 10,
                              right: 20,
                            ),
                            child: Text(
                              '24/2020',
                              style: GoogleFonts.roboto(
                                fontSize: 12,
                                fontWeight: FontWeight.w600,
                                color: kWhiteColor,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ],
              ),
            ],
          ),
        ),
      );
    } else if (index == 1) {
      return Container(
        padding: const EdgeInsets.only(
          left: 5,
          right: 15,
        ),
        child: Container(
          height: 175,
          width: MediaQuery.of(context).size.width - 55,
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(20),
              gradient: const LinearGradient(
                colors: [
                  kBlackColor,
                  kSecondaryOrangeColor,
                ],
                begin: Alignment.topCenter,
                end: Alignment.centerRight,
              )),
          child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  IconButton(
                    icon: const Icon(
                      Icons.credit_card,
                      color: kWhiteColor,
                    ),
                    onPressed: () {},
                    tooltip: 'KYC',
                  ),
                  Container(
                    padding: const EdgeInsets.only(
                      left: 15,
                      top: 25,
                      bottom: 10,
                      right: 20,
                    ),
                    child: Text(
                      'VISA',
                      style: GoogleFonts.roboto(
                        fontSize: 20,
                        fontWeight: FontWeight.w700,
                        color: kWhiteColor,
                      ),
                    ),
                  ),
                ],
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(
                    padding: const EdgeInsets.only(
                      left: 15,
                      top: 10,
                      bottom: 15,
                    ),
                    child: Text(
                      '4562 1122 4595 7852',
                      style: GoogleFonts.roboto(
                        fontSize: 18,
                        fontWeight: FontWeight.w600,
                        color: kWhiteColor,
                      ),
                    ),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Container(
                            padding: const EdgeInsets.only(
                                left: 15, top: 25, bottom: 10, right: 20),
                            child: Text(
                              'CARD HOLDER',
                              style: GoogleFonts.roboto(
                                fontSize: 7,
                                fontWeight: FontWeight.w500,
                                color: kWhiteColor,
                              ),
                            ),
                          ),
                          Container(
                            padding: const EdgeInsets.only(
                                left: 15, top: 0, bottom: 10, right: 20),
                            child: Text(
                              'Ghulam',
                              style: GoogleFonts.roboto(
                                fontSize: 12,
                                fontWeight: FontWeight.w600,
                                color: kWhiteColor,
                              ),
                            ),
                          ),
                        ],
                      ),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Container(
                            padding: const EdgeInsets.only(
                                left: 15, top: 25, bottom: 10, right: 20),
                            child: Text(
                              'Expiry Date',
                              style: GoogleFonts.roboto(
                                fontSize: 7,
                                fontWeight: FontWeight.w500,
                                color: kWhiteColor,
                              ),
                            ),
                          ),
                          Container(
                            padding: const EdgeInsets.only(
                                left: 15, top: 0, bottom: 10, right: 20),
                            child: Text(
                              '24/2020',
                              style: GoogleFonts.roboto(
                                fontSize: 12,
                                fontWeight: FontWeight.w600,
                                color: kWhiteColor,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ],
              ),
            ],
          ),
        ),
      );
    } else {
      return const Text(
        'Invalid Card Index',
        style: TextStyle(color: kBlackColor),
      );
    }
  }
}
