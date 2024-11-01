import 'package:flutter/material.dart';
import '../../../data/models/book_model.dart';
import 'books_details_section.dart';
import 'similar_books_section.dart';

import 'custom_book_details_appbar.dart';

class BookDetailsViewBody extends StatelessWidget {
  const BookDetailsViewBody({super.key, required this.bookModel});

  final BookModel bookModel;

  @override
  Widget build(BuildContext context) {
    return CustomScrollView(
      slivers: [
        SliverFillRemaining(
          hasScrollBody: false,
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                const CustomBookDetailsAppBar(),
                BooksDetailsSection(
                  bookModel: bookModel,
                ),
                const Expanded(child: SizedBox(height: 40)),
                const SimilarBooksSection(),
                const SizedBox(height: 20),
              ],
            ),
          ),
        )
      ],
    );
  }
}
