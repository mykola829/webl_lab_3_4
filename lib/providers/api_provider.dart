import 'dart:convert';
import 'package:adityagurjar/models/news_model.dart';
import 'package:http/http.dart' as http;

class ApiProvider {
  Future<List<News>> getBlogs(String url) async {
    final response = await http.get(url);
    if (response.statusCode == 200) {
      List blogs = json.decode(utf8.decode(response.bodyBytes))['articles'];
      final results = blogs
          .map((blog) => News.fromJson(blog))
          .where((element) =>
              element.author != null &&
              element.description != null &&
              element.name != null &&
              element.url != null &&
              element.urlToImage != null &&
              element.content != null &&
              element.publishedAt != null &&
              element.title != null)
          .toList();
      return results;
    } else {
      return null;
    }
  }
}
