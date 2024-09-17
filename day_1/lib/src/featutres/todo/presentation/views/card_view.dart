import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../../constants/colors.dart';
import '../../../../constants/constants.dart';
import '../widgets/card_widget.dart';
import '../widgets/transaction_list.dart';

class CardView extends StatelessWidget {
  const CardView({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.only(
              left: 20,
              right: 20,
              top: 35,
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Icon(
                      Icons.arrow_back_ios,
                      color: kWhiteColor,
                    ),
                    Icon(
                      Icons.more_vert,
                      color: kWhiteColor,
                    ),
                  ],
                ),
                const SizedBox(
                  height: 35,
                ),
                Text(
                  'Your Cards',
                  style: GoogleFonts.roboto(
                    fontSize: 25,
                    fontWeight: FontWeight.w700,
                    color: kWhiteColor,
                  ),
                ),
                const SizedBox(
                  height: 5,
                ),
                Text(
                  'You have 3 Active Cards',
                  style: GoogleFonts.roboto(
                    fontSize: 13,
                    fontWeight: FontWeight.w500,
                    color: kGreyColor,
                  ),
                ),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(
              left: 3,
              right: 15,
              top: 30,
            ),
            child: SizedBox(
              height: 175,
              child: ListView.builder(
                scrollDirection: Axis.horizontal,
                shrinkWrap: false,
                itemCount: 2,
                itemBuilder: (context, index) {
                  return CardWidget(
                    index: index,
                  );
                },
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(
              left: 20,
              right: 20,
              top: 20,
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "Recent Transactions",
                  style: GoogleFonts.roboto(
                    fontSize: 18,
                    fontWeight: FontWeight.w700,
                    color: kWhiteColor,
                  ),
                ),
                const SizedBox(
                  height: 20,
                ),
                Column(
                  children: List.generate(
                    Constants.titleList.length,
                    (index) {
                      return TransactionList(
                        icon: Constants.iconList[index],
                        titleTxt: Constants.titleList[index],
                        subtitleTxt: Constants.subtitleList[index],
                        amount: Constants.amountList[index],
                      );
                    },
                  ),
                ),
                const SizedBox(
                  height: 10,
                )
              ],
            ),
          )
        ],
      ),
    );
  }
}
