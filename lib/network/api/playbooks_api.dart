import 'dart:async';
import 'package:dio/dio.dart';
import 'package:playbooks_flutter/network/api_constants.dart';
import 'package:playbooks_flutter/network/responses/get_all_categories_response.dart';
import 'package:playbooks_flutter/network/responses/get_books_by_category_and_date_response.dart';
import 'package:retrofit/http.dart';
part 'playbooks_api.g.dart';

@RestApi(baseUrl: kBaseUrl)
abstract class PlaybooksApi {
  /// Dio as the parameter
  factory PlaybooksApi(
    Dio dio,
  ) = _PlaybooksApi;

  @GET(kEndPointGetAllBookList)
  Future<GetAllCategoriesResponse?> getAllCategoriesByDate(
    @Query(kParamApiKey) String apiKey,
  );

  @GET("$kEndPointGetBooksByListNameAndDate/{date}/{category}.json")
  Future<GetBooksByCategoryAndDateResponse?> getBooksByCategoryAndDate(
    @Query(kParamApiKey) String apiKey,
    @Path("date") String date,
    @Path("category") String category,
  );
}
