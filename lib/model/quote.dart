import 'dart:convert';

class Quote {
  final String id;
  final String content;
  final String author;
  final List<String> tags; // Mengubah Array menjadi List<String>
  final String authorSlug;
  final int length; // Mengubah Int menjadi int
  final String dateAdded;
  final String dateModified;

  Quote({
    required this.id,
    required this.author,
    required this.content,
    required this.tags,
    required this.authorSlug,
    required this.dateAdded,
    required this.dateModified,
    required this.length,
  });

  // Fungsi untuk membuat instance dari Map (JSON response)
  factory Quote.fromJson(Map<String, dynamic> json) {
    return Quote(
      id: json["_id"],
      content: json["content"],
      author: json["author"],
      tags: List<String>.from(json["tags"]),
      authorSlug: json["authorSlug"],
      length: json["length"],
      dateAdded: json["dateAdded"],
      dateModified: json["dateModified"],
    );
  }

  // Fungsi untuk mengubah instance menjadi Map (untuk API request)
  Map<String, dynamic> toJson() {
    return {
      "_id": id,
      "content": content,
      "author": author,
      "tags": tags,
      "authorSlug": authorSlug,
      "length": length,
      "dateAdded": dateAdded,
      "dateModified": dateModified,
    };
  }

  factory Quote.fromMap(Map<String, dynamic> map) {
    return Quote(
      id: map['id'],
      content: map['content'],
      author: map['author'],
      tags: List<String>.from(json.decode(map['tags'])), // Decode JSON string
      authorSlug: map['authorSlug'],
      length: map['length'],
      dateAdded: map['dateAdded'],
      dateModified: map['dateModified'],
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'content': content,
      'author': author,
      'tags': json.encode(tags), // Encode List<String> menjadi JSON string
      'authorSlug': authorSlug,
      'length': length,
      'dateAdded': dateAdded,
      'dateModified': dateModified,
    };
  }
}
