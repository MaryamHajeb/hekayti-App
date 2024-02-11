import 'package:flutter/material.dart';

import '../../../../core/AppTheme.dart';
import '../../../../core/util/ScreenUtil.dart';
import '../../../../core/widgets/CustomFieldForSearch.dart';

class SearchWidget extends StatelessWidget {
  final keyTwo;
  final onSearch;
  final controller;
  SearchWidget(
      {super.key,
      required this.keyTwo,
      required this.onSearch,
      required this.controller});

  @override
  ScreenUtil screenUtil = ScreenUtil();

  Widget build(BuildContext context) {
    screenUtil.init(context);
    return Container(
        decoration: BoxDecoration(
            border:
                Border.all(color: AppTheme.primarySwatch.shade600, width: 2),
            color: Colors.white,
            borderRadius: BorderRadius.all(Radius.circular(10))),
        width: screenUtil.screenWidth * .4,
        height: screenUtil.screenHeight * .1,
        child: CustomFieldForSearch(
          onching: (value) => onSearch(value),
          valdution: (value) {},
          icon: Icon(
            Icons.search,
            color: AppTheme.primaryColor,
            key: keyTwo,
          ),
          text: 'بحث',
          controler: controller,
          size: screenUtil.screenWidth * .4,
        ));
  }
}
