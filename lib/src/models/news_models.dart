// To parse this JSON data, do
//
//     final newsModel = newsModelFromJson(jsonString);

// ignore_for_file: constant_identifier_names

import 'dart:convert';

NewsModel newsModelFromJson(String str) => NewsModel.fromJson(json.decode(str));

String newsModelToJson(NewsModel data) => json.encode(data.toJson());

class NewsModel {
    String status;
    int totalResults;
    List<Article> articles;

    NewsModel({
        required this.status,
        required this.totalResults,
        required this.articles,
    });

    factory NewsModel.fromJson(Map<String, dynamic> json) => NewsModel(
        status: json["status"],
        totalResults: json["totalResults"],
        articles: List<Article>.from(json["articles"].map((x) => Article.fromJson(x))),
    );

    Map<String, dynamic> toJson() => {
        "status": status,
        "totalResults": totalResults,
        "articles": List<dynamic>.from(articles.map((x) => x.toJson())),
    };
}

class Article {
    Source source;
    String author;
    String title;
    dynamic description;
    String url;
    String urlToImage;
    DateTime publishedAt;
    dynamic content;

    Article({
        required this.source,
        required this.author,
        required this.title,
        required this.description,
        required this.url,
        required this.urlToImage,
        required this.publishedAt,
        required this.content,
    });

    factory Article.fromJson(Map<String, dynamic> json) => Article(
        source: Source.fromJson(json["source"]),
        author: json["author"] ?? 'Sin autor',
        title: json["title"],
        description: json["description"] ?? '',
        url: json["url"],
        urlToImage: json["urlToImage"] ?? '',
        publishedAt: DateTime.parse(json["publishedAt"]),
        content: json["content"] ?? '',
    );

    Map<String, dynamic> toJson() => {
        "source": source.toJson(),
        "author": author,
        "title": title,
        "description": description,
        "url": url,
        "urlToImage": urlToImage,
        "publishedAt": publishedAt.toIso8601String(),
        "content": content,
    };
}

class Source {
    Id id;
    Name name;

    Source({
        required this.id,
        required this.name,
    });

    factory Source.fromJson(Map<String, dynamic> json) => Source(
        id: idValues.map[json["id"]] ?? Id.GOOGLE_NEWS,
        name: nameValues.map[json["name"]] ?? Name.GOOGLE_NEWS,
    );

    Map<String, dynamic> toJson() => {
        "id": idValues.reverse[id],
        "name": nameValues.reverse[name],
    };
}

enum Id {
    GOOGLE_NEWS
}

final idValues = EnumValues({
    "google-news": Id.GOOGLE_NEWS
});

enum Name {
    GOOGLE_NEWS
}

final nameValues = EnumValues({
    "Google News": Name.GOOGLE_NEWS
});

class EnumValues<T> {
    Map<String, T> map;
    late Map<T, String> reverseMap;

    EnumValues(this.map);

    Map<T, String> get reverse {
        reverseMap = map.map((k, v) => MapEntry(v, k));
        return reverseMap;
    }
}
