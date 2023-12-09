import 'dart:developer';
import 'package:flutter/cupertino.dart';
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

class QuizMultipleChoiceScreen extends StatefulWidget {
  const QuizMultipleChoiceScreen({Key? key}) : super(key: key);

  @override
  QuizMultipleChoiceScreenState createState() =>
      QuizMultipleChoiceScreenState();
}

class QuizMultipleChoiceScreenState extends State<QuizMultipleChoiceScreen> {
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
  final String _selectedType = 'Multiple Answer';
  String _selectedTime = '10 Sec';
  bool _switchValue = true;
  int _currentQuestion = 0;

  _showMyDialog() async {
    return showDialog<void>(
      context: context,
      barrierDismissible: true,
      builder: (BuildContext context) {
        return StatefulBuilder(
            builder: (BuildContext context, StateSetter setState) {
          return AlertDialog(
            elevation: 24.0,
            insetPadding: EdgeInsets.all(ScreenUtil().setWidth(8)),
            shape: const RoundedRectangleBorder(
              borderRadius: BorderRadius.all(
                Radius.circular(12.0),
              ),
            ),
            contentPadding: EdgeInsets.only(
              left: ScreenUtil().setWidth(24),
              right: ScreenUtil().setWidth(24),
              top: ScreenUtil().setHeight(24),
            ),
            actionsPadding: EdgeInsets.only(
              left: ScreenUtil().setWidth(24),
              right: ScreenUtil().setWidth(24),
              bottom: ScreenUtil().setHeight(14),
            ),
            content: SingleChildScrollView(
              child: Container(
                alignment: Alignment.topLeft,
                width: MediaQuery.of(context).size.width,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(ScreenUtil().setSp(32)),
                  color: Colors.white,
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Container(
                      margin:
                          EdgeInsets.only(bottom: ScreenUtil().setHeight(8)),
                      alignment: Alignment.topLeft,
                      child: widgetText(
                        'Add answer',
                        fontWeight: FontWeight.w500,
                        fontSize: ScreenUtil().setSp(16),
                        color: Colors.black,
                        align: TextAlign.start,
                      ),
                    ),
                    Container(
                      width: MediaQuery.of(context).size.width,
                      alignment: Alignment.topLeft,
                      child: TextFormField(
                        onTap: () {},
                        keyboardType: TextInputType.multiline,
                        maxLines: null,
                        minLines: 5,
                        decoration: InputDecoration(
                          fillColor: ColorsHelpers.grey5,
                          filled: true,
                          enabledBorder: OutlineInputBorder(
                            borderSide: BorderSide(
                                color: ColorsHelpers.grey5, width: 2.5),
                            borderRadius: BorderRadius.circular(20.0),
                          ),
                          contentPadding: EdgeInsets.only(
                            top: ScreenUtil().setWidth(16),
                            bottom: ScreenUtil().setWidth(16),
                            left: ScreenUtil().setWidth(24),
                            right: ScreenUtil().setWidth(24),
                          ),
                          hintText: 'Enter quiz description',
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
            ),
            actions: <Widget>[
              Padding(
                padding: EdgeInsets.only(
                  top: ScreenUtil().setHeight(8),
                  bottom: ScreenUtil().setHeight(8),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    widgetText(
                      'Correct answer',
                      fontWeight: FontWeight.w500,
                      fontSize: ScreenUtil().setSp(16),
                      color: Colors.black,
                      align: TextAlign.start,
                    ),
                    CupertinoSwitch(
                      value: _switchValue,
                      activeColor: ColorsHelpers.primaryColor,
                      onChanged: ((bool value) {
                        setState(() {
                          _switchValue = value;
                        });
                      }),
                    )
                  ],
                ),
              )
            ],
          );
        });
      },
    );
  }

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
                          bottom: ScreenUtil().setHeight(8),
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
                        margin: EdgeInsets.only(
                          left: ScreenUtil().setWidth(8),
                          right: ScreenUtil().setWidth(8),
                          bottom: ScreenUtil().setHeight(8),
                        ),
                        alignment: Alignment.center,
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Wrap(
                              children: [
                                for (var i = 0; i < 4; i++)
                                  GestureDetector(
                                    onTap: () {
                                      _showMyDialog();
                                    },
                                    child: Container(
                                      decoration: BoxDecoration(
                                          color: ColorsHelpers.grey5,
                                          borderRadius: BorderRadius.circular(
                                              ScreenUtil().setSp(20))),
                                      alignment: Alignment.center,
                                      width:
                                          ((MediaQuery.of(context).size.width /
                                                  2) -
                                              ScreenUtil().setWidth(34)),
                                      margin: EdgeInsets.all(
                                          ScreenUtil().setWidth(8)),
                                      child: Padding(
                                        padding: EdgeInsets.only(
                                          top: ScreenUtil().setHeight(20),
                                          bottom: ScreenUtil().setHeight(20),
                                        ),
                                        child: Column(
                                          children: [
                                            ConstrainedBox(
                                              constraints: BoxConstraints(
                                                maxWidth:
                                                    ScreenUtil().setWidth(24),
                                                maxHeight:
                                                    ScreenUtil().setWidth(24),
                                              ),
                                              child: SvgPicture.asset(
                                                Images.plusIcon,
                                              ),
                                            ),
                                            Padding(
                                              padding: EdgeInsets.only(
                                                  top:
                                                      ScreenUtil().setHeight(8),
                                                  bottom: ScreenUtil()
                                                      .setHeight(2)),
                                              child: widgetText(
                                                'Add answer',
                                                color:
                                                    ColorsHelpers.primaryColor,
                                                fontSize:
                                                    ScreenUtil().setSp(14),
                                                fontWeight: FontWeight.w500,
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ),
                                  ),
                              ],
                            )
                          ],
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
