import 'package:dartz/dartz.dart';
import '../../../../core/errors/failures.dart';
import '../models/book_model.dart';

abstract class HomeRepo{
 Future<Either<Failure,BookModel>> fetchNewestBooks({required int startIndex});
 Future<Either<Failure,BookModel>> fetchFeaturedBooks();
 Future<Either<Failure,BookModel>> fetchSimilarBooks(
     {required String category});
}
