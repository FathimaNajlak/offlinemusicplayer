import 'package:flutter/material.dart';

class RecentlyPlayedScreen extends StatelessWidget {
  const RecentlyPlayedScreen({Key? key}) : super(key: key);

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
            'Recently Played',
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
        ),
        body: Row(
          children: [
            Expanded(
              child: ListView.builder(
                itemBuilder: (context, index) {
                  return Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Row(
                      children: [
                        const SizedBox(
                          width: 8,
                        ),
                        Expanded(
                          child: Container(
                            height: 70,
                            width: double.infinity,
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
                              title: Text(
                                "audio $index",
                                maxLines: 1,
                                style: const TextStyle(
                                    fontWeight: FontWeight.bold),
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
                itemCount: 10,
              ),
            ),
          ],
        ),
        backgroundColor: const Color.fromARGB(255, 236, 232, 220),
      ),
    );
  }
}
