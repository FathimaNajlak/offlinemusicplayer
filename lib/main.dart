import 'package:flutter/material.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:path_provider/path_provider.dart';
import 'package:podcastapp/Screens/splash_screen.dart';

import 'model/song_model.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await initPathProvider();
  await Hive.initFlutter();
  if (!Hive.isAdapterRegistered(AllSongModelAdapter().typeId)) {
    Hive.registerAdapter(AllSongModelAdapter());
  }
  runApp(const MyApp());
}

Future<void> initPathProvider() async {
  // Initialize path_provider
  await getApplicationDocumentsDirectory();
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});
  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> with WidgetsBindingObserver {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addObserver(this);
  }

  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);
    super.dispose();
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    // Add any necessary logic here
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: const SplashScreen(),
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        bottomSheetTheme: const BottomSheetThemeData(
          backgroundColor: Colors.transparent,
        ),
      ),
    );
  }
}
