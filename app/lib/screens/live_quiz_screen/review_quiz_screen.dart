import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:percent_indicator/circular_percent_indicator.dart';
import 'package:focus_flip/utils/constant.dart';

import '../../models/utils_model.dart';
import '../../utils/images.dart';
import '../../utils/widget_assets.dart';

class ReviewQuizScren extends StatefulWidget {
  const ReviewQuizScren({super.key});

  @override
  State<ReviewQuizScren> createState() => _ReviewQuizScrenState();
}

class _ReviewQuizScrenState extends State<ReviewQuizScren> {
  List<ReviewQuizModel> questions = [
    ReviewQuizModel(1, 'Can you name the top 3 Premier League goal scorers?',
        '-', true, false),
    ReviewQuizModel(
        2,
        'Name the clubs in England\'s top football division for the 2020–21 season.',
        '-',
        true,
        false),
    ReviewQuizModel(
        3,
        'Which player scored the fastest hat-trick in the Premier League?',
        'Sadio Mane',
        false,
        false),
    ReviewQuizModel(4, 'Theodorus of Samos is the person who invented keys?',
        'True', false, false),
    ReviewQuizModel(5, 'Theodorus of Samos is the person who invented keys?',
        'Light Year', false, false),
    ReviewQuizModel(6, 'How to pronounce Wojciech Szczesny?',
        'voy·chekshez·nee', false, true),
    ReviewQuizModel(
        7,
        'Which three players shared the Premier League Golden Boot in 2018-19?',
        'Mohamed Salah, Sadio Mane, Aubameyang',
        false,
        false),
    ReviewQuizModel(8, 'What is the best club in England?', "Manchester United",
        false, false),
    ReviewQuizModel(9, 'Sort the cartoon name in the picture above into order',
        'Bart Simpson', false, false),
    ReviewQuizModel(10, 'What does UAV stand for drone?',
        'Unmanned Aerial Vehicle', false, false)
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: Material(
        elevation: 20,
        borderRadius: const BorderRadius.only(
            topLeft: Radius.circular(20), topRight: Radius.circular(20)),
        child: Container(
          padding: EdgeInsets.only(
              left: ScreenUtil().setWidth(24),
              right: ScreenUtil().setWidth(24)),
          width: MediaQuery.of(context).size.width,
          height: ScreenUtil().setHeight(108),
          decoration: const BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(20), topRight: Radius.circular(20))),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              widgetButton(
                  widgetText('Edit Answer',
                      fontWeight: FontWeight.w500,
                      fontSize: ScreenUtil().setSp(16),
                      color: ColorsHelpers.primaryColor),
                  () {},
                  height: 56.0,
                  width: 156.0,
                  radius: 20.0,
                  colorBorder: ColorsHelpers.secondLavender,
                  color: Colors.white,
                  widthBorder: 1.0),
              widgetButton(
                widgetText('Submit',
                    fontWeight: FontWeight.w500,
                    fontSize: ScreenUtil().setSp(16),
                    color: Colors.white),
                () {},
                height: 56.0,
                width: 156.0,
                radius: 20.0,
              ),
            ],
          ),
        ),
      ),
      body: SingleChildScrollView(
        child: Container(
          height: MediaQuery.of(context).size.height * 2,
          width: MediaQuery.of(context).size.width,
          margin: EdgeInsets.only(
              top: ScreenUtil().setHeight(60),
              left: ScreenUtil().setWidth(24),
              right: ScreenUtil().setWidth(24)),
          child:
              Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
            Row(children: [
              Expanded(
                flex: 6,
                child: Container(
                  margin: EdgeInsets.only(
                    right: ScreenUtil().setWidth(20),
                    left: ScreenUtil().setWidth(50),
                  ),
                  alignment: Alignment.center,
                  child: widgetText('Review Answers',
                      fontSize: ScreenUtil().setSp(24),
                      fontWeight: FontWeight.w500,
                      color: Colors.black),
                ),
              ),
              GestureDetector(
                onTap: () {
                  Navigator.pop(context);
                },
                child: const Icon(
                  Icons.close,
                  color: Colors.black,
                ),
              )
            ]),
            Container(
              margin: EdgeInsets.only(top: ScreenUtil().setHeight(16)),
              height: ScreenUtil().setHeight(244),
              width: MediaQuery.of(context).size.width,
              padding: EdgeInsets.only(
                  top: ScreenUtil().setHeight(24),
                  left: ScreenUtil().setWidth(16),
                  right: ScreenUtil().setWidth(16)),
              decoration: BoxDecoration(
                  borderRadius: const BorderRadius.all(Radius.circular(20)),
                  color: ColorsHelpers.primaryColor),
              child: Stack(children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Container(
                          margin: EdgeInsets.only(
                              bottom: ScreenUtil().setHeight(4)),
                          child: widgetText('QUIZ NAME',
                              fontWeight: FontWeight.w500,
                              fontSize: ScreenUtil().setSp(14),
                              color: Colors.white.withOpacity(0.7)),
                        ),
                        widgetText('English Premier League Quiz',
                            fontWeight: FontWeight.w500,
                            fontSize: ScreenUtil().setSp(16),
                            color: Colors.white)
                      ],
                    ),
                    Align(
                      alignment: Alignment.topRight,
                      child: Container(
                        width: ScreenUtil().setWidth(48),
                        height: ScreenUtil().setHeight(48),
                        alignment: Alignment.center,
                        decoration: BoxDecoration(
                          borderRadius:
                              const BorderRadius.all(Radius.circular(12)),
                          color: Colors.white.withOpacity(0.1),
                        ),
                        child: SvgPicture.asset(
                          Images.iconPuzzleOnly,
                          height: 24,
                          width: 24,
                        ),
                      ),
                    )
                  ],
                ),
                Align(
                  alignment: Alignment.bottomCenter,
                  child: Container(
                    height: ScreenUtil().setHeight(148),
                    width: ScreenUtil().setWidth(295),
                    decoration: BoxDecoration(
                        color: ColorsHelpers.pink,
                        borderRadius: const BorderRadius.only(
                            topLeft: Radius.circular(20),
                            topRight: Radius.circular(20))),
                    child: Stack(
                      children: [
                        Positioned(
                            right: 0,
                            bottom: -10,
                            child: ClipRRect(
                              borderRadius: const BorderRadius.only(
                                  bottomLeft: Radius.circular(20)),
                              child: RotationTransition(
                                turns: const AlwaysStoppedAnimation(0 / 360),
                                child: SvgPicture.asset(
                                  Images.ovalReview,
                                  width: 100,
                                  height: 100,
                                ),
                              ),
                            )),
                        Positioned(
                            right: 66,
                            top: 30,
                            child: SvgPicture.asset(
                              Images.ovalBig,
                              width: 20,
                              height: 20,
                            )),
                        Positioned(
                            left: 66,
                            bottom: -25,
                            child: SvgPicture.asset(
                              Images.ovalBig,
                              width: 56,
                              height: 56,
                            )),
                        Center(
                          child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Container(
                                  margin: EdgeInsets.only(
                                      right: ScreenUtil().setWidth(20)),
                                  child: CircularPercentIndicator(
                                    radius: 50.0,
                                    lineWidth: 10.0,
                                    percent: 0.8,
                                    animation: true,
                                    progressColor: Colors.white,
                                    circularStrokeCap: CircularStrokeCap.round,
                                    center: widgetText('8/10',
                                        fontWeight: FontWeight.w500,
                                        fontSize: ScreenUtil().setSp(22),
                                        color: Colors.white),
                                  ),
                                ),
                                Container(
                                  child: widgetText(
                                      'You answered 8\nout of 10\nquestions',
                                      fontWeight: FontWeight.w500,
                                      fontSize: ScreenUtil().setSp(16),
                                      color: Colors.white),
                                )
                              ]),
                        )
                      ],
                    ),
                  ),
                )
              ]),
            ),
            Container(
              margin: EdgeInsets.only(
                  top: ScreenUtil().setHeight(24),
                  bottom: ScreenUtil().setHeight(16)),
              child: widgetText('Your Answers',
                  fontWeight: FontWeight.w500,
                  fontSize: ScreenUtil().setSp(18),
                  color: Colors.black),
            ),
            Container(
              height: MediaQuery.of(context).size.height * 1.23,
              width: MediaQuery.of(context).size.width,
              decoration: BoxDecoration(
                  color: ColorsHelpers.grey5,
                  borderRadius: const BorderRadius.all(Radius.circular(20))),
              child: ListView.builder(
                scrollDirection: Axis.vertical,
                physics: const NeverScrollableScrollPhysics(),
                itemCount: 10,
                itemBuilder: (context, index) {
                  return Container(
                    padding: EdgeInsets.only(
                        left: ScreenUtil().setWidth(16),
                        right: ScreenUtil().setWidth(12)),
                    margin: EdgeInsets.only(bottom: ScreenUtil().setHeight(20)),
                    child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Container(
                            height: 32,
                            width: 32,
                            margin: EdgeInsets.only(
                                right: ScreenUtil().setWidth(16)),
                            alignment: Alignment.center,
                            decoration: const BoxDecoration(
                                color: Colors.white,
                                borderRadius:
                                    BorderRadius.all(Radius.circular(50))),
                            child: widgetText(
                                questions[index].number.toString(),
                                fontWeight: FontWeight.w500,
                                fontSize: 16,
                                color: ColorsHelpers.primaryColor),
                          ),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              SizedBox(
                                width: ScreenUtil().setWidth(215),
                                child: widgetText(questions[index].name!,
                                    fontWeight: FontWeight.w500,
                                    fontSize: ScreenUtil().setSp(14),
                                    color: Colors.black),
                              ),
                              const SizedBox(
                                height: 8,
                              ),
                              SizedBox(
                                width: ScreenUtil().setWidth(215),
                                child: widgetText(questions[index].answer!,
                                    fontWeight: FontWeight.w400,
                                    fontSize: ScreenUtil().setSp(14),
                                    color: ColorsHelpers.grey2),
                              )
                            ],
                          ),
                          questions[index].isSkip == true
                              ? const Icon(
                                  Icons.info_outline,
                                  color: Colors.amber,
                                )
                              : questions[index].isVn == true
                                  ? Icon(
                                      Icons.volume_up_outlined,
                                      color: ColorsHelpers.primaryColor,
                                    )
                                  : const SizedBox(
                                      height: 24,
                                      width: 24,
                                    )
                        ]),
                  );
                },
              ),
            )
          ]),
        ),
      ),
    );
  }
}
