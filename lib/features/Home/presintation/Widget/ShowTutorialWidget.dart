import 'package:flutter/cupertino.dart';

class ShowTutorialWidget extends StatefulWidget {
  final image;
  ShowTutorialWidget({super.key, required this.image});

  @override
  State<ShowTutorialWidget> createState() => _ShowTutorialWidgetState();
}

class _ShowTutorialWidgetState extends State<ShowTutorialWidget> {
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 300,
      width: 300,
      child: Column(children: [
        Image.asset(
          'assets/images/' + widget.image,
        ),
      ]),
    );
  }
}
