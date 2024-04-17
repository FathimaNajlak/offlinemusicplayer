import 'package:flutter/material.dart';

class PrivacyPolicyScreen extends StatelessWidget {
  const PrivacyPolicyScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.black,
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.vertical(
            bottom: Radius.circular(16),
          ),
        ),
        title: const Text(
          'Privacy Policy',
          style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
        ),
        leading: IconButton(
          onPressed: () {
            Navigator.pop(context);
          },
          icon: const Icon(
            Icons.arrow_back,
            size: 28,
            color: Colors.white,
          ),
        ),
      ),
      body: const SingleChildScrollView(
        padding: EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'At AudioBliss, we are committed to protecting your privacy and ensuring the security of your personal information. This Privacy Policy explains how we collect, use, disclose, and protect your information when you use the AudioBliss application (referred to as "the App") developed using Flutter. By using the App, you consent to the practices described in this Privacy Policy.',
              style: TextStyle(color: Colors.white),
            ),
            SizedBox(height: 16),
            Text(
              'Information We Collect',
              style: TextStyle(
                fontSize: 18,
                color: Colors.white,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: 8),
            Text(
              'a. Personal Information: When you create an account on the App, we may collect personal information such as your name, email address, and profile picture. We may also collect information you provide when contacting our support team or participating in surveys or promotions.',
              style: TextStyle(color: Colors.white),
            ),
            SizedBox(height: 8),
            Text(
              'b. Usage Data: We collect anonymous usage data, including your interactions with the App, such as the features you use, the songs you listen to, and the settings you choose. This information helps us improve the App and provide you with a better user experience.',
              style: TextStyle(color: Colors.white),
            ),
            SizedBox(height: 8),
            Text(
              'c. Device Information: We may collect information about the device you use to access the App, including the device model, operating system version, unique device identifiers, and mobile network information. This information is used for analytics purposes and to troubleshoot technical issues.',
              style: TextStyle(color: Colors.white),
            ),
            SizedBox(height: 16),
            Text(
              'Use of Information',
              style: TextStyle(
                fontSize: 18,
                color: Colors.white,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: 8),
            Text(
              'a. We use the information we collect to:',
              style: TextStyle(color: Colors.white),
            ),
            SizedBox(height: 8),
            Text(
              '- Provide and personalize the App\'s features and content.',
              style: TextStyle(color: Colors.white),
            ),
            SizedBox(height: 8),
            Text(
              '- Improve and optimize the performance and user experience of the App.',
              style: TextStyle(color: Colors.white),
            ),
            SizedBox(height: 8),
            Text(
              '- Respond to your inquiries, provide customer support, and address your concerns.',
              style: TextStyle(color: Colors.white),
            ),
            SizedBox(height: 8),
            Text(
              '- Send you administrative and promotional emails related to the App.',
              style: TextStyle(color: Colors.white),
            ),
            SizedBox(height: 8),
            Text(
              '- Monitor and analyze trends, usage, and activities in connection with the App.',
              style: TextStyle(color: Colors.white),
            ),
            SizedBox(height: 8),
            Text(
              '- Detect, investigate, and prevent fraudulent or unauthorized activities.',
              style: TextStyle(color: Colors.white),
            ),
            SizedBox(height: 8),
            Text(
              'b. We may also aggregate and anonymize the information we collect to generate statistical or analytical data for internal use or sharing with third parties. This data does not personally identify you and is used for purposes such as market research and improving the App.',
              style: TextStyle(color: Colors.white),
            ),
            SizedBox(height: 16),
            Text(
              'Data Sharing and Disclosure',
              style: TextStyle(
                fontSize: 18,
                color: Colors.white,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: 8),
            Text(
              'a. We may share your personal information in the following circumstances:',
              style: TextStyle(color: Colors.white),
            ),
            SizedBox(height: 8),
            Text(
              '- With service providers who assist us in operating the App and delivering services to you. These service providers are bound by confidentiality obligations and are prohibited from using your information for any other purpose.',
              style: TextStyle(color: Colors.white),
            ),
            SizedBox(height: 8),
            Text(
              '- In response to a legal request, such as a subpoena, court order, or government investigation, or to comply with applicable laws or regulations.',
              style: TextStyle(color: Colors.white),
            ),
            SizedBox(height: 8),
            Text(
              '- If we believe it is necessary to protect the rights, property, or safety of AudioBliss, our users, or others.',
              style: TextStyle(color: Colors.white),
            ),
            SizedBox(height: 8),
            Text(
              'b. We may also disclose aggregated, non-personally identifiable information to third parties for various purposes, including marketing and advertising.',
              style: TextStyle(color: Colors.white),
            ),
            SizedBox(height: 16),
            Text(
              'Data Security',
              style: TextStyle(
                fontSize: 18,
                color: Colors.white,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: 8),
            Text(
              'a. We implement industry-standard security measures to protect your personal information from unauthorized access, disclosure, alteration, or destruction. However, no method of transmission or electronic storage is 100% secure, and we cannot guarantee absolute security.',
              style: TextStyle(color: Colors.white),
            ),
            SizedBox(height: 8),
            Text(
              'b. You are responsible for maintaining the confidentiality of your account credentials and ensuring the security of your device. Please notify us immediately if you suspect any unauthorized access or use of your account.',
              style: TextStyle(color: Colors.white),
            ),
            SizedBox(height: 16),
            Text(
              'Third-Party Links and Services',
              style: TextStyle(
                fontSize: 18,
                color: Colors.white,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: 8),
            Text(
              'a. The App may contain links to third-party websites, services, or advertisements. We are not responsible for the privacy practices or content of these third parties. We encourage you to read the privacy policies of those third parties before interacting with them.',
              style: TextStyle(color: Colors.white),
            ),
            SizedBox(height: 16),
            Text(
              "Children's Privacy",
              style: TextStyle(
                fontSize: 18,
                color: Colors.white,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: 8),
            Text(
              'a. The App is not intended for use by children under the age of 13. We do not knowingly collect personal information from children under 13. If you believe we have collected information from a child under 13, please contact us, and we will take steps to remove the information.',
              style: TextStyle(color: Colors.white),
            ),
            SizedBox(height: 16),
            Text(
              'Changes to the Privacy Policy',
              style: TextStyle(
                fontSize: 18,
                color: Colors.white,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: 8),
            Text(
              'a. We may update this Privacy Policy from time to time. We will notify you of any material changes by posting the updated Privacy Policy within the App or by other means. Your continued use of the App after the effective date of the updated Privacy Policy constitutes your acceptance of the changes.',
              style: TextStyle(color: Colors.white),
            ),
            SizedBox(height: 16),
            Text(
              'Contact Us',
              style: TextStyle(
                fontSize: 18,
                color: Colors.white,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: 8),
            Text(
              'If you have any questions, concerns, or requests regarding this Privacy Policy or the App\'s privacy practices, please contact us at [Contact Information].',
              style: TextStyle(color: Colors.white),
            ),
            SizedBox(height: 16),
            Text(
              'By using the AudioBliss App, you signify your understanding and acceptance of this Privacy Policy.',
              style: TextStyle(
                fontStyle: FontStyle.italic,
                color: Colors.white,
              ),
            ),
          ],
        ),
      ),
      backgroundColor: const Color.fromARGB(255, 18, 18, 18),
    );
  }
}
