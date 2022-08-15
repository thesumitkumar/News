import 'dart:convert';
import '../model/article.dart';
import 'package:http/http.dart' as http;

class GetApiData {
  String category;

  Uri url = Uri.parse(
      "https://newsapi.org/v2/top-headlines?country=in&apiKey=7a6ad3304e334bb28195f924a6298618");

  GetApiData(this.category) {
    if (category == "") {
    } else if (category == "anime") {
      url = Uri.parse(
          "https://newsapi.org/v2/everything?q=anime&sortBy=relevancy&language=en&apiKey=7a6ad3304e334bb28195f924a6298618");
    } else {
      url = Uri.parse(
          "https://newsapi.org/v2/top-headlines?country=in&category=$category&apiKey=7a6ad3304e334bb28195f924a6298618");
    }
  }
  Future<List<Article>> getApiData() async {
    var response = await http.get(url);
    var jsonData = jsonDecode(response.body);
    List<Article> articleList = [];
    if (jsonData["status"] == "ok") {
      for (var element in jsonData["articles"]) {
        if (element["url"] != null && element["description"] != null) {
          articleList.add(
            Article(
              auther: element['author'],
              title: element['title'],
              content: element['content'],
              description: element['description'],
              url: element['url'],
              imageUrl: element['urlToImage'],
            ),
          );
        }
      }
    }
    //print(articleList);
    return articleList;
  }
}