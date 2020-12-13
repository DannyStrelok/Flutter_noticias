import 'package:flutter/material.dart';
import 'package:flutter_noticias_practica/src/models/category_model.dart';
import 'package:http/http.dart' as http;
import 'package:flutter_noticias_practica/src/models/news_model.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

final _URL_NEWS = 'http://newsapi.org/v2';
final _APIKEY = '24fa35b768ab4320980b82dfb4ccc49a';

class NewsService with ChangeNotifier {

  List<Article> headlines = [];
  String _selectedCategory = 'business';

  bool _isLoading = true;
  
  List<Category> categories = [
    Category(FontAwesomeIcons.building, 'business'),
    Category(FontAwesomeIcons.tv, 'entertainment'),
    Category(FontAwesomeIcons.addressCard, 'general'),
    Category(FontAwesomeIcons.headSideVirus, 'health'),
    Category(FontAwesomeIcons.vials, 'science'),
    Category(FontAwesomeIcons.volleyballBall, 'sports'),
    Category(FontAwesomeIcons.memory, 'technology'),
  ];

  Map<String, List<Article>> categoryArticles = {};

  NewsService() {
    this.getTopHeadlines();

    categories.forEach((element) {
      this.categoryArticles[element.name] = new List();
    });

  }

  bool get isLoading => this._isLoading;

  String get selectedCategory => _selectedCategory;

  set selectedCategory(String value) {
    _selectedCategory = value;
    this._isLoading = true;
    this.getArticlesByCategory(value);
    notifyListeners();
  }

  get getArticlesBySelectedCategory => this.categoryArticles[this.selectedCategory];

  getTopHeadlines() async {

    final url = '$_URL_NEWS/top-headlines?apiKey=$_APIKEY&country=us';
    final response = await http.get(url);

    final newsResponse = newsResponseFromJson(response.body);

    this.headlines.addAll(newsResponse.articles);

    notifyListeners();

  }

  getArticlesByCategory( String category) async {

    if( this.categoryArticles[category].length > 0 ) {
      this._isLoading = false;
      return this.categoryArticles[category];
    }

    final url = '$_URL_NEWS/top-headlines?apiKey=$_APIKEY&country=us&category=$category';
    final response = await http.get(url);

    final newsResponse = newsResponseFromJson(response.body);
    this.categoryArticles[category].addAll(newsResponse.articles);
    this._isLoading = false;
    notifyListeners();
  }

}