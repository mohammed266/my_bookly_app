import 'package:flutter/foundation.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../../core/models/book_model.dart';
import '../../../data/repos/search_repo.dart';


part 'search_book_state.dart';

class SearchBookCubit extends Cubit<SearchBookState> {
  SearchBookCubit(this.searchRepo) : super(SearchBookInitial());

  SearchRepo searchRepo;
  List<Items> loadedBooks = [];
  String searchKey= '';

  Future<void> fetchSearchBook(
      {required String searchKeyword, required int startIndex}) async {
    emit(SearchBookLoading());
    var result = await searchRepo.fetchSearchBook(searchKeyword: searchKeyword, startIndex: startIndex);

    result.fold((failure) {
      emit(SearchBookFailure(failure.errMessage));
    }, ( books) {
      loadedBooks.addAll(books.items as Iterable<Items>);
      emit(SearchBookSuccess(books));
    });
  }
}
