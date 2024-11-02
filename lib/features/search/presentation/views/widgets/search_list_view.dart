import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../../core/utils/styles.dart';
import '../../../../../core/widgets/custom_error_widget.dart';
import '../../../../../core/widgets/shimmer_best_seller.dart';
import '../../../../home/presentation/view/widgets/newest_book_list_view_item.dart';
import '../../manager/search_book_cubit/search_book_cubit.dart';

class SearchListView extends StatefulWidget {
  const SearchListView({
    super.key,
  });

  @override
  State<SearchListView> createState() => _SearchListViewState();
}

class _SearchListViewState extends State<SearchListView> {
  final ScrollController scrollController = ScrollController();
  //late List<Items> bookItems = [];
  late int startIndex = 0;

  @override
  void initState() {
    scrollController.addListener(_onScroll);
    super.initState();
  }

  void _onScroll() {
    if (scrollController.position.pixels ==
        scrollController.position.maxScrollExtent) {
      startIndex += 10; // Increment the index
      BlocProvider.of<SearchBookCubit>(context).fetchSearchBook(
          searchKeyword: BlocProvider.of<SearchBookCubit>(context).searchKey,
          startIndex: startIndex,
      );
    }
  }

  @override
  void dispose() {
    scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: BlocBuilder<SearchBookCubit, SearchBookState>(
        builder: (context, state) {
          var bookItems = BlocProvider.of<SearchBookCubit>(context).loadedBooks;

          if (state is SearchBookSuccess) {
            bookItems = state.bookModel.items!;
          } else if (state is SearchBookFailure) {
            return CustomErrorWidget(errMessage: state.errMessage);
          } else if (state is SearchBookInitial) {
            return Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                const Icon(
                  Icons.image_search_outlined,
                  size: 50,
                  color: Colors.grey,
                ),
                const SizedBox(
                  height: 20,
                ),
                Text(
                  'Enter Book Name',
                  textAlign: TextAlign.center,
                  style: Styles.textStyle20.copyWith(color: Colors.grey),
                ),
              ],
            );
          }
          return ListView.builder(
            controller: scrollController,
            physics: const BouncingScrollPhysics(),
            padding: EdgeInsets.zero,
            itemCount: bookItems.length + 1,
            itemBuilder: (context, index) {
              if (index < bookItems.length) {
                return Padding(
                  padding: const EdgeInsets.only(
                    bottom: 20,
                  ),
                  child: NewestBooksListViewItem(
                    bookModel: bookItems[index],
                  ),
                );
              } else {
                // Display shimmer loading at the end of the list
                return const ShimmerBestSellerItem();
              }
            },
          );
        },
      ),
    );
  }
}
