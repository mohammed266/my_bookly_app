part of 'search_book_cubit.dart';

@immutable
sealed class SearchBookState {}

final class SearchBookInitial extends SearchBookState {}

final class SearchBookLoading extends SearchBookState {}

final class SearchBookSuccess extends SearchBookState {
  final BookModel bookModel;

  SearchBookSuccess(this.bookModel);
}

final class SearchBookFailure extends SearchBookState {
  final String errMessage;

  SearchBookFailure(this.errMessage);
}
