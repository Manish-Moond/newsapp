import 'dart:convert';

import 'package:newsapp/models/news_model.dart';
import 'package:shared_preferences/shared_preferences.dart';

class NewsLocalRepository {
  Future<void> saveArticle(Article article) async {
    final SharedPreferences sp = await SharedPreferences.getInstance();
    List<String> articleList = sp.getStringList("newsArticles") ?? [];
    articleList.add(jsonEncode(article.toJson()));
    sp.setStringList("newsArticles", articleList);
  }

  Future<List<Article>> getArticles() async {
    final SharedPreferences sp = await SharedPreferences.getInstance();
    try {
      List<String> alist = sp.getStringList("newsArticles") ?? [];
      List<Article> lst =
          alist.map((item) => Article.fromJson(json.decode(item))).toList();
      return lst;
    } catch (e) {
      throw "Error";
    }
  }

  Future<void> removeArticle(String url) async {
    final SharedPreferences sp = await SharedPreferences.getInstance();
    List<String> articleList = sp.getStringList("newsArticles") ?? [];
    List<Article> lst =
        articleList.map((item) => Article.fromJson(json.decode(item))).toList();
    List<Article> newlst = [];
    for (int i = 0; i < articleList.length; i++) {
      if (lst[i].url != url) {
        newlst.add(lst[i]);
      }
    }
    articleList = newlst.map((e) => jsonEncode(e.toJson())).toList();
    sp.setStringList("newsArticles", articleList);
  }
}
