class Comment {
  int id;
  String text;
  String author;
  int article;

  Comment(int id, String text, String author, int article) {
    this.id = id;
    this.text = text;
    this.author = author;
    this.article = article;
  }

  Comment.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    author = json['author'];
    text = json['text'];
    article = json['article'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;

    return data;
  }
}
