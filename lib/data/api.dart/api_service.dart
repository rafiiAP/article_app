import 'dart:convert';

import 'package:http/http.dart' as http;

import '../model/article.dart';

// class ApiService {
//   static const String _baseUrl = 'https://newsapi.org/v2/';
//   static const String _apiKey = '6cf8734e1f6e4cffb3075aca6c5f0937';
//   static const String _category = 'business';
//   static const String _country = 'us';

//   Future<ArticlesResult> topHeadlines() async {
//     final response = await http.get(Uri.parse(
//         "${_baseUrl}top-headlines?country=$_country&category=$_category&apiKey=$_apiKey"));
//     if (response.statusCode == 200) {
//       print(response.body);
//       return articleresultFromJson(response.body);
//     } else {
//       throw Exception('Failed to load top headlines');
//     }
//   }
// }

class ApiService {
  static const String _baseUrl = 'https://newsapi.org/v2/';
  static const String _apiKey = '6cf8734e1f6e4cffb3075aca6c5f0937';
  static const String _category = 'business';
  static const String _country = 'us';

  Future<ArticlesResult> topHeadlines() async {
    final response = await http.get(Uri.parse(
        "${_baseUrl}top-headlines?country=$_country&category=$_category&apiKey=$_apiKey"));
    if (response.statusCode == 200) {
      return ArticlesResult.fromJson(json.decode(response.body));
    } else {
      throw Exception('Failed to load top headlines');
    }
  }
}
