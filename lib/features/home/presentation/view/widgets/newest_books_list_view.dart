import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../../core/widgets/shimmer_best_seller.dart';
import '../../manger/newest_books_cubit/newest_books_cubit.dart';

import '../../../../../core/widgets/custom_error_widget.dart';
import 'newest_book_list_view_item.dart';

class NewestBooksListView extends StatelessWidget {
  const NewestBooksListView({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<NewestBooksCubit, NewestBooksState>(
      builder: (context, state) {
        if (state is NewestBooksSuccess) {
          return ListView.builder(
            physics: const NeverScrollableScrollPhysics(),
            padding: EdgeInsets.zero,
            itemBuilder: (context, index) => Padding(
              padding: const EdgeInsets.only(bottom: 20),
              child: NewestBooksListViewItem(
                bookModel: state.booKs.items![index],
              ),
            ),
            itemCount: state.booKs.items?.length,
          );
        } else if (state is NewestBooksFailure) {
          return CustomErrorWidget(
            errMessage: state.errMessage,
          );
        } else {
          return const ShimmerBestSeller();
        }
      },
    );
  }
}
