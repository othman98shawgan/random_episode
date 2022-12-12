import 'package:flutter/material.dart';
import 'package:random_episode/models/episode_model.dart';
import 'package:random_episode/ui/search_page.dart';
import 'package:anim_search_bar/anim_search_bar.dart';

import '../services/requests.dart';

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  TextEditingController textController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
        actions: [
          IconButton(
            onPressed: () {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => SearchPage(
                      title: 'Search Page',
                      searchValue: 'the big bang theory',
                    ),
                  ));
            },
            icon: const Icon(Icons.search),
            tooltip: 'Search',
          ),
        ],
      ),
      body: Container(
        color: Colors.yellowAccent[100],
        width: double.infinity,
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: Column(
          children: [
            AnimSearchBar(
              width: 400,
              textController: textController,
              onSuffixTap: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => SearchPage(
                        title: 'Search Page',
                        searchValue: textController.text,
                      ),
                    )).then((value) => textController.clear());
              },
              suffixIcon: const Icon(Icons.search),
              color: Colors.red[200]!,
              helpText: "Search Text...",
              autoFocus: true,
              closeSearchOnSuffixTap: true,
              rtl: true,
            )
          ],
        ),
      ),
    );
  }
}
