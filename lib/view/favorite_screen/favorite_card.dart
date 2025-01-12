import 'package:flutter/material.dart';

class FavoriteCard extends StatelessWidget {
  final String quote;
  final String author;

  const FavoriteCard({
    super.key,
    required this.author,
    required this.quote
  });


  @override
  Widget build(BuildContext context) {
    return Card(
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
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  quote,
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
        );
  }
}