import 'package:flutter/material.dart';

class AboutUsScreen extends StatelessWidget {
  const AboutUsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color.fromARGB(255, 44, 79, 48),
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.vertical(
            bottom: Radius.circular(16),
          ),
        ),
        title: const Text(
          'About Us',
          style: TextStyle(
              color: Color.fromARGB(255, 245, 243, 243),
              fontWeight: FontWeight.bold),
        ),
        leading: IconButton(
          onPressed: () {
            Navigator.pop(context);
          },
          icon: const Icon(
            Icons.arrow_back,
            size: 28,
            color: Color.fromARGB(255, 241, 236, 236),
          ),
        ),
      ),
      body: const SingleChildScrollView(
        padding: EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Welcome to TuneTastic - Your Ultimate Offline Music Experience',
              style: TextStyle(
                fontSize: 18,
                color: Colors.white,
              ),
            ),
            SizedBox(height: 16),
            Text(
              'At TuneTastic, we are dedicated to providing music enthusiasts with a unique and immersive offline music player experience. Our app, built using Flutter, combines cutting-edge technology with a passion for music to deliver a seamless and personalized music journey. With TuneTastic, you can explore and enjoy your favorite songs, discover new tracks, and enhance your music experience in ways you never thought possible.',
              style: TextStyle(
                fontSize: 18,
                color: Colors.white,
              ),
            ),
            SizedBox(height: 16),
            Text(
              'Our Mission',
              style: TextStyle(
                fontSize: 20,
                color: Colors.white,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: 8),
            Text(
              'Our mission is to revolutionize the way you interact with music. We understand that music is more than just a background soundtrack; it\'s an integral part of our lives. TuneTastic empowers you to dive deep into the world of music, discover new artists, and effortlessly connect with the songs that resonate with your soul. With our advanced features and intuitive interface, we strive to make TuneTastic your go-to destination for offline music playback.',
              style: TextStyle(
                fontSize: 18,
                color: Colors.white,
              ),
            ),
            SizedBox(height: 16),
            Text(
              'Key Features',
              style: TextStyle(
                fontSize: 20,
                color: Colors.white,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: 8),
            Text(
              '1. Offline Playback: Enjoy your music library without worrying about internet connectivity. TuneTastic lets you store and play your favorite tracks offline, ensuring uninterrupted listening pleasure.',
              style: TextStyle(
                fontSize: 18,
                color: Colors.white,
              ),
            ),
            SizedBox(
              height: 8,
            ),
            Text(
              '2.Intuitive Interface: Navigate through your music collection effortlessly with our user-friendly interface. TuneTastic is designed to provide a seamless and enjoyable browsing experience.',
              style: TextStyle(
                fontSize: 18,
                color: Colors.white,
              ),
            ),
            SizedBox(
              height: 8,
            ),
            Text(
              '3.Favorites: Easily mark your favorite tracks for quick access. With the Favorites feature, you can create a personalized playlist of songs you love the most.',
              style: TextStyle(
                fontSize: 18,
                color: Colors.white,
              ),
            ),
            SizedBox(
              height: 8,
            ),
            Text(
              '4.Playlists: Organize your music into custom playlists tailored to your mood or activity. Create, edit, and manage playlists effortlessly with TuneTastic.',
              style: TextStyle(
                fontSize: 18,
                color: Colors.white,
              ),
            ),
            Text(
              '5.Search: Find any song or artist in seconds with our powerful search feature. TuneTastic allows you to quickly locate and play your desired tracks with ease.',
              style: TextStyle(
                fontSize: 18,
                color: Colors.white,
              ),
            ),
            Text(
              '6.Mostly Played: Keep track of your most-listened-to songs with the Mostly Played feature. TuneTastic automatically curates a playlist of your top tracks for your convenience.',
              style: TextStyle(
                fontSize: 18,
                color: Colors.white,
              ),
            ),
            Text(
              '7.Recently Played: Rediscover recently enjoyed music with the Recently Played section. TuneTastic keeps track of your listening history, making it easy to revisit your favorite tunes.',
              style: TextStyle(
                fontSize: 18,
                color: Colors.white,
              ),
            ),
            SizedBox(height: 16),
            Text(
              '7.Recently Played: Rediscover recently enjoyed music with the Recently Played section. TuneTastic keeps track of your listening history, making it easy to revisit your favorite tunes.',
              style: TextStyle(
                fontSize: 18,
                color: Colors.white,
              ),
            ),
            SizedBox(height: 16),
            Text(
              'We are committed to continuously improving TuneTastic and providing you with the best offline music player on the market. Our team of dedicated developers and music enthusiasts work tirelessly to enhance our features, integrate new technologies, and bring you regular updates that elevate your music journey.',
              style: TextStyle(
                fontSize: 18,
                color: Colors.white,
              ),
            ),
            SizedBox(height: 16),
            Text(
              'Join the TuneTastic community today and immerse yourself in a world of music like never before. Let the rhythms, melodies, and lyrics resonate deep within your soul as you explore the vast universe of offline music with TuneTastic.',
              style: TextStyle(
                fontSize: 18,
                color: Colors.white,
              ),
            ),
            SizedBox(height: 16),
            Text(
              'Happy Vibing!',
              style: TextStyle(
                fontSize: 18,
                color: Colors.white,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: 16),
            Text(
              'The TuneTastic Team',
              style: TextStyle(
                fontSize: 18,
                color: Colors.white,
              ),
            ),
          ],
        ),
      ),
      backgroundColor: Color.fromARGB(255, 40, 54, 38),
    );
  }
}
