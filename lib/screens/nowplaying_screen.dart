import 'package:flutter/material.dart';
import 'package:on_audio_query/on_audio_query.dart';
import 'package:podcastapp/model/song_model.dart';

class NowPlayingScreen extends StatefulWidget {
  final AllSongModel? music;
  const NowPlayingScreen({Key? key, this.songs, this.music}) : super(key: key);
  final List<SongModel>? songs;
  @override
  State<NowPlayingScreen> createState() => _NowPlayingScreenState();
}

class _NowPlayingScreenState extends State<NowPlayingScreen> {
  bool isRepeat = false;
  bool isShuffle = false;
  bool isFavorite = false;

  // Mock progress value (0 to 1)
  double progress = 0.5;

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.grey,
          shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.vertical(
              bottom: Radius.circular(16),
            ),
          ),
          title: const Text(
            'Now Playing',
            style: TextStyle(
              color: Colors.black,
              fontWeight: FontWeight.bold,
            ),
          ),
          leading: IconButton(
            onPressed: () {
              Navigator.pop(context);
            },
            icon: const Icon(
              Icons.arrow_back,
              size: 28,
              color: Colors.black,
            ),
          ),
          actions: [
            IconButton(
              color: Colors.black,
              onPressed: () {
                // Navigator.push(
                //   context,
                //   MaterialPageRoute(
                //       builder: (context) => const PlaylistScreen()),
                // );
              },
              icon: const Icon(Icons.playlist_add),
            ),
          ],
        ),
        body: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  // Asset image in the center
                  Row(
                    children: [
                      IconButton(
                        onPressed: () {},
                        icon: const Icon(Icons.replay_10),
                      ),
                      Container(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(125),
                          image: const DecorationImage(
                            image: AssetImage('assets/images/mostlyplayed.jpg'),
                            // Add your image path here
                            fit: BoxFit.cover,
                          ),
                        ),
                        width: 250,
                        height: 250,
                      ),
                      IconButton(
                        onPressed: () {},
                        icon: const Icon(Icons.forward_10),
                      ),
                    ],
                  ),
                  const SizedBox(height: 20),
                  // Audio progress bar
                ],
              ),
              const Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [],
              ),
              const Padding(
                padding: EdgeInsets.symmetric(horizontal: 20),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [],
                ),
              ),
              const Column(
                children: [
                  Text(
                    "audio 1",
                    maxLines: 1,
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      color: Colors.black,
                    ),
                  ),
                  SizedBox(
                    height: 8,
                  ),
                  Text(
                    "Artist name",
                    maxLines: 1,
                    style: TextStyle(
                      fontSize: 17,
                      fontWeight: FontWeight.bold,
                      color: Colors.grey,
                    ),
                  ),
                ],
              ),
              LinearProgressIndicator(
                value: progress,
                backgroundColor: Colors.grey[300],
                valueColor: const AlwaysStoppedAnimation<Color>(Colors.black),
              ),
              // const SizedBox(height: 10),
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  IconButton(
                    onPressed: () {
                      setState(() {
                        isFavorite = !isFavorite;
                      });
                    },
                    icon: Icon(
                      isFavorite ? Icons.favorite : Icons.favorite_border,
                      color: isFavorite ? Colors.red : null,
                    ),
                  ),
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  IconButton(
                    onPressed: () {
                      setState(() {
                        isShuffle = !isShuffle;
                      });
                    },
                    icon: Icon(
                      isShuffle
                          ? Icons.shuffle_on_rounded
                          : Icons.shuffle_rounded,
                      size: 28,
                    ),
                  ),
                  IconButton(
                    onPressed: () {},
                    icon: const Icon(
                      Icons.skip_previous,
                      size: 28,
                    ),
                  ),
                  const Icon(
                    Icons.play_arrow,
                    size: 50,
                    color: Colors.black,
                  ),
                  IconButton(
                    onPressed: () {},
                    icon: const Icon(
                      Icons.skip_next,
                      size: 28,
                    ),
                  ),
                  IconButton(
                    onPressed: () {
                      setState(() {
                        isRepeat = !isRepeat;
                      });
                    },
                    icon: Icon(
                      isRepeat ? Icons.repeat_one : Icons.repeat,
                      size: 28,
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
