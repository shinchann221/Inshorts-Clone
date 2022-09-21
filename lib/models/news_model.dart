class NewsModel {
  final String author;
  final String title;
  final String description;
  final String url;
  final String urlToImage;
  final String publishedAt;
  final String content;

  NewsModel({
    required this.author,
    required this.title,
    required this.description,
    required this.url,
    required this.urlToImage,
    required this.publishedAt,
    required this.content,
  });

  factory NewsModel.fromJson(Map<String, dynamic> json) {
    return NewsModel(
      author: json['author'] ?? 'Not Available',
      title: json['title'] ?? 'Not Available',
      description: json['description'] ?? 'Not Available',
      url: json['url'] ?? 'https://google.co.in',
      urlToImage: json['urlToImage'] ??
          'https://via.placeholder.com/500/FFFFFF/000000/?text=Image+Not+Available',
      publishedAt: json['publishedAt'] ?? 'Not Available',
      content: json['content'] ?? 'Not Available',
    );
  }
}
