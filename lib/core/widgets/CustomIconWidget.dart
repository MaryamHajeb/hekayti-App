import 'package:avatar_glow/avatar_glow.dart';
import 'package:flutter/material.dart';

import '../AppTheme.dart';

class CustomIconWidget extends StatefulWidget {
  CustomIconWidget(
      {Key? key,
      required this.primaryIcon,
      required this.onTap,
      required this.status,
      required this.secondaryIcon,
      required this.primaryColor,
      required this.secondaryColor})
      : super(key: key);
  final primaryIcon;
  final secondaryIcon;
  final onTap;
  bool status;
  Color primaryColor;
  Color secondaryColor;
  @override
  State<CustomIconWidget> createState() => _CustomIconWidgetState();
}

class _CustomIconWidgetState extends State<CustomIconWidget> {
  @override
  Widget build(BuildContext context) {
    return AvatarGlow(
      animate: !widget.status,
      duration: Duration(seconds: 1),
      child: Container(
        height: 50,
        width: 50,
        decoration: BoxDecoration(
            color: widget.status ? widget.primaryColor : widget.secondaryColor,
            border: Border.all(color: Colors.white, width: 2),
            borderRadius: BorderRadius.all(Radius.circular(15))),
        child: Center(
          child: IconButton(
              onPressed: () {
                setState(() {
                  widget.onTap();
                });
              },
              icon: widget.status ? widget.primaryIcon : widget.secondaryIcon),
        ),
      ),
    );
  }
}
