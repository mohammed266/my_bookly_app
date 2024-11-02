import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import '../../../../../core/models/book_model.dart';
import '../../../../../core/utils/styles.dart';

class BookRating extends StatelessWidget {
  const BookRating({
    super.key,
    this.mainAxisAlignment = MainAxisAlignment.start,
    required this.bookModel,
  });
  final MainAxisAlignment mainAxisAlignment;
  final Items bookModel;
  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: mainAxisAlignment,
      children: [
        const Icon(
          size: 14,
          FontAwesomeIcons.solidStar,
          color: Color(0xffFFDD4F),
        ),
        const SizedBox(width: 6),
        Text(
          bookModel.volumeInfo!.averageRating != null
              ? bookModel.volumeInfo!.averageRating.toString()
              : '0',
          style: Styles.textStyle16,
        ),
        const SizedBox(width: 5),
        Opacity(
          opacity: .5,
          child: Text(
            bookModel.volumeInfo!.ratingsCount != null
                ? '(${bookModel.volumeInfo!.ratingsCount.toString()})'
                : '(0)',
            style: Styles.textStyle14,
          ),
        ),
      ],
    );
  }
}
