class News {
  int id;
  String name;
  String author;
  String title;
  String description;
  String url;
  String urlToImage;
  String publishedAt;
  String content;
  String category;

  News(
      {this.id,
      this.name,
      this.author,
      this.title,
      this.description,
      this.url,
      this.urlToImage,
      this.publishedAt,
      this.content,
      this.category});

  News.fromJson(Map<String, dynamic> json) {
    name = json['source_name'];
    id = json['id'];
    author = json['author'];
    title = json['title'];
    description = json['description'];
    url = json['url'];
    urlToImage = json['image_url'];
    publishedAt = json['post_date_time'];
    content = json['content'];
    category = json['category'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;

    return data;
  }
}
