import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:flutter_noticias_practica/src/models/news_model.dart';

final _URL_NEWS = 'http://newsapi.org/v2';
final _APIKEY = '24fa35b768ab4320980b82dfb4ccc49a';

class NewsService with ChangeNotifier {

  List<Article> headlines = [];

  NewsService() {
    this.getTopHeadlines();
  }

  getTopHeadlines() async {

    final url = '$_URL_NEWS/top-headlines?apiKey=$_APIKEY&sources=techcrunch';
    final response = await http.get(url);

    final newsResponse = newsResponseFromJson(response.body);

    this.headlines.addAll(newsResponse.articles);

    notifyListeners();

  }

}