import 'package:flutter/material.dart';

import '../AppTheme.dart';

class CustomMusicIcon extends StatelessWidget {
  Function onTap;
  bool status;
  CustomMusicIcon({super.key, required this.onTap, required this.status});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 50,
      width: 50,
      decoration: BoxDecoration(
          color: Colors.white,
          border: Border.all(color: AppTheme.primaryColor, width: 2),
          borderRadius: BorderRadius.all(Radius.circular(15))),
      child: Center(
        child: IconButton(
            onPressed: () {
              onTap();
            },
            icon: Icon(
              status ? Icons.volume_up_rounded : Icons.volume_off_rounded,
              color: AppTheme.primaryColor,
            )),
      ),
    );
  }
}
