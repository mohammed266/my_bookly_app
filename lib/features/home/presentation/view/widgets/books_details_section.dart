import 'package:flutter/material.dart';

import '../../../../../core/models/book_model.dart';
import '../../../../../core/utils/styles.dart';
import 'book_rating.dart';
import 'books_actions.dart';
import 'custom_book_item.dart';

class BooksDetailsSection extends StatelessWidget {
  const BooksDetailsSection({super.key, required this.bookModel});

  final Items bookModel;

  @override
  Widget build(BuildContext context) {
    var width = MediaQuery.of(context).size.width;
    return Column(
      children: [
        const SizedBox(height: 10),
        Padding(
          padding: EdgeInsets.symmetric(horizontal: width * .25),
          child: CustomBookItem(
            // imageUrl: "https://www.columbiactlibrary.org/wp-content/uploads/2012/10/books.png",
            imageUrl: bookModel.volumeInfo?.imageLinks?.thumbnail ?? "",
          ),
        ),
        const SizedBox(height: 10),
        Text(
          bookModel.volumeInfo!.title != null ? bookModel.volumeInfo!.title! : 'No Title',
          style: Styles.textStyle25.copyWith(
            fontWeight: FontWeight.bold,
          ),
          textAlign: TextAlign.center,
        ),
        const SizedBox(height: 6),
        Opacity(
          opacity: .7,
          child: Text(
            // 'Rudyard Kipling',
            bookModel.volumeInfo!.authors?.isNotEmpty == true
                ? bookModel.volumeInfo!.authors![0]
                : 'Unknown',
            style: Styles.textStyle18.copyWith(
              fontWeight: FontWeight.w400,
              fontStyle: FontStyle.italic,
            ),
            textAlign: TextAlign.center,
          ),
        ),
        const SizedBox(height: 10),
         BookRating(
          bookModel: bookModel ,
          mainAxisAlignment: MainAxisAlignment.center,
        ),
        const SizedBox(height: 10),
        BooksActions(
          bookModel: bookModel,
        ),
      ],
    );
  }
}
