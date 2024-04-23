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
      body: Center(
        child: Column(mainAxisAlignment: MainAxisAlignment.center, children: [
          Padding(
              padding: const EdgeInsets.only(bottom: 10),
              child: Image.asset(
                'assets/images/splash.png',
                height: 300,
                width: 300,
              )),
        ]),
      ),
      backgroundColor: Colors.white,
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
