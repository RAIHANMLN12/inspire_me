// ignore_for_file: library_private_types_in_public_api

import 'package:flutter/material.dart';
import 'package:inspire_me/model/quote.dart';
import 'package:inspire_me/utils/api_request.dart';
import 'package:inspire_me/view/home_screen/component/quote_card.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  late Future<Quote> _futureQuote;

  @override
  void initState() {
    super.initState();
    _futureQuote = ApiService().fetchRandomQuote();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
            mainAxisSize: MainAxisSize.max,
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              FutureBuilder<Quote>(
                  future: _futureQuote,
                  builder: (context, snapshot) {
                    if (snapshot.connectionState == ConnectionState.waiting) {
                      return const Center(
                        child: CircularProgressIndicator(),
                      );
                    } else if (snapshot.hasError) {
                      return Text('Error: ${snapshot.error}');
                    } else if (snapshot.hasData) {
                      final quote = snapshot.data!;
                      return QuoteCard(
                          id: quote.id,
                          author: quote.author,
                          content: quote.content,
                          tags: quote.tags,
                          authorSlug: quote.authorSlug,
                          length: quote.length,
                          dateAdded: quote.dateAdded,
                          dateModified: quote.dateModified
                        );
                    }
                    return Container();
                  }),
            ]),
      ),
    );
  }
}
