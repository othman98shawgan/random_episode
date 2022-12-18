import 'dart:convert';
import 'dart:math';

import 'package:flutter/material.dart';
import 'package:random_episode/models/episode_model.dart';
import 'package:random_episode/models/season_model.dart';
import 'package:random_episode/models/tv_show_model.dart';
import 'package:random_episode/ui/search_page.dart';
import 'package:anim_search_bar/anim_search_bar.dart';
import 'package:random_episode/ui/widgets/card_widget.dart';

import '../services/requests.dart';

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  TextEditingController textController = TextEditingController();
  var pickedShowData = TvShow();
  var pickedShowSeasons = List<Season>.empty();
  var pickedEpisode = [0, 0];

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
                    builder: (context) => const SearchPage(
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
              onSuffixTap: () async {
                if (textController.text == "") {
                  const snackBar = SnackBar(
                    content: Text('Please add a tv-show title'),
                    duration: Duration(milliseconds: 500),
                  );
                  ScaffoldMessenger.of(context).showSnackBar(snackBar);
                } else {
                  pickedEpisode = [0, 0];
                  await Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => SearchPage(
                          title: 'Search Page',
                          searchValue: textController.text,
                        ),
                      )).then((value) {
                    if (value == null) return;
                    setState(() {
                      Map<String, dynamic> valueMap = json.decode(value[0]);
                      pickedShowData = TvShow.fromJson(valueMap);
                      pickedShowSeasons = value[1];
                    });
                  });
                }
              },
              suffixIcon: const Icon(Icons.search),
              color: Colors.red[200]!,
              helpText: "Search Text...",
              autoFocus: true,
              closeSearchOnSuffixTap: true,
              rtl: true,
            ),
            MyCard(
                widget: Padding(
              padding: const EdgeInsets.all(8),
              child: _buildRow(pickedShowData),
            )),
            const SizedBox(height: 25),
            ElevatedButton(
                onPressed: () async {
                  await randomEpisode(pickedShowSeasons).then((value) {
                    setState(() {
                      pickedEpisode = value;
                    });
                  });
                },
                child: const Padding(
                  padding: EdgeInsets.all(8),
                  child: Text(
                    'Random Episode',
                    style: TextStyle(fontSize: 24),
                  ),
                )),
            const SizedBox(height: 25),
            Text(
              'Season: ${pickedEpisode[0]} - Episode: ${pickedEpisode[1]}',
              style: const TextStyle(fontSize: 24),
            )
          ],
        ),
      ),
    );
  }

  Widget _buildRow(TvShow show) {
    var image = Image(
      image: NetworkImage(show.image?.original ??
          'https://upload.wikimedia.org/wikipedia/commons/3/38/Solid_white_bordered.png'),
      width: 48,
    );
    return ListTile(
      contentPadding: const EdgeInsets.only(left: 1.0, right: 1.0),
      leading: image,
      title: Text(show.name ?? ""),
      subtitle: Text("Number of Season: ${pickedShowSeasons.length}"),
    );
  }

  Future<List<int>> randomEpisode(List<Season> seasons) async {
    var random = Random();
    var randomSeason = random.nextInt(seasons.length);
    int randomEpisode = 0;
    if (seasons[randomSeason].episodeOrder != null) {
      randomEpisode = random.nextInt(seasons[randomSeason].episodeOrder ?? 0);
    } else {
      var episodeRange = await getSeasonEpisodesNumber(seasons[randomSeason].id ?? 0);
      randomEpisode = random.nextInt(episodeRange);
    }

    return [randomSeason + 1, randomEpisode + 1];
  }
}
