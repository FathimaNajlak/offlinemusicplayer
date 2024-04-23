import 'package:assets_audio_player/assets_audio_player.dart';
import 'package:audio_video_progress_bar/audio_video_progress_bar.dart';
import 'package:flutter/material.dart';
import 'package:on_audio_query/on_audio_query.dart';
import 'package:podcastapp/functions/audio_converter_function.dart';
import 'package:podcastapp/functions/favourite_functions.dart';
import 'package:podcastapp/model/song_model.dart';
import 'package:marquee/marquee.dart';
import 'package:podcastapp/screens/playlist/add_to_playlist.dart';

class NowPlayingScreen extends StatefulWidget {
  final AllSongModel song;
  final int songId;

  const NowPlayingScreen({Key? key, required this.song, required this.songId})
      : super(key: key);

  @override
  State<NowPlayingScreen> createState() => _NowPlayingScreenState();
}

class _NowPlayingScreenState extends State<NowPlayingScreen> {
  bool isRepeat = false;
  bool isShuffle = false;
  bool isFavorite = false;

  double progress = 0.5;

  @override
  void initState() {
    super.initState();
    isFavorite = favoriteChecking(widget.song.id!);
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: Color.fromARGB(255, 44, 79, 48),
          shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.vertical(
              bottom: Radius.circular(16),
            ),
          ),
          title: const Text(
            'Now Playing',
            style: TextStyle(
              color: Colors.white,
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
              color: Colors.white,
            ),
          ),
          actions: [
            IconButton(
              color: Colors.white,
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => AddToPlaylistsScreen(
                      song: widget.song,
                    ),
                  ),
                );
              },
              icon: const Icon(Icons.playlist_add),
            ),
          ],
        ),
        body: assetsAudioPlayer.builderCurrent(
          builder: (context, playing) {
            int id = int.parse(playing.audio.audio.metas.id ?? '');
            favoriteChecking(id);
            findCurrentSong(id);
            return Padding(
              padding: const EdgeInsets.symmetric(horizontal: 45),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Row(
                        children: [
                          IconButton(
                            onPressed: () async {
                              await assetsAudioPlayer
                                  .seekBy(const Duration(seconds: -10));
                            },
                            icon: const Icon(Icons.replay_10,
                                color: Colors.white),
                          ),
                          Container(
                            decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              border: Border.all(
                                  color: Colors.white,
                                  width: 4), // Add border for a nice effect
                            ),
                            width: 200,
                            height: 200,
                            child: ClipOval(
                              child: QueryArtworkWidget(
                                nullArtworkWidget: Image.asset(
                                  'assets/images/mostlyplayed.jpg',
                                  fit: BoxFit.cover,
                                ),
                                id: int.parse(
                                    playing.audio.audio.metas.id ?? ''),
                                type: ArtworkType.AUDIO,
                              ),
                            ),
                          ),
                          IconButton(
                            onPressed: () async {
                              await assetsAudioPlayer
                                  .seekBy(const Duration(seconds: 10));
                            },
                            icon: const Icon(Icons.forward_10,
                                color: Colors.white),
                          ),
                        ],
                      ),
                      const SizedBox(height: 20),
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
                  Column(
                    children: [
                      SizedBox(
                        height: 55,
                        width: 250,
                        child: Marquee(
                          text: assetsAudioPlayer.getCurrentAudioTitle,
                          velocity: 25,
                          blankSpace: 60,
                          scrollAxis: Axis.horizontal,
                          style: const TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                              color: Colors.white),
                        ),
                      ),
                      Text(
                        assetsAudioPlayer.getCurrentAudioArtist,
                        maxLines: 1,
                        style: const TextStyle(
                            fontSize: 17,
                            fontWeight: FontWeight.bold,
                            color: Colors.grey),
                      ),
                    ],
                  ),
                  Column(
                    children: [
                      PlayerBuilder.realtimePlayingInfos(
                        player: assetsAudioPlayer,
                        builder: (context, realtimePlayingInfos) {
                          final duration =
                              realtimePlayingInfos.current!.audio.duration;
                          final position = realtimePlayingInfos.currentPosition;

                          return ProgressBar(
                            thumbGlowColor: Colors.grey,
                            thumbGlowRadius: 8,
                            thumbColor: Colors.white,
                            thumbRadius: 6,
                            barCapShape: BarCapShape.square,
                            progress: position,
                            total: duration,
                            timeLabelPadding: 15,
                            onSeek: (duration) =>
                                assetsAudioPlayer.seek(duration),
                            progressBarColor:
                                const Color.fromARGB(255, 118, 117, 117),
                            baseBarColor:
                                const Color.fromARGB(255, 205, 199, 199),
                            bufferedBarColor: const Color.fromARGB(
                                255,
                                158,
                                158,
                                158), // Add this line if you want to display buffered progress
                            timeLabelTextStyle: const TextStyle(
                                color:
                                    Colors.white), // TextStyle for time labels

                            // Spacing between time labels
                            timeLabelType: TimeLabelType
                                .remainingTime, // Type of time label (remainingTime or elapsedTime)
                          );
                        },
                      ),
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      IconButton(
                        onPressed: () {
                          bool checking = favoriteChecking(
                            int.parse(
                              playing.audio.audio.metas.id!,
                            ),
                          );
                          setState(() {
                            isFavorite = !checking;
                            if (checking == true) {
                              removeFromFav(
                                  int.parse(playing.audio.audio.metas.id!));
                            } else {
                              addToFavorites(
                                  int.parse(playing.audio.audio.metas.id!));
                            }
                          });
                        },
                        icon: Icon(
                          isFavorite ? Icons.favorite : Icons.favorite_border,
                          color: isFavorite ? Colors.red : Colors.white,
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
                            if (isShuffle) {
                              assetsAudioPlayer.toggleShuffle();
                            } else {
                              assetsAudioPlayer.setLoopMode(LoopMode.playlist);
                            }
                          });
                        },
                        icon: Icon(
                          isShuffle
                              ? Icons.shuffle_on_rounded
                              : Icons.shuffle_rounded,
                          size: 28,
                          color: Colors.white,
                        ),
                      ),
                      IconButton(
                        onPressed: () {
                          assetsAudioPlayer.previous();
                        },
                        icon: const Icon(
                          Icons.skip_previous,
                          size: 28,
                          color: Colors.white,
                        ),
                      ),
                      InkWell(
                        onTap: () => assetsAudioPlayer.playOrPause(),
                        child: PlayerBuilder.isPlaying(
                          player: assetsAudioPlayer,
                          builder: (context, isPlaying) {
                            if (isPlaying) {
                              return const Icon(Icons.pause,
                                  color: Colors.white);
                            } else {
                              return const Icon(Icons.play_arrow,
                                  color: Colors.white);
                            }
                          },
                        ),
                      ),
                      IconButton(
                        onPressed: () {
                          assetsAudioPlayer.next();
                        },
                        icon: const Icon(
                          Icons.skip_next,
                          size: 28,
                          color: Colors.white,
                        ),
                      ),
                      IconButton(
                        onPressed: () {
                          setState(() {
                            isRepeat = !isRepeat;
                            if (isRepeat) {
                              assetsAudioPlayer.setLoopMode(LoopMode.single);
                            } else {
                              assetsAudioPlayer.setLoopMode(LoopMode.playlist);
                            }
                          });
                        },
                        icon: Icon(
                          isRepeat ? Icons.repeat_one : Icons.repeat,
                          size: 28,
                          color: Colors.white,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            );
          },
        ),
        backgroundColor: Color.fromARGB(255, 40, 54, 38),
      ),
    );
  }
}
