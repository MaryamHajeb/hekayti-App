import 'package:flutter/material.dart';

import '../app_theme.dart';

class CustemIcon2 extends StatefulWidget {
   CustemIcon2({Key? key,required this.icon,required this.ontap}) : super(key: key);
final icon;
final ontap;

  @override
  State<CustemIcon2> createState() => _CustemIcon2State();
}

class _CustemIcon2State extends State<CustemIcon2> {
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 45,
      width: 50,
      decoration: BoxDecoration(
          color: Colors.white,
          border: Border.all(color: AppTheme.primaryColor,width: 2),
          borderRadius: BorderRadius.all(Radius.circular(15))
      ),
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
