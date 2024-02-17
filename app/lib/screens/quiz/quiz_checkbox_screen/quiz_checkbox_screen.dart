import 'dart:developer';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:focus_flip/screens/quiz/components/add_cover_image.dart';
import 'package:focus_flip/screens/quiz/components/list_question_number.dart';
import 'package:focus_flip/screens/quiz/components/quiz_options.dart';
import 'package:focus_flip/screens/quiz/components/to_review_button.dart';
import 'package:focus_flip/utils/constant.dart';
import 'package:focus_flip/utils/images.dart';
import 'package:focus_flip/utils/widget_assets.dart';

class QuizCheckboxScreen extends StatefulWidget {
  const QuizCheckboxScreen({Key? key}) : super(key: key);

  @override
  QuizCheckboxScreenState createState() => QuizCheckboxScreenState();
}

class QuizCheckboxScreenState extends State<QuizCheckboxScreen> {
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
  String _selectedType = 'Checkbox';
  String _selectedTime = '10 Sec';
  int _currentQuestion = 0;
  bool _switchValue = true;
  bool isChecked = false;

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
                      alignment: Alignment.center,
                      child: TextFormField(
                        onTap: () {},
                        decoration: InputDecoration(
                          enabledBorder: OutlineInputBorder(
                            borderSide: BorderSide(
                                color: ColorsHelpers.grey5, width: 2.5),
                            borderRadius: BorderRadius.circular(20.0),
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderSide: BorderSide(
                                color: ColorsHelpers.grey5, width: 2.5),
                            borderRadius: BorderRadius.circular(20.0),
                          ),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(20.0),
                          ),
                          contentPadding: EdgeInsets.only(
                            top: ScreenUtil().setWidth(16),
                            bottom: ScreenUtil().setWidth(16),
                          ),
                          prefixIconConstraints:
                              const BoxConstraints(maxWidth: 52, maxHeight: 24),
                          prefixIcon: Padding(
                            padding: EdgeInsets.only(
                              left: ScreenUtil().setWidth(16),
                              right: ScreenUtil().setWidth(11),
                            ),
                            child: Container(
                              alignment: Alignment.center,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(6),
                                color: ColorsHelpers.grey5,
                              ),
                              child: Transform.scale(
                                scale: 1.5,
                                child: Checkbox(
                                  fillColor: MaterialStateProperty.resolveWith(
                                      (states) => ColorsHelpers.primaryColor),
                                  value: false,
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(6),
                                  ),
                                  side: BorderSide(
                                    color: ColorsHelpers.primaryColor,
                                    width: ScreenUtil().setSp(1.3),
                                  ),
                                  onChanged: (bool? value) {
                                    setState(() {
                                      isChecked = value!;
                                    });
                                  },
                                ),
                              ),
                            ),
                          ),
                          hintText: 'Add answer',
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
                          bottom: ScreenUtil().setWidth(16),
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
                        margin: EdgeInsets.only(
                          left: ScreenUtil().setWidth(16),
                          right: ScreenUtil().setWidth(16),
                          bottom: ScreenUtil().setWidth(16),
                        ),
                        child: TextFormField(
                          readOnly: true,
                          onTap: () => _showMyDialog(),
                          decoration: InputDecoration(
                            enabledBorder: OutlineInputBorder(
                              borderSide: BorderSide(
                                  color: ColorsHelpers.grey5, width: 2.5),
                              borderRadius: BorderRadius.circular(20.0),
                            ),
                            focusedBorder: OutlineInputBorder(
                              borderSide: BorderSide(
                                  color: ColorsHelpers.grey5, width: 2.5),
                              borderRadius: BorderRadius.circular(20.0),
                            ),
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(20.0),
                            ),
                            contentPadding: EdgeInsets.only(
                              top: ScreenUtil().setWidth(16),
                              bottom: ScreenUtil().setWidth(16),
                            ),
                            prefixIconConstraints: const BoxConstraints(
                                maxWidth: 52, maxHeight: 24),
                            prefixIcon: Padding(
                              padding: EdgeInsets.only(
                                left: ScreenUtil().setWidth(16),
                                right: ScreenUtil().setWidth(12),
                              ),
                              child: Container(
                                alignment: Alignment.center,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(6),
                                  color: ColorsHelpers.grey5,
                                ),
                                child: Transform.scale(
                                  scale: 1.5,
                                  child: Checkbox(
                                    fillColor:
                                        MaterialStateProperty.resolveWith(
                                            (states) =>
                                                ColorsHelpers.primaryColor),
                                    value: true,
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(6),
                                    ),
                                    side: BorderSide(
                                      color: ColorsHelpers.primaryColor,
                                      width: ScreenUtil().setSp(1.3),
                                    ),
                                    onChanged: (bool? value) {
                                      setState(() {
                                        isChecked = value!;
                                      });
                                    },
                                  ),
                                ),
                              ),
                            ),
                            hintText: 'Add answer',
                            hintStyle: TextStyle(
                                fontWeight: FontWeight.w400,
                                fontSize: ScreenUtil().setSp(16),
                                color: ColorsHelpers.grey2),
                          ),
                        ),
                      ),
                      Container(
                        width: MediaQuery.of(context).size.width,
                        alignment: Alignment.center,
                        margin: EdgeInsets.only(
                          left: ScreenUtil().setWidth(16),
                          right: ScreenUtil().setWidth(16),
                          bottom: ScreenUtil().setWidth(16),
                        ),
                        child: TextFormField(
                          readOnly: true,
                          onTap: () {},
                          decoration: InputDecoration(
                            enabledBorder: OutlineInputBorder(
                              borderSide: BorderSide(
                                  color: ColorsHelpers.grey5, width: 2.5),
                              borderRadius: BorderRadius.circular(20.0),
                            ),
                            focusedBorder: OutlineInputBorder(
                              borderSide: BorderSide(
                                  color: ColorsHelpers.grey5, width: 2.5),
                              borderRadius: BorderRadius.circular(20.0),
                            ),
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(20.0),
                            ),
                            contentPadding: EdgeInsets.only(
                              top: ScreenUtil().setWidth(16),
                              bottom: ScreenUtil().setWidth(16),
                            ),
                            prefixIconConstraints: const BoxConstraints(
                                maxWidth: 52, maxHeight: 24),
                            prefixIcon: Padding(
                              padding: EdgeInsets.only(
                                left: ScreenUtil().setWidth(16),
                                right: ScreenUtil().setWidth(12),
                              ),
                              child: Container(
                                alignment: Alignment.center,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(6),
                                  color: ColorsHelpers.grey5,
                                ),
                                child: Transform.scale(
                                  scale: 1.5,
                                  child: Checkbox(
                                    fillColor:
                                        MaterialStateProperty.resolveWith(
                                            (states) =>
                                                ColorsHelpers.primaryColor),
                                    value: false,
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(6),
                                    ),
                                    side: BorderSide(
                                      color: ColorsHelpers.primaryColor,
                                      width: ScreenUtil().setSp(1.3),
                                    ),
                                    onChanged: (bool? value) {
                                      setState(() {
                                        isChecked = value!;
                                      });
                                    },
                                  ),
                                ),
                              ),
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
