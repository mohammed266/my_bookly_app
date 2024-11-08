import 'package:dartz/dartz.dart';
import '../../../../core/errors/failures.dart';
import '../../../../core/models/book_model.dart';

abstract class SearchRepo {
  Future<Either<Failure, BookModel>> fetchSearchBook({
    required String searchKeyword,
    required int startIndex,
  });
}
