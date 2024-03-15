import 'package:flutter/material.dart';
import 'package:podcastapp/Screens/splash_screen.dart';

class MostlyPlayedScreen extends StatefulWidget {
  const MostlyPlayedScreen({Key? key});

  @override
  State<MostlyPlayedScreen> createState() => _MostlyPlayedScreenState();
}

class _MostlyPlayedScreenState extends State<MostlyPlayedScreen> {
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
            'Mostly played',
            style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold),
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
        body: ListView.builder(
          itemCount: allSongs.length,
          itemBuilder: (context, index) {
            print('songsAddedInBox==============${allSongs.length}');
            return Padding(
              padding: const EdgeInsets.all(8.0),
              child: Row(
                children: [
                  const SizedBox(width: 8),
                  Expanded(
                    child: Container(
                      height: 70,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(15),
                        color: Colors.grey,
                      ),
                      child: ListTile(
                        leading: Image.asset(
                          'assets/images/mostlyplayed.jpg',
                          width: 60,
                          height: 60,
                          fit: BoxFit.cover,
                        ),
                        title: const Text(
                          'audio1',
                          maxLines: 1,
                          style: TextStyle(fontWeight: FontWeight.bold),
                        ),
                        subtitle: const Text(
                          "Artist name",
                          style: TextStyle(fontWeight: FontWeight.bold),
                          maxLines: 1,
                        ),
                        trailing: PopupMenuButton(
                          icon: const Icon(Icons.more_vert),
                          itemBuilder: (BuildContext context) =>
                              const <PopupMenuEntry>[
                            PopupMenuItem(
                              child: Text('Option 1'),
                            ),
                            PopupMenuItem(
                              child: Text('Option 2'),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            );
          },
        ),
      ),
    );
  }
}
