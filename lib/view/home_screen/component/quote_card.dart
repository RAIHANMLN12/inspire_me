import 'package:flutter/material.dart';
import 'package:inspire_me/model/quote.dart';
import 'package:inspire_me/utils/db_helper.dart';

class QuoteCard extends StatelessWidget {
  final String id;
  final String content;
  final String author;
  final List<String> tags; // Mengubah Array menjadi List<String>
  final String authorSlug;
  final int length; // Mengubah Int menjadi int
  final String dateAdded;
  final String dateModified;

  const QuoteCard({
    super.key,
    required this.id,
    required this.author,
    required this.content,
    required this.tags,
    required this.authorSlug,
    required this.dateAdded,
    required this.dateModified,
    required this.length,
  });

  Future<void> _saveFavorite(BuildContext context) async {
    final dbHelper = DbHelper();
    final newQuote = Quote(
        id: DateTime.now().toString(), // Unique ID
        content: content,
        author: author,
        tags: tags,
        authorSlug: authorSlug,
        length: length,
        dateAdded: dateAdded,
        dateModified: dateModified);

    await dbHelper.insertQuote(newQuote);
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text('Added to favorites!')),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.end,
      children: [
        Card(
          margin: EdgeInsets.symmetric(horizontal: 20.0),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20.0), // Rounded corners
          ),
          elevation: 8.0, // Shadow for depth
          child: Padding(
            padding: const EdgeInsets.symmetric(
                vertical: 30.0, horizontal: 15.0), // Padding inside the card
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Text(
                  content,
                  style: TextStyle(
                    fontSize: 18.0,
                    color: Colors.black87,
                    fontWeight: FontWeight.w500,
                    height: 1.5, // Adjust line spacing
                  ),
                  textAlign: TextAlign.center,
                ),
                SizedBox(height: 20.0),
                Text(
                  author,
                  style: TextStyle(
                    fontSize: 16.0,
                    fontWeight: FontWeight.w400,
                    color: Colors.grey[600],
                  ),
                ),
              ],
            ),
          ),
        ),
        Container(
          margin: EdgeInsets.only(right: 20.0),
          child: IconButton(
              onPressed: () => _saveFavorite(context),
              icon: Icon(Icons.bookmark)),
        )
      ],
    );
  }
}
