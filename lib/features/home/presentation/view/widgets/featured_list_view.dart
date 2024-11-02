import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import '../../../../../core/widgets/shimmer_featured.dart';
import '../../manger/featured_books_cubit/featured_books_cubit.dart';
import '../../manger/featured_books_cubit/featured_books_state.dart';

import '../../../../../core/widgets/custom_error_widget.dart';
import 'custom_book_item.dart';

class FeaturedBooksListView extends StatelessWidget {
  const FeaturedBooksListView({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<FeaturedBooksCubit, FeaturedBooksState>(
      builder: (context, state) {
        if (state is FeaturedBooksSuccess) {
          return SizedBox(
            height: MediaQuery.of(context).size.height * .3,
            child: ListView.builder(
              physics: const BouncingScrollPhysics(),
              scrollDirection: Axis.horizontal,
              itemCount: state.booKs.items?.length,
              itemBuilder: (context, index) => Padding(
                padding: const EdgeInsets.only(right: 10),
                child: InkWell(
                  onTap: () {
                    GoRouter.of(context).push(
                      '/BookDetailsView',
                      extra: state.booKs.items![index],
                    );
                  },
                  child: CustomBookItem(
                    imageUrl:
                    state.booKs.items![index].volumeInfo?.imageLinks
                        ?.thumbnail
                        .toString() ??
                            "",
                  ),
                ),
              ),
            ),
          );
        } else if (state is FeaturedBooksFailure) {
          return CustomErrorWidget(
            errMessage: state.errMessage,
          );
        } else {
          return SizedBox(
            height: MediaQuery.of(context).size.height *0.3,
            child: ListView.builder(
              scrollDirection: Axis.horizontal,
              itemBuilder: (_, i) => const Padding(
                padding: EdgeInsets.symmetric(horizontal: 8.0),
                child: ShimmerFeaturedList(),
              ),
              itemCount: 3,
            ),
          );
        }
      },
    );
  }
}
