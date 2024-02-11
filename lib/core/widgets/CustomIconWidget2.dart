import 'package:flutter/material.dart';

import '../AppTheme.dart';

class CustomIconWidget2 extends StatefulWidget {
  CustomIconWidget2({Key? key, required this.icon, required this.ontap})
      : super(key: key);
  final icon;
  final ontap;

  @override
  State<CustomIconWidget2> createState() => _CustomIconWidget2State();
}

class _CustomIconWidget2State extends State<CustomIconWidget2> {
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
              setState(() {
                widget.ontap();
              });
            },
            icon: widget.icon),
      ),
    );
  }
}
