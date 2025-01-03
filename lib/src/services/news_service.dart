import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:http/http.dart' as http;
import 'package:noticias/src/models/categories.dart';
import '../models/news_models.dart';

const _urlNews = 'https://newsapi.org/v2';
const _apiKey = '4ab7e01d41c54bdb9ba30bafbf2ac919';

class NewsService with ChangeNotifier {
  List<Article> headlines = [];
  String _selectedCategory = 'business';
  bool isLoad = false;
  String _country= 'us';

  String get selectedCategory => _selectedCategory;

  set selectedCategory(String value) {
    _selectedCategory = value;
    getArticlesByCategory(value);
  }

  Map<String, List<Article>> categoryArticles = {};
  assignCategoryArticles(String category, List<Article> articles) {
    categoryArticles[category] = articles;
  }

  List<Article> get selectedCategoryArticles {
    return categoryArticles[_selectedCategory]!;
  }

  clearKeyCategory() {
    for (var category in categories) {
      categoryArticles[category.name] = [];
    }
  }

  List<Categories> categories = [
    Categories(icon: FontAwesomeIcons.building, name: 'business'),
    Categories(icon: FontAwesomeIcons.volleyball, name: 'sports'),
    Categories(icon: FontAwesomeIcons.vials, name: 'science'),
    Categories(icon: FontAwesomeIcons.memory, name: 'technology'),
    Categories(icon: FontAwesomeIcons.headSideVirus, name: 'health'),
    Categories(icon: FontAwesomeIcons.tv, name: 'entertainment'),
  ];

  NewsService() {
    getTopHeadlines();
    clearKeyCategory();
    getArticlesByCategory(selectedCategory);
  }

  getTopHeadlines() async {
  var url = '$_urlNews/top-headlines?country=$_country&apiKey=$_apiKey';
    final resp = await http.get(Uri.parse(url));
    final newsResponse = newsModelFromJson(resp.body);

    headlines.addAll(newsResponse.articles);
    notifyListeners();
  }

  getArticlesByCategory([String category = 'business']) async {
    if (categoryArticles[category]!.isNotEmpty) {
      categoryArticles[category];
      notifyListeners();
      return;
    }

    isLoad = true;
    notifyListeners();
    final url =
        '$_urlNews/top-headlines?country=$_country&apiKey=$_apiKey&category=$category';
    final resp = await http.get(Uri.parse(url));
    final newsResponse = newsModelFromJson(resp.body);
    assignCategoryArticles(category, newsResponse.articles);
    isLoad = false;
    notifyListeners();
  }
}
