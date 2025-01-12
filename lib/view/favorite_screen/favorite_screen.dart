import 'package:flutter/material.dart';
import 'package:inspire_me/model/quote.dart';
import 'package:inspire_me/utils/db_helper.dart';
import 'package:inspire_me/view/favorite_screen/favorite_card.dart';

class FavoriteScreen extends StatefulWidget {
  const FavoriteScreen({super.key});

  @override
  _FavoriteScreenState createState() => _FavoriteScreenState();
}

class _FavoriteScreenState extends State<FavoriteScreen> {
  late Future<List<Quote>> _favoriteQuotes;

  @override
  void initState() {
    super.initState();
    _loadFavorites();
  }

  void _loadFavorites() {
    setState(() {
      _favoriteQuotes = DbHelper().getQuotes();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: FutureBuilder<List<Quote>>(
          future: _favoriteQuotes,
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const Center(child: CircularProgressIndicator());
            } else if (snapshot.hasError) {
              return Center(child: Text('Error: ${snapshot.error}'));
            } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
              return const Center(child: Text('No favorite quotes yet!'));
            } else {
              final quotes = snapshot.data!;
              return ListView.builder(
                itemCount: quotes.length,
                itemBuilder: (context, index) {
                  final quote = quotes[index];
                  return Padding(
                    padding: EdgeInsets.symmetric(vertical: 15.0),
                    child: FavoriteCard(
                      quote: quote.content,
                      author: quote.author,
                    ),
                  );
                },
              );
            }
          },
        ),
      ),
    );
  }
}
