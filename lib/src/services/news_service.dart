import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:http/http.dart' as http;
import 'package:noticias/src/models/categories.dart';
import '../models/news_models.dart';

const _urlNews = 'https://newsapi.org/v2';
const _apiKey = '4ab7e01d41c54bdb9ba30bafbf2ac919';

class NewsService with ChangeNotifier {
  List<Article> headlines = [];

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
  }

  getTopHeadlines() async {
    const url = '$_urlNews/top-headlines?country=co&apiKey=$_apiKey';
    final resp = await http.get(Uri.parse(url));
    final newsResponse = newsModelFromJson(resp.body);

    headlines.addAll(newsResponse.articles);
    notifyListeners();
  }
}
