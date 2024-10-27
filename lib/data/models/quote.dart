class Quote {
  late final int id;
  late final String quote;
  late final String author;

  Quote.fromJson(Map<String, dynamic> json) {
    id = json['id'] as int;
    quote = json['quote'] as String;
    author = json['author'] as String;
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'quote': quote,
      'author': author,
    };
  }
}
