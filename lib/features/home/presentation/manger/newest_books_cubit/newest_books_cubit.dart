

import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../data/repos/home_repo.dart';

import '../../../../../core/models/book_model.dart';

part 'newest_books_state.dart';

class NewestBooksCubit extends Cubit<NewestBooksState> {
  NewestBooksCubit(this.homeRepo) : super(NewestBooksInitial());

  HomeRepo homeRepo;
  List<Items> loadedBooks = [];

  Future<void> fetchNewestBooks({required int startIndex})async{
    emit(NewestBooksLoading());
    var result = await homeRepo.fetchNewestBooks(startIndex: startIndex);

    result.fold((failure) {
      emit(NewestBooksFailure(failure.errMessage));
    }, (books) {
      loadedBooks.addAll(books.items as Iterable<Items>);
      emit(NewestBooksSuccess(books));
    });
  }
}
