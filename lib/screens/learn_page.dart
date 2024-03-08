import 'package:appathon/utils/colors.dart';
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

class Video {
  final String thumbnailUrl;
  final String title;
  final String description;
  final String videoUrl;

  Video({
    required this.thumbnailUrl,
    required this.title,
    required this.description,
    required this.videoUrl,
  });
}

Future<void> _launchUrl(Uri _url) async {
  if (!await launchUrl(_url, mode: LaunchMode.inAppWebView)) {
    throw Exception('Could not launch $_url');
  }
}

class LearnPage extends StatelessWidget {
  LearnPage({super.key});
  final List<Video> videos = [
    Video(
      thumbnailUrl: 'assets/images/thumb0.jpg',
      title:
          'How to Start Dairy Farming for Beginner | Cow Farming Guide - Everything You Need to Know',
      description:
          'This video is for people who are interested in how to start dairy farming on their own as a beginner. It provides an overview of what is involved in dairy farming and what you need to do to get started.',
      videoUrl: 'https://www.youtube.com/watch?v=CfblW5ZxXQ0',
    ),
    Video(
      thumbnailUrl: 'assets/images/thumb1.jpg',
      title:
          'डेयरी की कमाई और खर्चे का पूरा गणित | 10 cow dairy farm income | dairy farming business plan #dairy',
      description:
          'Calculating the budget, expenses, and potential profit for a dairy farm business in India can be a complex process and highly dependent on various factors, including the scale of the operation, location, breed of cattle, and market conditions. Here, I\'ll provide a simplified example of a small to medium-sized dairy farm to give you an idea of the calculations involved.',
      videoUrl: 'https://youtu.be/69dCjNmj5H0',
    ),
    Video(
      thumbnailUrl: 'assets/images/thumb2.jpg',
      title:
          'Dairy Farm Management | మీరు డెయిరీ పెట్టాలనుకుంటే.. ఏవేవి ఎక్కడ ఉండాలి? ఎలా సెట్ చేయాలంటే? ToneAgri',
      description:
          'Dairy Farm Management Guide. Gir and Sahiwal Cow Milk Business Explained by Indukuri Kishore Kumar, SID\'s Farm Founder, Tallapally, Shabad Mandal, Rangareddi District.',
      videoUrl: 'https://youtu.be/FuEthT2XzJo',
    ),
    Video(
      thumbnailUrl: 'assets/images/thumb3.jpg',
      title:
          'பால் மாடுகள் வளர்ப்பில் தெரிந்து கொள்ள வேண்டியது |Dairy farm|#sgacreation |Tamil |',
      description:
          'புதிதாக பால் பண்ணை ஆரம்பிப்பவர்கள் இந்த காணொளியை பார்த்து முழுதாக தெரிந்து கொள்ளலாம்',
      videoUrl: 'https://youtu.be/DZfkkbVUi0Y',
    ),
    // Add more video objects here
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: MyColors.background,
      appBar: AppBar(
        titleSpacing: 0.0,
        iconTheme: IconThemeData(
          color: MyColors.col3,
          size: 40,
        ),
        title: Row(
          children: [
            Container(
                width: 35,
                height: 35,
                child: Image.asset('assets/images/learn0.png')),
            SizedBox(
              width: 10,
            ),
            Text(
              'Learn',
              style: TextStyle(
                  fontFamily: 'Europa', fontSize: 28, color: MyColors.col3),
            ),
          ],
        ),
        backgroundColor: MyColors.background,
      ),
      body: Padding(
        padding: const EdgeInsets.only(top: 8.0),
        child: ListView.builder(
          itemCount: videos.length,
          itemBuilder: (context, index) {
            final video = videos[index];
            return Padding(
              padding: const EdgeInsets.only(left: 8.0, right: 8.0),
              child: Card(
                elevation: 4.0,
                child: ListTile(
                  leading: Image.asset(video.thumbnailUrl),
                  title: Text(video.title),
                  subtitle: Text(video.description),
                  onTap: () {
                    _launchUrl(Uri.parse(video.videoUrl));
                  },
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}
