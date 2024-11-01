import 'package:dio/dio.dart';

abstract class Failure {
  final String errMessage;

  Failure(this.errMessage);
}

class ServerFailure extends Failure {
  ServerFailure(super.errMessage);

  factory ServerFailure.fromDioError(DioException dioException) {
    switch (dioException.type) {
      case DioExceptionType.connectionTimeout:
        return ServerFailure('Connection Time Out With Api Server');
      case DioExceptionType.sendTimeout:
        return ServerFailure('Send Time Out With Api Server');
      case DioExceptionType.receiveTimeout:
        return ServerFailure('Receive Time Out With Api Server');
      case DioExceptionType.badCertificate:
        return ServerFailure('Bad Certificate With Api Server');
      case DioExceptionType.badResponse:
        return ServerFailure.fromResponse(
          dioException.response!.statusCode!,
          dioException.response!.data,
        );
      case DioExceptionType.cancel:
        return ServerFailure('Request With Api Server Was Canceled');
      case DioExceptionType.connectionError:
        return ServerFailure('Connection Error With Api Server');
      case DioExceptionType.unknown:
        if (dioException.message!.contains("SocketException")) {
          return ServerFailure('No inter net connection');
        }
        return ServerFailure('UnExpected Error Please Try Again');

      default:
        return ServerFailure("Ops There Was an Error");
    }
  }

  factory ServerFailure.fromResponse(int statusCode, dynamic response) {
    if (statusCode == 400 || statusCode == 401 || statusCode == 403) {
      return ServerFailure(response["error"]["message"]);
    } else if (statusCode == 404) {
      return ServerFailure("Your Request Not Found, Please Try Again");
    } else if (statusCode == 500) {
      return ServerFailure("Internal Server Error, Please Try Again");
    } else {
      return ServerFailure("Ops There Was an Error");
    }
  }
}
