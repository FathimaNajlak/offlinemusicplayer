import 'package:flutter/material.dart';
import 'package:on_audio_query/on_audio_query.dart';
import 'package:podcastapp/Screens/splash_screen.dart';
import 'package:podcastapp/functions/audio_converter_function.dart';
import 'package:podcastapp/model/song_model.dart';
import 'package:podcastapp/screens/nowplaying_screen.dart';

class SearchScreen extends StatefulWidget {
  const SearchScreen({super.key});

  @override
  State<SearchScreen> createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  TextEditingController searchController = TextEditingController();
  List<AllSongModel> searchList = [];
  // List<AllSongModel> allSongs = [];
  @override
  void initState() {
    // TODO: implement initState
    searchList = allSongs;
    setState(() {});
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          automaticallyImplyLeading: false,
          backgroundColor: Colors.grey,
          shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.vertical(
              bottom: Radius.circular(16),
            ),
          ),
          title: const Text(
            'Search',
            style: TextStyle(
              color: Colors.black54,
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
        ),
        body: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(12.0),
              child: Container(
                decoration: BoxDecoration(
                  color: Colors.grey[300],
                  borderRadius: BorderRadius.circular(10.0),
                ),
                child: TextField(
                  controller: searchController,
                  onChanged: (value) {
                    setState(() {
                      if (value.isEmpty) {
                        searchList = allSongs;
                        return;
                      }
                      searchList = allSongs
                          .where((element) => element.name!
                              .toLowerCase()
                              .contains(value.toLowerCase()))
                          .toList();
                    });
                  },
                  decoration: const InputDecoration(
                    hintText: 'Search...',
                    contentPadding: EdgeInsets.symmetric(horizontal: 16.0),
                    border: InputBorder.none,
                  ),
                ),
              ),
            ),
            Expanded(
              child: searchList.isEmpty
                  ? const Center(
                      child: Text('No results found'),
                    )
                  : ListView.separated(
                      separatorBuilder: (context, index) {
                        return const SizedBox(
                          height: 10,
                        );
                      },
                      physics: const NeverScrollableScrollPhysics(),
                      shrinkWrap: true,
                      itemCount: searchList.length,
                      itemBuilder: (context, index) {
                        final song = searchList.elementAt(index);
                        return ListTile(
                          onTap: () {
                            audioConverter(searchList, index);
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => NowPlayingScreen(
                                  song: song,
                                ),
                              ),
                            );
                          },
                          leading: ClipRRect(
                            borderRadius: BorderRadius.circular(16),
                            child: QueryArtworkWidget(
                              artworkClipBehavior: Clip.none,
                              artworkHeight: 70,
                              artworkWidth: 70,
                              nullArtworkWidget: Image.asset(
                                'assets/images/mostlyplayed.jpg',
                                fit: BoxFit.cover,
                                width: 70,
                                height: 70,
                              ),
                              id: song.id!,
                              type: ArtworkType.AUDIO,
                            ),
                          ),
                          title: Text(
                            song.name ?? 'name',
                            style: const TextStyle(
                              fontWeight: FontWeight.bold,
                            ),
                            maxLines: 1,
                          ),
                          subtitle: Text(
                            song.artist ?? 'Unknown Artist',
                            maxLines: 1,
                          ),
                        );
                      },
                    ),
            ),
          ],
        ));
  }
}
