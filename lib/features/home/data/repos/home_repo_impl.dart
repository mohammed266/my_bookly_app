import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import '../../../../core/models/book_model.dart';
import '../../../../core/utils/api_service.dart';
import '../../../../core/errors/failures.dart';
import 'home_repo.dart';

class HomeRepoImpl implements HomeRepo {
  ApiService apiService;
  HomeRepoImpl(this.apiService);
  @override
  Future<Either<Failure,BookModel>> fetchNewestBooks({required int startIndex}) async {
    try {
      var data = await apiService.get(
          endPoint:
          'volumes?Filtering=free-ebooks&Sorting=newest&q=programming&startIndex=$startIndex'
          // 'volumes?Filtering=free-ebooks&q=computer science'
      );
      // List<BookModel> books = [];
      // for (var item in data['items']) {
      //   books.add(BookModel.fromJson(item));
      // }
      BookModel books = BookModel.fromJson(data);
      return right(books);
    } catch (e) {
      if(e is DioException){
        return Left(ServerFailure.fromDioError(e));
      }

      return Left(ServerFailure(e.toString()));
    }
  }

  @override
  Future<Either<Failure,BookModel>> fetchFeaturedBooks()async {
    try {
      var data = await apiService.get(
          endPoint: 'volumes?Filtering=free-ebooks&q=computer science'
          // 'volumes?&q=subject:programming'
      );
      // List<BookModel> books = [];
      // for (var item in data['items']) {
      //   books.add(BookModel.fromJson(item));
      // }
      BookModel books = BookModel.fromJson(data);
      return right(books);
    } catch (e) {
      if(e is DioException){
        return Left(ServerFailure.fromDioError(e));
      }

      return Left(ServerFailure(e.toString()));
    }
  }

  @override
  Future<Either<Failure,BookModel>> fetchSimilarBooks({required String category}) async{
    try {
      var data = await apiService.get(
          endPoint:  'volumes?Filtering=free-ebooks&Sorting=relevance&q=Subject:$category');

      // Programming
      // List<BookModel> books = [];
      // for (var item in data['items']) {
      //   books.add(BookModel.fromJson(item));
      // }
      BookModel books = BookModel.fromJson(data);
      return right(books);
    } catch (e) {
      if(e is DioException){
        return Left(ServerFailure.fromDioError(e));
      }

      return Left(ServerFailure(e.toString()));
    }
  }

  // @override
  // Future<Either<Failure, BookModel>> fetchSearchBook({required String searchKeyword}) async{
  //   try {
  //     var data = await apiService.get(
  //         endPoint:
  //         'volumes?Filtering=free-ebooks&Sorting=relevance&q=Subject:$searchKeyword');
  //     BookModel books = BookModel.fromJson(data);
  //     return right(books);
  //   } on Exception catch (e) {
  //     if (e is DioException) {
  //       return left(ServerFailure.fromDioException(e));
  //     }
  //
  //     return left(ServerFailure(e.toString()));
  //   }
  // }
}



