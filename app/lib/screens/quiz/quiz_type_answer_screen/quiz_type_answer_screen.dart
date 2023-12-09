import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:quezzy/screens/quiz/components/add_cover_image.dart';
import 'package:quezzy/screens/quiz/components/list_question_number.dart';
import 'package:quezzy/screens/quiz/components/quiz_options.dart';
import 'package:quezzy/screens/quiz/components/to_review_button.dart';
import 'package:quezzy/utils/constant.dart';
import 'package:quezzy/utils/images.dart';
import 'package:quezzy/utils/widget_assets.dart';

class QuizTypeAnswerScreen extends StatefulWidget {
  const QuizTypeAnswerScreen({Key? key}) : super(key: key);

  @override
  QuizTypeAnswerScreenState createState() => QuizTypeAnswerScreenState();
}

class QuizTypeAnswerScreenState extends State<QuizTypeAnswerScreen> {
  final _questions = [1, 2, 3, 4, 5, 6, 7, 8, 9];
  final List<String> _clockList = [
    '10 Sec',
    '15 Sec',
    '30 Sec',
    '1 Min',
  ];
  final List<String> _typeList = [
    'Multiple Answer',
    'True or False',
    'Type Answer',
    'Voice Note',
    'Checkbox',
    'Poll',
    'Puzzle',
  ];
  String _selectedType = 'Type Answer';
  String _selectedTime = '10 Sec';
  int _currentQuestion = 0;

  void changeCurrentQuestion(int data) {
    setState(() {
      _currentQuestion = data;
    });
  }

  void changeSelectedTime(String data) {
    setState(() {
      _selectedTime = data;
    });
  }

  void changeSelectedType(String data) {
    setState(() {
      _selectedType = data;
    });
  }

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
            padding: EdgeInsets.only(left: ScreenUtil().setWidth(24.0)),
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
      body: Container(
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height,
        padding: EdgeInsets.only(
          top: ScreenUtil().setWidth(16),
          bottom: ScreenUtil().setWidth(8),
          left: ScreenUtil().setWidth(8),
          right: ScreenUtil().setWidth(8),
        ),
        color: ColorsHelpers.primaryColor,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          mainAxisSize: MainAxisSize.max,
          children: [
            Expanded(
              child: SingleChildScrollView(
                scrollDirection: Axis.vertical,
                child: Container(
                  // padding: EdgeInsets.all(ScreenUtil().setSp(16)),
                  padding: EdgeInsets.only(
                    top: ScreenUtil().setHeight(16),
                    bottom: ScreenUtil().setHeight(16),
                  ),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(ScreenUtil().setSp(32)),
                    color: Colors.white,
                  ),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Container(
                        width: MediaQuery.of(context).size.width,
                        alignment: Alignment.center,
                        margin: EdgeInsets.only(
                          left: ScreenUtil().setWidth(16),
                          right: ScreenUtil().setWidth(16),
                          bottom: ScreenUtil().setHeight(16),
                        ),
                        padding:
                            EdgeInsets.only(bottom: ScreenUtil().setHeight(0)),
                        child: SingleChildScrollView(
                          scrollDirection: Axis.horizontal,
                          child: Row(
                            children: _questions.map((e) {
                              var index = _questions.indexOf(e);
                              return ListQuestionNumber(
                                  changeCurrentQuestion,
                                  _currentQuestion,
                                  index,
                                  e,
                                  _questions.length - 1);
                            }).toList(),
                          ),
                        ),
                      ),
                      const AddCoverImage(),
                      QuizOptions(changeSelectedTime, _clockList, _typeList,
                          _selectedTime, _selectedType, context),
                      Container(
                        width: MediaQuery.of(context).size.width,
                        alignment: Alignment.topLeft,
                        margin: EdgeInsets.only(
                          left: ScreenUtil().setWidth(16),
                          right: ScreenUtil().setWidth(16),
                          top: ScreenUtil().setHeight(8),
                        ),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            Container(
                              margin: EdgeInsets.only(
                                  bottom: ScreenUtil().setHeight(8)),
                              alignment: Alignment.topLeft,
                              child: widgetText(
                                'Add Question',
                                fontWeight: FontWeight.w500,
                                fontSize: ScreenUtil().setSp(16),
                                color: Colors.black,
                                align: TextAlign.start,
                              ),
                            ),
                            Container(
                              width: MediaQuery.of(context).size.width,
                              alignment: Alignment.center,
                              child: TextFormField(
                                onTap: () {},
                                decoration: InputDecoration(
                                  enabledBorder: OutlineInputBorder(
                                      borderSide: BorderSide(
                                          color: ColorsHelpers.grey5,
                                          width: 2.5),
                                      borderRadius:
                                          BorderRadius.circular(20.0)),
                                  fillColor: Colors.white,
                                  filled: true,
                                  border: OutlineInputBorder(
                                      borderRadius:
                                          BorderRadius.circular(20.0)),
                                  contentPadding: EdgeInsets.only(
                                    top: ScreenUtil().setWidth(16),
                                    bottom: ScreenUtil().setWidth(16),
                                    left: ScreenUtil().setWidth(24),
                                    right: ScreenUtil().setWidth(24),
                                  ),
                                  hintText: 'Enter your question',
                                  hintStyle: TextStyle(
                                      fontWeight: FontWeight.w400,
                                      fontSize: ScreenUtil().setSp(16),
                                      color: ColorsHelpers.grey2),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                      Container(
                        width: MediaQuery.of(context).size.width,
                        alignment: Alignment.center,
                        margin: EdgeInsets.all(ScreenUtil().setWidth(16)),
                        child: TextFormField(
                          onTap: () {},
                          keyboardType: TextInputType.multiline,
                          maxLines: null,
                          minLines: 5,
                          decoration: InputDecoration(
                            enabledBorder: OutlineInputBorder(
                                borderSide: BorderSide(
                                    color: ColorsHelpers.grey5, width: 2.5),
                                borderRadius: BorderRadius.circular(20.0)),
                            fillColor: Colors.white,
                            filled: true,
                            border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(20.0)),
                            contentPadding: EdgeInsets.only(
                              top: ScreenUtil().setWidth(16),
                              bottom: ScreenUtil().setWidth(16),
                              left: ScreenUtil().setWidth(24),
                              right: ScreenUtil().setWidth(24),
                            ),
                            hintText: 'Add answer',
                            hintStyle: TextStyle(
                                fontWeight: FontWeight.w400,
                                fontSize: ScreenUtil().setSp(16),
                                color: ColorsHelpers.grey2),
                          ),
                        ),
                      ),
                      const ToReviewButton(),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
