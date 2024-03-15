import 'package:flutter/material.dart';
import 'package:on_audio_query/on_audio_query.dart';
import 'package:podcastapp/screens/nowplaying_screen.dart';
import 'package:podcastapp/screens/splash_screen.dart';
import 'package:podcastapp/model/song_model.dart';

class SearchScreen extends StatefulWidget {
  const SearchScreen({
    Key? key,
  }) : super(key: key);

  @override
  State<SearchScreen> createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  List<AllSongModel> searchList = allSongs; // Initially set to allSongs
  TextEditingController searchController = TextEditingController();

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
            'Search',
            style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold),
          ),
        ),
        body: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            children: [
              Container(
                decoration: BoxDecoration(
                  color: const Color.fromARGB(255, 214, 210, 210),
                  borderRadius: BorderRadius.circular(16),
                ),
                child: TextField(
                  controller: searchController,
                  onChanged: (value) {
                    setState(() {
                      searchList = allSongs
                          .where(
                            (element) => element.name!.toLowerCase().contains(
                                  value.toLowerCase(),
                                ),
                          )
                          .toList();
                    });
                  },
                  decoration: const InputDecoration(
                    hintText: 'Search...',
                    border: InputBorder.none,
                    contentPadding: EdgeInsets.all(16),
                  ),
                ),
              ),
              Expanded(
                child: searchList.isEmpty
                    ? Center(
                        child: Text('No song found'),
                      )
                    : ListView.builder(
                        itemCount: searchList.length,
                        itemBuilder: (context, index) {
                          final song = searchList[index];
                          return GestureDetector(
                            onTap: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) =>
                                      const NowPlayingScreen(),
                                ),
                              );
                            },
                            child: ListTile(
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
                              title: Text(song.name ?? 'name'),
                              subtitle: Text(song.artist ?? 'Unknown Artist'),
                              trailing: PopupMenuButton(
                                itemBuilder: (BuildContext context) {
                                  return [
                                    const PopupMenuItem(
                                      value: 1,
                                      child: Text('Option 1'),
                                    ),
                                    const PopupMenuItem(
                                      value: 2,
                                      child: Text('Option 2'),
                                    ),
                                  ];
                                },
                                onSelected: (value) {
                                  // Handle menu item selection here
                                },
                              ),
                            ),
                          );
                        },
                      ),
              )
            ],
          ),
        ),
        backgroundColor: const Color.fromARGB(255, 236, 232, 220),
      ),
    );
  }
}
