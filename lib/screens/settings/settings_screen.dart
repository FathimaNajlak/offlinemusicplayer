import 'package:flutter/material.dart';
import 'package:podcastapp/screens/settings/privacy_policy_screen.dart';
import 'package:podcastapp/screens/settings/terms_and_conditions_screen.dart';
import 'about_us_screen.dart';

class SettingsScreen extends StatefulWidget {
  const SettingsScreen({Key? key}) : super(key: key);

  @override
  State<SettingsScreen> createState() => _SettingsScreenState();
}

class _SettingsScreenState extends State<SettingsScreen> {
  bool istrue = false;
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
            'Settings',
            style: TextStyle(
                color: Color.fromARGB(255, 247, 243, 243),
                fontWeight: FontWeight.bold),
          ),
          leading: IconButton(
            onPressed: () {
              Navigator.pop(context);
            },
            icon: const Icon(
              Icons.arrow_back,
              size: 28,
              color: Color.fromARGB(255, 234, 233, 233),
            ),
          ),
        ),
        body: Column(
          children: [
            ListTile(
              title: const Text('Privacy Policy'),
              textColor: Colors.white,
              trailing: Icon(
                Icons
                    .privacy_tip_outlined, // Changed to outlined privacy tip icon
                color: Colors.white,
              ),
              onTap: () {
                Navigator.of(context).push(
                  MaterialPageRoute(
                    builder: (context) => const PrivacyPolicyScreen(),
                  ),
                );
              },
            ),
            ListTile(
              title: const Text('Terms & Conditions'),
              textColor: Colors.white,
              trailing: Icon(
                Icons.article_outlined, // Changed to outlined article icon
                color: Colors.white,
              ),
              onTap: () {
                Navigator.of(context).push(
                  MaterialPageRoute(
                    builder: (context) => const TermsAndConditionsScreen(),
                  ),
                );
              },
            ),
            ListTile(
              title: const Text('About Us'),
              textColor: Colors.white,
              trailing: Icon(
                Icons.info_outline, // Changed to outlined info icon
                color: Colors.white,
              ),
              onTap: () {
                Navigator.of(context).push(
                  MaterialPageRoute(
                    builder: (context) => const AboutUsScreen(),
                  ),
                );
              },
            ),
          ],
        ),
        backgroundColor: Color.fromARGB(255, 40, 54, 38),
      ),
    );
  }
}
