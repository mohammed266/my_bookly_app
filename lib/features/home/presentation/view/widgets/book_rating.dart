


import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import '../../../../../core/utils/styles.dart';

class BookRating extends StatelessWidget {
  const BookRating({super.key, this.mainAxisAlignment=MainAxisAlignment.start,});
  final MainAxisAlignment mainAxisAlignment;
  // final double rating;
  // final int count;
  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment:mainAxisAlignment,
      children: const [
        Icon(
          size: 14,
          FontAwesomeIcons.solidStar,
          color: Color(0xffFFDD4F),
        ),
        SizedBox(width: 6),
        Text(
          '4.9',
          style: Styles.textStyle16,
        ),
        SizedBox(width: 5),
        Opacity(
          opacity: .5,
          child: Text(
            '254',
            style: Styles.textStyle14,
          ),
        ),
      ],
    );
  }
}