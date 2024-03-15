import 'dart:async';
import 'package:flutter/material.dart';
import 'package:podcastapp/Screens/bottom_navigation_bar.dart';
import 'package:podcastapp/functions/fetch.dart';
import 'package:podcastapp/model/song_model.dart';

class SplashScreen extends StatelessWidget {
  const SplashScreen({super.key});

  @override
  Widget build(BuildContext context) {
    wait(context);
    return Scaffold(
      body: Container(
          child: Center(
        child: Column(mainAxisAlignment: MainAxisAlignment.center, children: [
          Padding(
              padding: const EdgeInsets.only(bottom: 40),
              child: Image.asset(
                'assets/images/mostlyplayed.jpg',
                height: 200,
                width: 200,
              )),
        ]),
      )),
    );
  }

  wait(context) async {
    await songfetch();

    Timer(const Duration(milliseconds: 1500), () {
      Navigator.of(context).pushReplacement(
        MaterialPageRoute(
          builder: (_) => BottomNaviScreen(),
        ),
      );
    });
  }
}

List<AllSongModel> allSongs = [];
