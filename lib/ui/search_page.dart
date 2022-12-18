import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:random_episode/models/episode_model.dart';
import 'package:random_episode/models/tv_show_model.dart';

import '../services/requests.dart';

class SearchPage extends StatefulWidget {
  const SearchPage({super.key, required this.title, required this.searchValue});

  final String title;
  final String searchValue;

  @override
  State<SearchPage> createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
        actions: [],
      ),
      body: FutureBuilder(
          future: getSearchResultsList(widget.searchValue), // getData,
          builder: (context, snapshot) {
            switch (snapshot.connectionState) {
              case ConnectionState.waiting:
                return const Center(
                  child: CircularProgressIndicator(),
                );
              default:
                if (snapshot.hasError) {
                  return Center(
                    child: ElevatedButton(
                      onPressed: () {
                        setState(() {
                          snapshot.hasData; // getData = ApiServices().getMovies();
                        });
                      },
                      child: const Text("Oops!!! no internet connection"),
                    ),
                  );
                } else {
                  final showsList = snapshot.data as List<TvShow>;
                  return _buildList(showsList);
                }
            }
          }),
    );
  }

  Widget _buildList(List<TvShow> showsList) {
    return ListView.builder(
      shrinkWrap: true,
      padding: const EdgeInsets.all(16),
      itemCount: showsList.length,
      itemBuilder: (context, i) {
        return Column(
          children: [
            _buildRow((showsList[i])),
            const Divider(
              thickness: 1,
            )
          ],
        );
      },
    );
  }

  Widget _buildRow(TvShow show) {
    final screenHeight = MediaQuery.of(context).size.height;
    final screenWidth = MediaQuery.of(context).size.width;

    var image = Image(
      image: NetworkImage(show.image?.original ??
          'https://upload.wikimedia.org/wikipedia/commons/3/38/Solid_white_bordered.png'),
      width: 48,
    );
    var summary = show.summary ?? "";
    summary = summary.replaceAll(RegExp("<[^>]*>"), "");
    summary = summary.length > 200 ? summary.substring(0, 200) : summary;
    return ListTile(
      onTap: () async {
        getTvShowSeasonsList(show.id ?? 1).then((value) {
          var decodedData = jsonEncode(show.toJson());
          var snackBar = SnackBar(
            content: Text('You have picked ${show.name ?? ""}'),
          );
          ScaffoldMessenger.of(context).showSnackBar(snackBar);

          Navigator.pop(context, [decodedData, value]); //Pop and send the data to parent.
        });
      },
      contentPadding: const EdgeInsets.only(left: 1.0, right: 1.0),
      leading: image,
      title: Text(show.name ?? ""),
      subtitle: Text(summary),
      trailing: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Text(show.premiered ?? ""),
          const Icon(
            Icons.arrow_downward_sharp,
            size: 18,
          ),
          Text(show.ended ?? ""),
        ],
      ),
    );
  }
}
