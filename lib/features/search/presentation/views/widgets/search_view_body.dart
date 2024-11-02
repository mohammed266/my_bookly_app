import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'search_list_view.dart';

import '../../../../../core/utils/styles.dart';
import '../../manager/search_book_cubit/search_book_cubit.dart';
import 'custom_search_text_field.dart';

class SearchViewBody extends StatefulWidget {
  const SearchViewBody({super.key});

  @override
  State<SearchViewBody> createState() => _SearchViewBodyState();
}

class _SearchViewBodyState extends State<SearchViewBody> {
  TextEditingController controller = TextEditingController();
  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          CustomSearchTextField(
            controller: controller,
            onPressed: () {
              if (controller.text.isEmpty) {
                ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                  content: Text('Please, Enter book name!'),
                ));
              } else {
                BlocProvider.of<SearchBookCubit>(context).loadedBooks.clear();
                BlocProvider.of<SearchBookCubit>(context).searchKey =
                    controller.text;
                BlocProvider.of<SearchBookCubit>(context).fetchSearchBook(
                    searchKeyword: controller.text, startIndex: 0);
              }
            },
          ),
          const Padding(
            padding: EdgeInsets.symmetric(vertical: 16),
            child: Text(
              'Search Result :',
              style: Styles.textStyle18,
            ),
          ),
          const Expanded(
            child: SearchListView(),
          ),
        ],
      ),
    );
  }
}
