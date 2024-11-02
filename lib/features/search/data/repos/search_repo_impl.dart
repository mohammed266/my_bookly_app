import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';

import '../../../../core/errors/failures.dart';

import '../../../../core/models/book_model.dart';
import '../../../../core/utils/api_service.dart';

import 'search_repo.dart';

class SearchRepoImpl implements SearchRepo {
  ApiService apiService;
  SearchRepoImpl(this.apiService);
  @override
  Future<Either<Failure, BookModel>> fetchSearchBook(
      {required String searchKeyword, required int startIndex}) async {
    try {
      var data = await apiService.get(
        endPoint:
            'volumes?Filtering=free-ebooks&Sorting=newest&q=$searchKeyword&startIndex=$startIndex',
      );

      BookModel books = BookModel.fromJson(data);
      // List<BookModel> books = [];
      // for (var item in data['items']) {
      //   books.add(BookModel.fromJson(item));
      // }
      return Right(books);
    } catch (e) {
      if (e is DioException) {
        return Left(ServerFailure.fromDioError(e));
      }

      return Left(ServerFailure(e.toString()));
    }
  }
}
