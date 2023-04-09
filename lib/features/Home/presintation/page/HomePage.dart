import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hikayati_app/core/app_theme.dart';
import 'package:hikayati_app/core/widgets/CastemInput.dart';
import 'package:hikayati_app/features/Home/presintation/manager/Story_bloc.dart';
import 'package:hikayati_app/features/Settings/presintation/page/SettingPage.dart';

import '../../../../core/util/ScreenUtil.dart';
import '../../../../core/widgets/CustemIcon.dart';
import '../../../../core/widgets/CustomPageRoute.dart';
import '../../../../injection_container.dart';
import '../../../Regestrion/presintation/page/LoginPage.dart';
import '../../../Story/presintation/page/StoryPage.dart';
import '../Widget/StoryCard.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget StoryWidget=Center();
  ScreenUtil screenUtil = ScreenUtil();
  TextEditingController search = TextEditingController();
  Widget build(BuildContext context) {
    screenUtil.init(context);

    return Directionality(
      textDirection: TextDirection.rtl,
      child: SafeArea(
        child: Scaffold(
          body: Container(
            height: screenUtil.screenHeight * 1,
            width: screenUtil.screenWidth * 1,
            decoration: BoxDecoration(
                image: DecorationImage(
                    image: AssetImage('assest/images/backgraond.png'),
                    fit: BoxFit.fill)),
            child: SingleChildScrollView(
              child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        InkWell(
                          onTap: (){


                          },
                          child: CustemIcon(icon: Image.asset('assest/images/girl3.png', fit: BoxFit.cover), ontap: (){

                            Navigator.push(
                                context,
                                CustomPageRoute(  child:   SettingPage()));

                          },),
                        ),
                        Container(
                            decoration: BoxDecoration(
                                color: Colors.white,
                                border: Border.all(
                                    color: AppTheme.primarySwatch.shade400,
                                    width: 1),
                                borderRadius:
                                    BorderRadius.all(Radius.circular(10))),
                            width: screenUtil.screenWidth * .2,
                            height: screenUtil.screenHeight * .1,
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: [
                                Image.asset('assest/images/start.png'),
                                Text('2/24')
                              ],
                            )),
                        Container(
                            decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius:
                                    BorderRadius.all(Radius.circular(10))),
                            width: screenUtil.screenWidth * .4,
                            height: screenUtil.screenHeight * .1,
                            child: CastemInput(
                                valdution: (value) {},
                                icon: Icon(Icons.search),
                                text: 'بحث',
                                controler: search,size: 340,)),
                       CustemIcon(icon: Icon(Icons.volume_up_rounded,color: Colors.white), ontap: (){}),
                      ],
                    ),
                    SizedBox(height: 30),

                    BlocProvider(
                      create:(context)=>sl<StoryBloc>() ,
                      child:BlocConsumer<StoryBloc,StoryState>(
                        listener: (_context,state){
                          if(state is StoryError){
                            print(state.errorMessage);
                          }
                        },
                        builder: (_context,state){
                          if(state is StoryInitial){
                            BlocProvider.of<StoryBloc>(_context).add(GetAllStory(token: ''));
                          }

                          if(state is StoryLoading){
                            StoryWidget=CircularProgressIndicator();
                          }

                          if(state is StoryILoaded){
                            //TODO::Show Story here

                            StoryWidget=       Container(
                              height: screenUtil.screenHeight * .8,
                              width: double.infinity,
                              child: GridView.builder(
                                itemCount: state.storyModel.length,
                                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(

                                    crossAxisCount: 3),
                                itemBuilder: (context, index) {

                                  return InkWell(
                                      onTap: (){
                                        Navigator.push(
                                            context,
                                            CustomPageRoute(  child:   SliedPage(id: state.storyModel[index]?.id,)));

                                      },
                                      child: StoryCard(name: state.storyModel[index]?.name, starts: 2,));
                                },
                              ),
                            );
                          }

                          return StoryWidget;
                        },
                      ) ,
                    )
                  ]),
            ),
          ),
        ),
      ),
    );
  }
}
