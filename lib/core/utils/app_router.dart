import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import '../../features/home/data/repos/home_repo_impl.dart';
import '../../features/search/data/repos/search_repo_impl.dart';
import '../../features/search/presentation/manager/search_book_cubit/search_book_cubit.dart';
import '../models/book_model.dart';
import 'service_locator.dart';

import '../../features/home/presentation/manger/similar_books_cubit/similar_books_cubit.dart';
import '../../features/home/presentation/view/book_details_view.dart';
import '../../features/home/presentation/view/home_view.dart';
import '../../features/search/presentation/views/search_view.dart';
import '../../features/splash/presentation/views/splash_view.dart';

abstract class AppRouter {

  static final GoRouter router = GoRouter(
    routes: <RouteBase>[
      GoRoute(
        path: '/',
        builder: (BuildContext context, GoRouterState state) {
          return const SplashView();
        },
      ),
      GoRoute(
        path: '/HomeView',
        pageBuilder: (context, state) {
          return CustomTransitionPage(
            transitionDuration: const Duration(
              seconds: 1,
            ),
            child: const HomeView(),
            transitionsBuilder:
                (context, animation, secondaryAnimation, child) {
              return SlideTransition(
                position: animation.drive(
                  Tween(
                    begin: const Offset(0, 1.5),
                    end: Offset.zero,
                  ).chain(
                    CurveTween(curve: Curves.ease),
                  ),
                ),
                child: FadeTransition(
                  opacity: CurveTween(curve: Curves.easeInOutCirc)
                      .animate(animation),
                  child: child,
                ),
              );
            },
          );
        },
      ),
      // GoRoute(
      //   path: '/HomeView',
      //   builder: (BuildContext context, GoRouterState state) {
      //     return const HomeView();
      //   },
      // ),
      GoRoute(
        path: '/BookDetailsView',
        pageBuilder: (context, state) {
          return CustomTransitionPage(
            transitionDuration: const Duration(
              milliseconds: 450,
            ),
            child: BlocProvider(
              create: (context) => SimilarBooksCubit(getIt.get<HomeRepoImpl>()),
              child: BookDetailsView(
                bookModel: state.extra as Items,
              ),
            ),
            transitionsBuilder:
                (context, animation, secondaryAnimation, child) {
              return SlideTransition(
                position: animation.drive(
                  Tween(
                    begin: const Offset(1.5, 0),
                    end: Offset.zero,
                  ).chain(
                    CurveTween(curve: Curves.ease),
                  ),
                ),
                child: child,
              );
            },
          );
        },
      ),
      // GoRoute(
      //   path: '/BookDetailsView',
      //   builder: (BuildContext context, GoRouterState state) {
      //     return BlocProvider(
      //       create: (context) => SimilarBooksCubit(getIt.get<HomeRepoImpl>()),
      //       child: BookDetailsView(
      //         bookModel: state.extra as Items,
      //       ),
      //     );
      //   },
      // ),
      GoRoute(
        path: '/SearchView',
        pageBuilder: (context, state) {
          return CustomTransitionPage(
            transitionDuration: const Duration(
              milliseconds: 150,
            ),
            child: BlocProvider(
              create: (BuildContext context) => SearchBookCubit(getIt.get<SearchRepoImpl>()),
              child: const SearchView(),
            ),
            transitionsBuilder:
                (context, animation, secondaryAnimation, child) {
              return FadeTransition(
                opacity:
                CurveTween(curve: Curves.easeInOutCirc).animate(animation),
                child: child,
              );
            },
          );
        },
      ),
      // GoRoute(
      //   path: '/SearchView',
      //   builder: (BuildContext context, GoRouterState state) {
      //     return const SearchView();
      //   },
      // ),
    ],
  );

}

