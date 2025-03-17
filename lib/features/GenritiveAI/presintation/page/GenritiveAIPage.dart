import 'package:flutter/material.dart';
import 'package:hikayati_app/core/AppTheme.dart';
import 'package:hikayati_app/core/util/ScreenUtil.dart';
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

  @override
  Widget build(BuildContext context) {
    screenUtil.init(context);
    return Container(
      padding: EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          SizedBox(height: screenUtil.screenHeight * .05),
          Text(
            'إنشاء قصة جديدة',
            style: AppTheme.textTheme.displayMedium,
          ),
          SizedBox(height: screenUtil.screenHeight * .05),
          Container(
            width: screenUtil.screenWidth * 0.6,
            height: screenUtil.screenHeight * 0.4,
            child: Lottie.asset(
              "assets/json/animation_create.json",
              fit: BoxFit.contain,
            ),
          ),
          SizedBox(height: screenUtil.screenHeight * .05),
          Text(
            'يمكنك إنشاء قصتك الخاصة باستخدام الذكاء الاصطناعي',
            style: AppTheme.textTheme.bodyLarge,
            textAlign: TextAlign.center,
          ),
          SizedBox(height: screenUtil.screenHeight * .05),
          Container(
            width: screenUtil.screenWidth * 0.5,
            decoration: BoxDecoration(
              color: AppTheme.primaryColor,
              borderRadius: BorderRadius.circular(25),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.2),
                  blurRadius: 10,
                  offset: Offset(0, 5),
                ),
              ],
            ),
            child: TextButton(
              onPressed: () {
                Navigator.push(
                  context,
                  CustomPageRoute(
                    child: StoryGenSettings(index: 0),
                  ),
                );
              },
              child: Padding(
                padding: EdgeInsets.symmetric(vertical: 12, horizontal: 20),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(
                      Icons.add_circle,
                      color: Colors.white,
                      size: 24,
                    ),
                    SizedBox(width: 10),
                    Text(
                      'إنشاء قصة جديدة',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        fontFamily: AppTheme.fontFamily,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
