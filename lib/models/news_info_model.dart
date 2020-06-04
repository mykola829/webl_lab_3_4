class NewsInfoModel {
  String id;
  List<CommentModel> name = [];
  int countOflike = 0;
  int countOfView = 0;
  bool isLiked;
   
  
    NewsInfoModel(
        {this.id,
        this.countOflike,
        this.countOfView,
        this.isLiked,
       
          });
  
  /*  News.fromJson(Map<String, dynamic> json) {
       sources = json['source'];
       name = sources['name'];
       id = sources['id'];
       author = json['author'];
       title  = json['title'];
       description = json['description'];
       url = json['url'];
       urlToImage  = json['urlToImage'];
       publishedAt = json['publishedAt'];
       content  = json['content'];
    }
  
    Map<String, dynamic> toJson() {
      final Map<String, dynamic> data = new Map<String, dynamic>();
      data['id'] = this.id;
      
      return data;
    }*/
  }
  
  class CommentModel {
    String author;
    String textComment;
    int countOflike;
    int countOfDislike;
    
    CommentModel(
        {this.author,
        this.textComment,
        this.countOflike,
        this.countOfDislike,
       
          });
}

