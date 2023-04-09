import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:hikayati_app/core/util/ScreenUtil.dart';
import 'package:hikayati_app/features/Story/presintation/manager/Slied_event.dart';

import '../../../../core/app_theme.dart';
import '../../../../core/util/common.dart';
import '../../../../core/widgets/CastemInput.dart';
import '../../../../core/widgets/CustemIcon.dart';
import '../../../../core/widgets/CustemIcon2.dart';
import '../../../../injection_container.dart';
import '../manager/Slied_bloc.dart';
import '../manager/Slied_state.dart';

class SliedPage extends StatefulWidget {
  final id;
   SliedPage({Key? key,required this.id}) : super(key: key);

  @override
  State<SliedPage> createState() => _SliedPageState();
}

class _SliedPageState extends State<SliedPage> {
  ScreenUtil screenUtil = ScreenUtil();
  bool isSpack=false;
  bool islisnt=false;
  Widget SliedWidget=Center();
  int currentIndexPage =0;
  PageController pageControler=PageController();
  TextEditingController result = TextEditingController();
  @override
  Widget build(BuildContext context) {
    screenUtil.init(context);
    return Scaffold(
      body: Directionality(
        textDirection: TextDirection.rtl,
        child: BlocProvider(
          create:(context)=>sl<SliedBloc>() ,
          child:BlocConsumer<SliedBloc,SliedState>(
            listener: (_context,state){
              if(state is SliedError){
                print(state.errorMessage);
              }
            },
            builder: (_context,state){
              if(state is SliedInitial){
                BlocProvider.of<SliedBloc>(_context).add(GetAllSlied( story_id: widget.id.toString(),tableName: 'meadia'));
              }

              if(state is SliedLoading){
                SliedWidget=CircularProgressIndicator();
              }

              if(state is SliedILoaded){
                //TODO::Show Slied here

                SliedWidget=       Container(
                  decoration: const BoxDecoration(
                    image: DecorationImage(
                        image: AssetImage(
                          'assest/images/backgraond.png',
                        ),
                        fit: BoxFit.fill),
                  ),
                  height: screenUtil.screenHeight * 1,
                  width: screenUtil.screenWidth * 1,
                  child: Center(
                      child: Row(
                        children: [
                          Container(
                            width: screenUtil.screenWidth * .1,
                            height: screenUtil.screenHeight * 1,
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: [
                                CustemIcon2(icon: Icon(Icons.home,),ontap: (){
                                  Navigator.pop(context);
                                }),
                                Column(
                                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                                  children: [
                                    isSpack ==false?  CustemIcon2(icon: Icon(Icons.headset_mic_outlined,),ontap: (){
                                      setState(() {
                                        isSpack=true ;


                                      });

                                    }):                        CustemIcon(icon: Icon(Icons.headset_mic_outlined,),ontap: (){}),




                                    SizedBox(height: 30,),
                                    isSpack ==false?  CustemIcon2(icon: Icon(Icons.mic,),ontap: (){
                                      setState(() {
                                        isSpack=true ;


                                      });

                                    }):                        CustemIcon(icon: Icon(Icons.mic,),ontap: (){}),

                                  ],
                                )
                              ],
                            ),
                          ),
                          Container(
                            height: screenUtil.screenHeight * 1,
                            width: screenUtil.screenWidth * .8,
                            child: Card(
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(5.0),
                              ),
                              child: PageView.builder(
                                itemCount: state.SliedModel.length,
                                reverse: true,
                                controller: pageControler,
                                itemBuilder: (context, index) {
                                  return  InkWell(
                                    onTap: (){

                                      setState(() {
                                        currentIndexPage = index;

                                      });
                                    },
                                    child: Container(
                                      margin: EdgeInsets.all(5),
                                      decoration: BoxDecoration(
                                          color: Colors.white,
                                          borderRadius: BorderRadius.all(Radius.circular(15))),
                                      child: Expanded(
                                        child: Column(

                                          crossAxisAlignment: CrossAxisAlignment.center,
                                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                                          children: [
                                            Container(

                                                width: screenUtil.screenWidth * 1,
                                                height: screenUtil.screenHeight * .8,
                                                padding:
                                                EdgeInsets.only(right: 10, left: 10, top: 10),
                                                child: Image.asset(
                                                  'assest/images/storypages.png',
                                                  fit: BoxFit.cover,
                                                )),
                                            Container(


                                              width: screenUtil.screenHeight * 2,
                                              height: screenUtil.screenHeight *.15,
                                              child: Row(

                                                crossAxisAlignment: CrossAxisAlignment.center,
                                                mainAxisAlignment: MainAxisAlignment.spaceAround,
                                                children: [
                                                  InkWell(
                                                    onTap: (){
                                                      setState(() {
                                                        index =index+1;
                                                        pageControler.nextPage(duration: Duration(seconds: 1), curve: Curves.bounceInOut);
                                                      });
                                                    },
                                                    child: Image.asset('assest/images/right_arrow.png'),
                                                  ),

                                                  Column(
                                                    children: [
                                                      SizedBox(height: 6,),
                                                      Text(state.SliedModel[index].text.toString(),style: TextStyle(fontSize: 15)),
                                                        SizedBox(height: 7,),
                                                      Text('${state.SliedModel.length}/${index.toString()}', style: TextStyle(color: AppTheme.primaryColor,fontSize: 14)),

                                                    ],
                                                  ),

                                                  InkWell(
                                                    onTap: (){
                                                      setState(() {
                                                        index =index+1;
                                                        pageControler.previousPage(duration: Duration(seconds: 1), curve: Curves.bounceInOut);
                                                      });
                                                    },
                                                    child: Image.asset('assest/images/left_arrow.png'),
                                                  ),


                                                ],
                                              ),
                                            )
                                          ],
                                        ),
                                      ),
                                    ),
                                  );
                                },),
                            ),
                          ),
                        ],
                      )),
                );
              }

              return SliedWidget;
            },
          ) ,
        )
      ),
    );
  }
}
