import 'package:assets_audio_player/assets_audio_player.dart';
import 'package:flutter/material.dart';
import 'package:marquee/marquee.dart';
import 'package:on_audio_query/on_audio_query.dart';
import 'package:podcastapp/functions/audio_converter_function.dart';
import 'package:podcastapp/functions/recently_played.dart';
import 'package:podcastapp/screens/splash_screen.dart';
import 'nowplaying_screen.dart';

class MiniPlayer extends StatefulWidget {
  const MiniPlayer({Key? key}) : super(key: key);

  @override
  State<MiniPlayer> createState() => MiniPlayerState();
}

int index = 0;

class MiniPlayerState extends State<MiniPlayer> {
  @override
  Widget build(BuildContext context) {
    return assetsAudioPlayer.builderCurrent(
      builder: (context, playing) {
        int currentId = int.parse(playing.audio.audio.metas.id!);
        for (var element in allSongs) {
          if (element.id == currentId) {
            recentadd(element);
          }
        }

        return Padding(
          padding: const EdgeInsets.all(6),
          child: Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(35),
              color: Colors.grey,
              border: Border.all(color: Colors.black, width: 2),
            ),
            height: 50,
            width: MediaQuery.of(context).size.width,
            child: InkWell(
              onTap: () {
                Navigator.of(context).push(
                  MaterialPageRoute(
                    builder: (ctx) => NowPlayingScreen(
                      song: allSongs[index],
                    ),
                  ),
                );
              },
              child: Row(
                children: [
                  QueryArtworkWidget(
                    id: int.parse(playing.audio.audio.metas.id!),
                    type: ArtworkType.AUDIO,
                    nullArtworkWidget: const CircleAvatar(
                      backgroundImage:
                          AssetImage('assets/images/mostlyplayed.jpg'),
                    ),
                    artworkFit: BoxFit.fill,
                  ),
                  const SizedBox(width: 16),
                  Expanded(
                    child: Marquee(
                      velocity: 25,
                      text: assetsAudioPlayer.getCurrentAudioTitle,
                      blankSpace: 60,
                      style: const TextStyle(
                          color: Colors.black, fontWeight: FontWeight.bold),
                    ),
                  ),
                  PlayerBuilder.isPlaying(
                    player: assetsAudioPlayer,
                    builder: (context, isPlaying) {
                      return Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          IconButton(
                            onPressed: () async {
                              await assetsAudioPlayer.previous();
                              setState(() {});
                              if (isPlaying == false) {
                                assetsAudioPlayer.pause();
                              }
                            },
                            icon: const Icon(
                              Icons.skip_previous,
                              color: Colors.black,
                            ),
                          ),
                          IconButton(
                            onPressed: () async {
                              await assetsAudioPlayer.playOrPause();
                            },
                            icon: Icon(
                              isPlaying ? Icons.pause : Icons.play_arrow,
                              color: Colors.black,
                            ),
                          ),
                          IconButton(
                            onPressed: () async {
                              await assetsAudioPlayer.next();
                              setState(() {});
                              if (isPlaying == false) {
                                assetsAudioPlayer.pause();
                              }
                            },
                            icon: const Icon(
                              Icons.skip_next,
                              color: Colors.black,
                            ),
                          ),
                        ],
                      );
                    },
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
