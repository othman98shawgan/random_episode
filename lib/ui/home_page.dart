import 'package:flutter/material.dart';
import 'package:random_episode/models/episode_model.dart';

import '../services/requests.dart';

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
        future: getSeasonEpisodes(2087), // getData,

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
                final series = snapshot.data as List<Episode>;
                return Scaffold();
              }
          }
        });
  }
}


    // return Scaffold(
    //   appBar: AppBar(
    //     title: Text(widget.title),
    //   ),
    //   body: Center(
    //     child: Column(
    //       mainAxisAlignment: MainAxisAlignment.center,
    //       children: <Widget>[
    //         const Text(
    //           'You have pushed the button this many times:',
    //         ),
    //         Text(
    //           '$_counter',
    //           style: Theme.of(context).textTheme.headline4,
    //         ),
    //       ],
    //     ),
    //   ),
    //   floatingActionButton: FloatingActionButton(
    //     onPressed: _incrementCounter,
    //     tooltip: 'Increment',
    //     child: const Icon(Icons.search),
    //   ),
    // );