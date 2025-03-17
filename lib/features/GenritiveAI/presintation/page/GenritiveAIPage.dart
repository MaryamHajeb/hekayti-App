import 'package:flutter/material.dart';
import 'package:hikayati_app/core/AppTheme.dart';
import 'package:hikayati_app/core/util/ScreenUtil.dart';
import 'package:hikayati_app/gen/assets.gen.dart';
import 'package:hikayati_app/core/widgets/CustomPageRoute.dart';
import 'package:hikayati_app/features/GenritiveAI/presintation/page/StoryGenSettings.dart';
import 'package:lottie/lottie.dart';

class GenritiveAIPage extends StatefulWidget {
  const GenritiveAIPage({Key? key}) : super(key: key);

  @override
  State<GenritiveAIPage> createState() => _GenritiveAIPageState();
}

class _GenritiveAIPageState extends State<GenritiveAIPage> {
  ScreenUtil screenUtil = ScreenUtil();
  
  // Demo data for story cards
  final List<Map<String, String>> demoStories = [
    {'name': 'مغامرات في الغابة', 'image': 'assets/images/demo/forest.png'},
    {'name': 'رحلة إلى الفضاء', 'image': 'assets/images/demo/space.png'},
    {'name': 'أصدقاء البحر', 'image': 'assets/images/demo/sea.png'},
    {'name': 'حكايات الديناصورات', 'image': 'assets/images/demo/dino.png'},
    {'name': 'مملكة الألوان', 'image': 'assets/images/demo/colors.png'},
    {'name': 'أبطال المدينة', 'image': 'assets/images/demo/heroes.png'},
  ];

  @override
  Widget build(BuildContext context) {
    screenUtil.init(context);
    return Scaffold(
      floatingActionButton: Align(
        alignment: Alignment.bottomLeft,
        child: Padding(
          padding: EdgeInsets.only(left: 30.0, bottom: 20.0),
          child: FloatingActionButton(
            backgroundColor: Colors.white,
            onPressed: () {
              Navigator.push(
                context,
                CustomPageRoute(
                  child: StoryGenSettings(index: 0),
                ),
              );
            },
            child: SizedBox(
              width: 60,
              height: 60,
              child: Lottie.asset(
                "assets/json/create_ai.json",
                fit: BoxFit.cover,
              ),
            ),
          ),
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.startFloat,
      body: Container(
        height: screenUtil.screenHeight * 1,
        width: screenUtil.screenWidth * 1,
        decoration: BoxDecoration(
            image: DecorationImage(
                image: AssetImage('assets/images/backgraond.png'),
                fit: BoxFit.fill
            )
        ),
        child: Container(
          padding: EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              SizedBox(height: screenUtil.screenHeight * .02),
              Expanded(
                child: GridView.builder(
                  padding: EdgeInsets.symmetric(
                    horizontal: screenUtil.screenWidth * .01,
                    vertical: screenUtil.screenHeight * .01,
                  ),
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 3,
                    childAspectRatio: 15 / 14,
                    crossAxisSpacing: screenUtil.screenWidth * .015,
                    mainAxisSpacing: screenUtil.screenHeight * .05,
                  ),
                  itemCount: demoStories.length,
                  itemBuilder: (context, index) {
                    return DemoStoryCard(
                      name: demoStories[index]['name'] ?? '',
                      imageAsset: demoStories[index]['image'] ?? '',
                    );
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class DemoStoryCard extends StatelessWidget {
  final String name;
  final String imageAsset;

  const DemoStoryCard({
    Key? key,
    required this.name,
    required this.imageAsset,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final screenUtil = ScreenUtil()..init(context);

    return InkWell(
      onTap: () {
        // Show dialog indicating this is a demo
        showDialog(
          context: context,
          builder: (context) => AlertDialog(
            title: Text('قصة تجريبية', style: AppTheme.textTheme.headlineMedium),
            content: Text('هذه قصة تجريبية للعرض فقط. انقر على زر الإنشاء في الزاوية اليسرى السفلية لإنشاء قصة جديدة', style: AppTheme.textTheme.bodyLarge),
            actions: [
              TextButton(
                onPressed: () => Navigator.pop(context),
                child: Text('حسناً', style: TextStyle(color: AppTheme.primaryColor, fontWeight: FontWeight.bold)),
              ),
            ],
          ),
        );
      },
      child: Container(
        width: screenUtil.screenWidth * .25,
        height: screenUtil.screenHeight * .6,
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage('assets/images/storyBG.png'),
            fit: BoxFit.contain,
          ),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // We don't include stars here as requested
            SizedBox(height: 40), // Space where stars would be
            Container(
              height: screenUtil.screenHeight * .3,
              width: screenUtil.screenWidth * .14,
              child: ClipRRect(
                borderRadius: BorderRadius.circular(10),
                child: Image.asset(
                  imageAsset,
                  fit: BoxFit.cover,
                  // Using a fallback image in case the specified asset doesn't exist
                  errorBuilder: (context, error, stackTrace) {
                    return Container(
                      color: Colors.grey[300],
                      child: Icon(Icons.image, color: AppTheme.primaryColor, size: 40),
                    );
                  },
                ),
              ),
            ),
            SizedBox(height: 10),
            Text(
              name,
              style: AppTheme.textTheme.headlineSmall,
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ),
    );
  }
}
