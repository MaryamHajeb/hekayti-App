import 'package:flutter/material.dart';

import '../app_theme.dart';

class CustemIcon extends StatefulWidget {
  CustemIcon({Key? key, required this.icon, required this.ontap})
      : super(key: key);
  final icon;
  final ontap;

  @override
  State<CustemIcon> createState() => _CustemIconState();
}

class _CustemIconState extends State<CustemIcon> {
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 50,
      width: 50,
      decoration: BoxDecoration(
          color: AppTheme.primaryColor,
          border: Border.all(color: Colors.white, width: 2),
          borderRadius: BorderRadius.all(Radius.circular(15))),
      child: Center(
        child: IconButton(
            color: Colors.white,
            onPressed: () {
              setState(() {
                widget.ontap();
              });
            },
            icon: widget.icon),
      ),
    );
  }
}
