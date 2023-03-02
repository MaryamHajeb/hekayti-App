import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

import 'core/widgets/CastemInput.dart';

class test extends StatefulWidget {
  const test({Key? key}) : super(key: key);

  @override
  State<test> createState() => _testState();
}

class _testState extends State<test> {
  TextEditingController ss=TextEditingController();
  @override
  Widget build(BuildContext context) {
    String  image ="images/test/boy1restLarge.svg";
    return Scaffold(
      body:   Center(
        child: CastemInput(text: 'hslkahd',controler: ss,icon: Icon(Icons.account_box),valdution: (value){},),
      ),

    );
  }
}
