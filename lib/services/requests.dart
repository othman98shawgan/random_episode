import 'dart:convert' as convert;
import 'package:http/http.dart' as http;
import '../models/episode_model.dart';
import '../models/season_model.dart';
import '../models/tv_show_model.dart';

String baseUrl = 'https://api.tvmaze.com';

Future<List<TvShow>> getSearchResultsList(String searchValue) async {
  searchValue.replaceAll(RegExp(' +'), '+'); //replace all spaces in value with +
  var url = Uri.parse("$baseUrl/search/shows?q=$searchValue");
  var response = await http.get(url);

  if (response.statusCode == 200) {
    List<TvShow> searchList = [];

    var tvShowData = convert.jsonDecode(response.body);

    int numberOfSearchTVs = (tvShowData.length > 10) ? 10 : tvShowData.length;

    for (int i = 0; i < numberOfSearchTVs; i++) {
      searchList.add(TvShow.fromJson(tvShowData[i]['show']));
    }

    return searchList;
  }

  // If the server did not return a 200 CREATED response,
  var statusCode = response.statusCode;
  throw Exception('Failed to get Tv shows. Status code = $statusCode');
}

Future<List<Season>> getTvShowSeasonsList(int tvShowId) async {
  var url = Uri.parse("$baseUrl/shows/$tvShowId/seasons");
  var response = await http.get(url);

  if (response.statusCode == 200) {
    List<Season> seasonsList = [];

    var seasonsData = convert.jsonDecode(response.body);
    var numberOfSeasons = seasonsData.length;

    for (int i = 0; i < numberOfSeasons; i++) {
      seasonsList.add(Season.fromJson(seasonsData[i]));
    }

    return seasonsList;
  }

  // If the server did not return a 200 CREATED response,
  var statusCode = response.statusCode;
  throw Exception('Failed to get Tv shows. Status code = $statusCode');
}

Future<Episode> getEpisode(int tvShowId, int episodeNumber, int seasonNumber) async {
  var url = Uri.parse(
      "$baseUrl/shows/$tvShowId/episodebynumber?season=$seasonNumber&number=$episodeNumber");
  var response = await http.get(url);

  if (response.statusCode == 200) {
    var resData = convert.jsonDecode(response.body);

    Episode episodeData = Episode.fromJson(resData);

    return episodeData;
  }
  // If the server did not return a 200 CREATED response,
  var statusCode = response.statusCode;
  throw Exception('Failed to get Tv shows. Status code = $statusCode');
}

Future<List<Episode>> getSeasonEpisodes(int seasonId) async {
  var url = Uri.parse("$baseUrl/seasons/$seasonId/episodes");
  var response = await http.get(url);

  if (response.statusCode == 200) {
    List<Episode> episodesList = [];

    var episodesData = convert.jsonDecode(response.body);
    var numberOfEpisodes = episodesData.length;

    for (int i = 0; i < numberOfEpisodes; i++) {
      episodesList.add(Episode.fromJson(episodesData[i]));
    }

    return episodesList;
  }

  // If the server did not return a 200 CREATED response,
  var statusCode = response.statusCode;
  throw Exception('Failed to get Tv shows. Status code = $statusCode');
}

Future<int> getSeasonEpisodesNumber(int seasonId) async {
  var url = Uri.parse("$baseUrl/seasons/$seasonId/episodes");
  var response = await http.get(url);

  if (response.statusCode == 200) {
    var episodesData = convert.jsonDecode(response.body);
    var numberOfEpisodes = episodesData.length;

    return numberOfEpisodes;
  }

  // If the server did not return a 200 CREATED response,
  var statusCode = response.statusCode;
  throw Exception('Failed to get Tv shows. Status code = $statusCode');
}
