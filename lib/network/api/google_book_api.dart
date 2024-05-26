import 'dart:async';
import 'package:dio/dio.dart';
import 'package:playbooks_flutter/network/api_constants.dart';
import 'package:playbooks_flutter/network/responses/google_books_response.dart';
import 'package:retrofit/http.dart';
part 'google_book_api.g.dart';

@RestApi(baseUrl: kGoogleApiBaseUrl)
abstract class GoogleBooksApi {
  /// Dio as the parameter
  factory GoogleBooksApi(
    Dio dio,
  ) = _GoogleBooksApi;

  @GET(kEndPointSearchGoogleBooks)
  Future<GoogleBooksResponse> searchGoogleBooks(
    @Query(kParamQ) String query,
  );
}
