import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../../../../core/models/book_model.dart';
import '../../../../../core/utils/styles.dart';
import 'book_rating.dart';
import 'custom_book_image.dart';

class NewestBooksListViewItem extends StatelessWidget {
  const NewestBooksListViewItem({super.key, required this.bookModel});
  final Items bookModel;
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        GoRouter.of(context).push(
          '/BookDetailsView',
          extra: bookModel,
        );
      },
      child: SizedBox(
        height: 120,
        child: Row(
          children: [
            CustomBookImage(
              imageUrl: bookModel.volumeInfo?.imageLinks?.thumbnail ?? "",
            ),
            const SizedBox(width: 20),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(
                    width: MediaQuery.of(context).size.width * .5,
                    child: Text(
                      bookModel.volumeInfo!.title?.isNotEmpty == true
                          ? bookModel.volumeInfo!.title!
                          : 'No Title',
                      style: Styles.textStyle20,
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                  const SizedBox(height: 3),
                  Text(
                    bookModel.volumeInfo!.authors?.isNotEmpty == true
                        ? bookModel.volumeInfo!.authors![0]
                        : 'Unknown',
                    style: Styles.textStyle14,
                  ),
                  const SizedBox(height: 3),
                  Row(
                    children: [
                      Text(
                        bookModel.saleInfo?.listPrice?.amount != null
                            ? '${bookModel.saleInfo!.listPrice!.amount!.round()} ${bookModel.saleInfo!.listPrice!.currencyCode}'
                            : 'Free',
                        style: Styles.textStyle20.copyWith(
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const Spacer(),
                      BookRating(
                        bookModel: bookModel,
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
