import 'dart:convert';

import 'package:newsapp/constants/api.dart';
import 'package:newsapp/models/news_model.dart';
import 'package:http/http.dart' as http;

class HttpNewsRepository {
  Future<NewsModel> getNews(String query) async {
    try {
      var res = await http.get(Uri.parse(API.baseUrl +
          API.query +
          query +
          API.startDate +
          API.sortBy +
          API.apiKey));

      if (res.statusCode == 200) {
        return NewsModel.fromJson(json.decode(res.body));
      }
    } catch (e) {}

    throw "Error during ";
  }
}
