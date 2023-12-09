import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:quezzy/utils/constant.dart';
import 'package:quezzy/utils/images.dart';
import 'package:quezzy/utils/widget_assets.dart';

class QuizReviewScreen extends StatefulWidget {
  const QuizReviewScreen({Key? key}) : super(key: key);

  @override
  QuizReviewScreenState createState() => QuizReviewScreenState();
}

class Questions {
  int? number;
  String? title;
  String? type;
  String? icon;

  Questions(this.number, this.title, this.type, this.icon);
}

class QuizReviewScreenState extends State<QuizReviewScreen> {
  final List<Questions> _questions = [
    Questions(
        1,
        'Which mathematical symbol was the title of Ed Sheeran’s first album in 2011?',
        'Multiple Choices',
        Images.quizMultiple),
    Questions(2, 'Bad Romance was Lady Gaga’s first No. 1 hit?',
        'True or False', Images.quizTrueFalse),
    Questions(3, 'What is the name of The Beatles’ first album?', 'Type Answer',
        Images.quizType),
    Questions(4, 'Who wrote the song \'Let\'s Get It On\'?', 'Voice Note',
        Images.quizVoice),
    Questions(5, 'Who was the 2 most streamed artist on Spotify in 2019?',
        'Checkbox', Images.quizCheckbox)
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: ColorsHelpers.primaryColor,
        elevation: 0,
        title: Center(
          child: widgetText(
            'Create Quiz',
            color: Colors.white,
            fontWeight: FontWeight.w500,
            fontSize: ScreenUtil().setSp(24),
          ),
        ),
        leading: Padding(
            padding: EdgeInsets.only(
              left: ScreenUtil().setWidth(24.0),
            ),
            child: ConstrainedBox(
              constraints: BoxConstraints(maxWidth: ScreenUtil().setWidth(24)),
              child: const BackButton(
                color: Colors.white,
              ),
            )),
        actions: [
          Padding(
            padding: EdgeInsets.only(right: ScreenUtil().setWidth(24.0)),
            child: PopupMenuButton(
                // add icon, by default "3 dot" icon
                // icon: Icon(Icons.book)
                elevation: 20,
                icon: ConstrainedBox(
                  constraints:
                      BoxConstraints(maxWidth: ScreenUtil().setWidth(24)),
                  child: SvgPicture.asset(Images.threeDots),
                ),
                offset: const Offset(-10, 50),
                shape: const RoundedRectangleBorder(
                  borderRadius: BorderRadius.all(
                    Radius.circular(12.0),
                  ),
                ),
                itemBuilder: (context) {
                  return [
                    PopupMenuItem<int>(
                      value: 0,
                      child: Container(
                        padding: EdgeInsets.only(
                          top: ScreenUtil().setHeight(8),
                          bottom: ScreenUtil().setHeight(4),
                          left: ScreenUtil().setWidth(4),
                          right: ScreenUtil().setWidth(4),
                        ),
                        child: Row(
                          children: [
                            Padding(
                              padding: EdgeInsets.only(
                                  right: ScreenUtil().setWidth(8)),
                              child: SvgPicture.asset(Images.duplicateIcon),
                            ),
                            widgetText(
                              'Duplicate',
                              fontSize: ScreenUtil().setSp(14),
                              color: ColorsHelpers.grey2,
                              fontWeight: FontWeight.w400,
                            ),
                          ],
                        ),
                      ),
                    ),
                    PopupMenuItem<int>(
                      value: 0,
                      child: Container(
                        padding: EdgeInsets.only(
                          top: ScreenUtil().setHeight(4),
                          bottom: ScreenUtil().setHeight(8),
                          left: ScreenUtil().setWidth(4),
                          right: ScreenUtil().setWidth(4),
                        ),
                        child: Row(
                          children: [
                            Padding(
                              padding: EdgeInsets.only(
                                  right: ScreenUtil().setWidth(8)),
                              child: SvgPicture.asset(
                                Images.trashIcon,
                                color: Colors.red,
                              ),
                            ),
                            widgetText(
                              'Delete',
                              fontSize: ScreenUtil().setSp(14),
                              color: Colors.red,
                              fontWeight: FontWeight.w400,
                            ),
                          ],
                        ),
                      ),
                    ),
                  ];
                },
                onSelected: (value) {
                  if (value == 0) {
                    log("Duplicate question.");
                  } else if (value == 1) {
                    log("Delete question.");
                  }
                }),
          )
        ],
      ),
      body: GestureDetector(
        onTap: () => FocusScope.of(context).requestFocus(FocusNode()),
        child: Container(
          width: MediaQuery.of(context).size.width,
          height: MediaQuery.of(context).size.height,
          color: ColorsHelpers.primaryColor,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            mainAxisSize: MainAxisSize.max,
            children: [
              Expanded(
                child: SingleChildScrollView(
                  scrollDirection: Axis.vertical,
                  child: Container(
                    margin: EdgeInsets.only(bottom: ScreenUtil().setHeight(8)),
                    width: MediaQuery.of(context).size.width,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Container(
                          margin:
                              EdgeInsets.only(top: ScreenUtil().setHeight(16)),
                          alignment: Alignment.topRight,
                          child: SvgPicture.asset(Images.quizReview),
                        ),
                        Container(
                          margin: EdgeInsets.only(
                            left: ScreenUtil().setWidth(8),
                            right: ScreenUtil().setWidth(8),
                          ),
                          padding: EdgeInsets.only(
                            top: ScreenUtil().setHeight(24),
                            left: ScreenUtil().setHeight(16),
                            right: ScreenUtil().setHeight(16),
                          ),
                          width: MediaQuery.of(context).size.width,
                          decoration: BoxDecoration(
                            borderRadius:
                                BorderRadius.circular(ScreenUtil().setSp(20)),
                            color: Colors.white,
                          ),
                          child: Column(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Container(
                                    padding: EdgeInsets.symmetric(
                                      horizontal: ScreenUtil().setWidth(12),
                                      vertical: ScreenUtil().setHeight(6),
                                    ),
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(
                                          ScreenUtil().setSp(8)),
                                      color: ColorsHelpers.grey5,
                                    ),
                                    child: Row(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.center,
                                      children: [
                                        ConstrainedBox(
                                          constraints: BoxConstraints(
                                            maxWidth: ScreenUtil().setWidth(16),
                                            maxHeight:
                                                ScreenUtil().setHeight(16),
                                          ),
                                          child:
                                              SvgPicture.asset(Images.techIcon),
                                        ),
                                        Padding(
                                          padding: EdgeInsets.only(
                                              left: ScreenUtil().setWidth(8)),
                                          child: widgetText(
                                            'TECH · QUIZZES',
                                            color: ColorsHelpers.primaryColor,
                                            fontWeight: FontWeight.w500,
                                            fontSize: ScreenUtil().setSp(12),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                  SvgPicture.asset(Images.pencil),
                                ],
                              ),
                              Container(
                                margin: EdgeInsets.only(
                                    top: ScreenUtil().setHeight(16)),
                                alignment: Alignment.topLeft,
                                child: widgetText(
                                  'Remote Work Tools Quiz',
                                  fontSize: ScreenUtil().setSp(20),
                                  fontWeight: FontWeight.w500,
                                  color: Colors.black,
                                ),
                              ),
                              Container(
                                margin: EdgeInsets.only(
                                  top: ScreenUtil().setHeight(16),
                                  bottom: ScreenUtil().setHeight(4),
                                ),
                                alignment: Alignment.topLeft,
                                child: widgetText(
                                  'Take this basic remote work tools quiz to test your tech knowledge.',
                                  fontSize: ScreenUtil().setSp(16),
                                  fontWeight: FontWeight.w400,
                                  color: ColorsHelpers.grey2,
                                ),
                              ),
                              Container(
                                alignment: Alignment.bottomCenter,
                                child: Stack(
                                  children: [
                                    Transform.translate(
                                      offset: Offset(
                                          0, ScreenUtil().setHeight(9.5)),
                                      child: SvgPicture.asset(
                                          Images.quizPurpleVector),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                        Container(
                          margin: EdgeInsets.only(
                            top: ScreenUtil().setWidth(16),
                            left: ScreenUtil().setWidth(8),
                            right: ScreenUtil().setWidth(8),
                          ),
                          padding: EdgeInsets.only(
                            bottom: ScreenUtil().setHeight(16),
                            left: ScreenUtil().setHeight(16),
                            right: ScreenUtil().setHeight(16),
                          ),
                          width: MediaQuery.of(context).size.width,
                          decoration: BoxDecoration(
                            borderRadius:
                                BorderRadius.circular(ScreenUtil().setSp(32)),
                            color: Colors.white,
                          ),
                          child: Column(
                            children: [
                              Stack(
                                alignment: Alignment.topCenter,
                                children: [
                                  Transform.translate(
                                    offset:
                                        Offset(0, ScreenUtil().setHeight(-6.1)),
                                    child: SvgPicture.asset(
                                        Images.quizWhiteVector),
                                  ),
                                  Container(
                                    width: ScreenUtil().setWidth(8),
                                    height: ScreenUtil().setHeight(8),
                                    decoration: BoxDecoration(
                                      color: ColorsHelpers.primaryColor,
                                      shape: BoxShape.circle,
                                    ),
                                  ),
                                ],
                              ),
                              Container(
                                margin: EdgeInsets.only(
                                    top: ScreenUtil().setHeight(12)),
                                width: MediaQuery.of(context).size.width,
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Row(
                                      children: [
                                        widgetText(
                                          'Questions',
                                          fontSize: ScreenUtil().setSp(18),
                                          fontWeight: FontWeight.w500,
                                        ),
                                        Container(
                                          width: ScreenUtil().setWidth(24),
                                          height: ScreenUtil().setWidth(24),
                                          alignment: Alignment.center,
                                          margin: EdgeInsets.only(
                                              left: ScreenUtil().setWidth(8)),
                                          decoration: BoxDecoration(
                                            borderRadius: BorderRadius.circular(
                                                ScreenUtil().setSp(8)),
                                            color: ColorsHelpers.primaryColor,
                                          ),
                                          child: widgetText(
                                            '5',
                                            fontSize: ScreenUtil().setSp(14),
                                            fontWeight: FontWeight.w700,
                                            color: Colors.white,
                                          ),
                                        ),
                                      ],
                                    ),
                                    SvgPicture.asset(Images.pencil),
                                  ],
                                ),
                              ),
                              Container(
                                alignment: Alignment.topLeft,
                                margin: EdgeInsets.only(
                                  top: ScreenUtil().setWidth(16),
                                ),
                                padding: EdgeInsets.only(
                                  top: ScreenUtil().setHeight(24),
                                  left: ScreenUtil().setHeight(16),
                                  right: ScreenUtil().setHeight(16),
                                ),
                                width: MediaQuery.of(context).size.width,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(
                                      ScreenUtil().setSp(20)),
                                  color: ColorsHelpers.grey5,
                                ),
                                child: Column(
                                  children: _questions
                                      .map((e) => Container(
                                            margin: EdgeInsets.only(
                                                bottom:
                                                    ScreenUtil().setHeight(16)),
                                            child: Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.start,
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              children: [
                                                Container(
                                                  alignment: Alignment.topLeft,
                                                  child: Container(
                                                    width: ScreenUtil()
                                                        .setWidth(32),
                                                    height: ScreenUtil()
                                                        .setHeight(32),
                                                    decoration:
                                                        const BoxDecoration(
                                                      color: Colors.white,
                                                      shape: BoxShape.circle,
                                                    ),
                                                    alignment: Alignment.center,
                                                    child: widgetText(
                                                      e.number.toString(),
                                                      fontSize: ScreenUtil()
                                                          .setSp(16),
                                                      fontWeight:
                                                          FontWeight.w500,
                                                      color: ColorsHelpers
                                                          .primaryColor,
                                                    ),
                                                  ),
                                                ),
                                                Expanded(
                                                  child: Padding(
                                                    padding: EdgeInsets.only(
                                                      left: ScreenUtil()
                                                          .setWidth(16),
                                                      right: ScreenUtil()
                                                          .setWidth(8),
                                                    ),
                                                    child: Column(
                                                      children: [
                                                        widgetText(
                                                          e.title.toString(),
                                                          fontSize: ScreenUtil()
                                                              .setSp(14),
                                                          fontWeight:
                                                              FontWeight.w500,
                                                          color: Colors.black,
                                                        ),
                                                        Container(
                                                          margin: EdgeInsets.only(
                                                              top: ScreenUtil()
                                                                  .setHeight(
                                                                      8)),
                                                          alignment:
                                                              Alignment.topLeft,
                                                          child: widgetText(
                                                            e.type.toString(),
                                                            fontSize:
                                                                ScreenUtil()
                                                                    .setSp(12),
                                                            fontWeight:
                                                                FontWeight.w400,
                                                            color: ColorsHelpers
                                                                .grey2,
                                                            align:
                                                                TextAlign.start,
                                                          ),
                                                        ),
                                                      ],
                                                    ),
                                                  ),
                                                ),
                                                SvgPicture.asset(
                                                    e.icon.toString()),
                                              ],
                                            ),
                                          ))
                                      .toList(),
                                ),
                              ),
                              Container(
                                margin: EdgeInsets.only(
                                    top: ScreenUtil().setHeight(16)),
                                child: widgetButton(
                                  widgetText('Save',
                                      color: Colors.white,
                                      fontWeight: FontWeight.w500,
                                      fontSize: ScreenUtil().setSp(16)),
                                  height: 56.0,
                                  radius: 20.0,
                                  width: MediaQuery.of(context).size.width,
                                  () {
                                    Navigator.pop(context);
                                    Navigator.pop(context);
                                    Navigator.pop(context);
                                  },
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
