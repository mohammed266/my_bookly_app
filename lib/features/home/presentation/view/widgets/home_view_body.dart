import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../../core/utils/styles.dart';
import '../../manger/featured_books_cubit/featured_books_cubit.dart';
import '../../manger/newest_books_cubit/newest_books_cubit.dart';
import 'custom_appbar.dart';
import 'featured_list_view.dart';
import 'newest_books_list_view.dart';

class HomeViewBody extends StatefulWidget {
  const HomeViewBody({super.key});

  @override
  State<HomeViewBody> createState() => _HomeViewBodyState();
}

class _HomeViewBodyState extends State<HomeViewBody> {
  final ScrollController scrollController = ScrollController();

  int startIndex = 0;

  @override
  void initState() {
    super.initState();
    scrollController.addListener(_onScroll);
  }

  void _onScroll() {
    if (scrollController.position.pixels == scrollController.position.maxScrollExtent) {
      // User reached the end of the list, fetch more data
      startIndex += 10; // Increment the index
      BlocProvider.of<NewestBooksCubit>(context)
          .fetchNewestBooks(startIndex: startIndex);
    }
  }

  @override
  void dispose() {
    print("#");
    scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return RefreshIndicator(
      onRefresh: () {
        return refreshAllData(context);
      },
      child:  const CustomScrollView(
        physics: BouncingScrollPhysics(),
        slivers: [
          SliverToBoxAdapter(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 16),
                  child: CustomAppBar(),
                ),
                FeaturedBooksListView(),
                SizedBox(
                  height: 20,
                ),
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 16),
                  child: Text(
                    'Newest Books',
                    style: Styles.textStyle18,
                  ),
                ),
                SizedBox(height: 10),

              ],
            ),
          ),
          SliverFillRemaining(
            child:  Padding(
              padding: EdgeInsets.symmetric(horizontal: 16,),
              child: NewestBooksListView(),
            ),
          ),
          SliverToBoxAdapter(
            child: SizedBox(
              height: 20,
            ),
          ),
        ],
      ),
    );
  }
}
Future<void> refreshAllData(context) async
{
  BlocProvider.of<NewestBooksCubit>(context).loadedBooks.clear();
  BlocProvider.of<NewestBooksCubit>(context).fetchNewestBooks(startIndex: 0);
  BlocProvider.of<FeaturedBooksCubit>(context).fetchFeaturedBooks();
}

