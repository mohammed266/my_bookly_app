import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../../core/widgets/custom_error_widget.dart';
import '../../../../../core/widgets/custom_loading_indicator.dart';

import '../../manger/similar_books_cubit/similar_books_cubit.dart';
import 'custom_book_item.dart';

class SimilarBooksListView extends StatelessWidget {
  const SimilarBooksListView({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<SimilarBooksCubit, SimilarBooksState>(
      builder: (context, state) {
        if (state is SimilarBooksSuccess) {
          return SizedBox(
            height: MediaQuery
                .of(context)
                .size
                .height * .17,
            child: ListView.builder(
              scrollDirection: Axis.horizontal,
              itemCount: state.books.items?.length,
              itemBuilder: (context, index) =>
               Padding(
                padding: const EdgeInsets.only(right: 9),
                child: CustomBookItem(
                  imageUrl: state.books.items?[index].volumeInfo!.imageLinks?.thumbnail ?? "",
                  // imageUrl: "https://www.columbiactlibrary.org/wp-content/uploads/2012/10/books.png",
                ),
              ),
            ),
          );
        }else if(state is SimilarBooksFailure){
          return CustomErrorWidget(errMessage: state.errMessage);
        } else{
          return const CustomLoadingIndicator();
        }
      },
    );
  }
}
