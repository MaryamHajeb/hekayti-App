import 'package:flutter/material.dart';
import 'package:hikayati_app/core/app_theme.dart';

import '../../../../core/widgets/CustemIcon.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: TextDirection.rtl,
      child: Scaffold(
        body: Container(


            child: Stack(
              children: [
                Image.asset("images/backgraond.png",height: double.infinity,width: double.infinity, fit: BoxFit.fill),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Center(
                        child: Card(
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(15.0),
                      ),
                      child: Container(
                        height: 500,
                        margin: EdgeInsets.all(5),
                        width: 350,
                        decoration: BoxDecoration(
                            color: Colors.white,
                            border: Border.all(width: 3, color: AppTheme.primarySwatch.shade500),
                            borderRadius: BorderRadius.all(Radius.circular(15))),
                        child: Column(children: [
                          Padding(
                            padding: const EdgeInsets.only(
                                bottom: 10, top: 10, left: 10.0, right: 10),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text("للوالدين فقط",
                                    style: TextStyle(fontSize: 30)),
                                CustemIcon()
                              ],
                            ),
                          ),
                          Divider(
                            thickness: 2,
                            color: AppTheme.primarySwatch.shade500,
                          ),
                          Center(
                            child: Text("للوصول للاعدادات يجب حل هذه المساله :",
                                style: TextStyle(fontSize: 22)),
                          ),
                          Container(
                              decoration: BoxDecoration(
                                border: Border.all(width: 2,color: AppTheme.primarySwatch.shade400),
                                  color: AppTheme.primarySwatch.shade200,
                                  borderRadius: BorderRadius.circular(10)

                              ),
                              margin: EdgeInsets.only(top: 20, left: 50, right: 50),
                              child: TextField(
                                textDirection: TextDirection.rtl,
                                decoration: InputDecoration(
                                  enabledBorder: UnderlineInputBorder(
                                    borderSide: BorderSide(color: Colors.white),
                                  ),
                                  focusedBorder: UnderlineInputBorder(
                                    borderSide: BorderSide(color: Colors.transparent),
                                  ),
                                ),
                                cursorColor: AppTheme.primaryColor,
                              )),
                          Container(
                              decoration: BoxDecoration(
                                border: Border.all(width: 2,color: AppTheme.primarySwatch.shade400),
                                  color: AppTheme.primarySwatch.shade200,
                                  borderRadius: BorderRadius.circular(10)

                              ),
                              margin: EdgeInsets.only(top: 20, left: 100, right: 100),
                              child: TextField(
                                textDirection: TextDirection.rtl,
                                decoration: InputDecoration(
                                  enabledBorder: UnderlineInputBorder(
                                    borderSide: BorderSide(color: Colors.transparent),
                                  ),
                                  focusedBorder: UnderlineInputBorder(
                                    borderSide: BorderSide(color: Colors.transparent),
                                  ),
                                ),
                                cursorColor: AppTheme.primaryColor,
                              )),
                        ]),
                      ),
                    ))
                  ],
                ),
              ],
            )),
      ),
    );
  }
}
