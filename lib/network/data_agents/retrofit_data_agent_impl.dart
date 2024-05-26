import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:playbooks_flutter/data/vos/book_vo.dart';
import 'package:playbooks_flutter/data/vos/category_vo.dart';
import 'package:playbooks_flutter/data/vos/error_vo.dart';
import 'package:playbooks_flutter/data/vos/google_book/google_book_vo.dart';
import 'package:playbooks_flutter/exception/custom_exception.dart';
import 'package:playbooks_flutter/network/api/google_book_api.dart';
import 'package:playbooks_flutter/network/api/playbooks_api.dart';
import 'package:playbooks_flutter/network/api_constants.dart';
import 'package:playbooks_flutter/network/data_agents/playbooks_data_agent.dart';

class RetrofitDataAgentImpl extends PlaybooksDataAgent {
  late PlaybooksApi playbooksApi;
  late GoogleBooksApi googleBooksApi;

  //setup singleton
  static RetrofitDataAgentImpl? _singleton;

  factory RetrofitDataAgentImpl() {
    _singleton ??= RetrofitDataAgentImpl._internal();
    return _singleton!;
  }

  RetrofitDataAgentImpl._internal() {
    final dio = Dio();
    playbooksApi = PlaybooksApi(dio);
    googleBooksApi = GoogleBooksApi(dio);
  }

  @override
  Future<List<CategoryVO>> getAllCategories() {
    return playbooksApi
        .getAllCategoriesByDate(kApiKey)
        .asStream()
        .map((response) => response?.results?.lists ?? [])
        .first
        .catchError((error) {
      throw _createException(error);
    });
  }

  @override
  Future<List<BookVO>> getBooksByCategoryAndDate(String category, String date) {
    return playbooksApi
        .getBooksByCategoryAndDate(kApiKey, date, category)
        .asStream()
        .map((response) => response?.results?.books ?? [])
        .first
        .catchError((error) {
      throw _createException(error);
    });
  }

  CustomException _createException(dynamic error) {
    ErrorVO errorVO;
    if (error is DioException) {
      errorVO = _parseDioError(error);
    } else {
      errorVO = ErrorVO(
          statusCode: 0, statusMessage: "Unexpected Error", success: false);
    }
    return CustomException(errorVO);
  }

  ErrorVO _parseDioError(DioException error) {
    try {
      if (error.response != null && error.response?.data != null) {
        var data = error.response?.data;

        ///Json parsing to map<string,dynamic>
        if (data is String) {
          data = jsonDecode(data);
        }

        /// Map<String,dynamic> to ErrorVO
        return ErrorVO.fromJson(data);
      } else {
        return ErrorVO(
            statusCode: 0, statusMessage: "No response data", success: false);
      }
    } catch (e) {
      return ErrorVO(
          statusCode: 0,
          statusMessage: "Invalid DioException Format $e",
          success: false);
    }
  }

  @override
  Future<List<GoogleBookVO>> searchBooks(String query) {
    return googleBooksApi
        .searchGoogleBooks(query)
        .asStream()
        .map((response) => response.items ?? [])
        .first
        .catchError((error) {
      throw _createException(error);
    });
  }
}
