import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:focus_flip/screens/quiz/components/to_review_button.dart';
import 'package:focus_flip/utils/constant.dart';
import 'package:focus_flip/utils/images.dart';
import 'package:focus_flip/utils/widget_assets.dart';

class QuizChooseCategoryScreen extends StatefulWidget {
  const QuizChooseCategoryScreen({Key? key}) : super(key: key);

  @override
  QuizChooseCategoryState createState() => QuizChooseCategoryState();
}

class QuizChooseCategoryState extends State<QuizChooseCategoryScreen> {
  int _current = 0;
  final _categories = [
    {'title': 'Math', 'quiz_count': 21, 'icon': Images.mathIcon},
    {'title': 'Sports', 'quiz_count': 18, 'icon': Images.sportIcon},
    {'title': 'Music', 'quiz_count': 15, 'icon': Images.musicIcon},
    {'title': 'Science', 'quiz_count': 12, 'icon': Images.scienceIcon},
    {'title': 'Art', 'quiz_count': 18, 'icon': Images.artIcon},
    {'title': 'Travel', 'quiz_count': 14, 'icon': Images.travelIcon},
    {'title': 'History', 'quiz_count': 7, 'icon': Images.historyIcon},
    {'title': 'Tech', 'quiz_count': 8, 'icon': Images.techIcon},
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: ColorsHelpers.primaryColor,
        elevation: 0,
        title: widgetText(
          'Choose Category',
          color: Colors.white,
          fontWeight: FontWeight.w500,
          fontSize: ScreenUtil().setSp(24),
        ),
        leading: Padding(
          padding: EdgeInsets.only(left: ScreenUtil().setWidth(24.0)),
          child: ConstrainedBox(
            constraints: BoxConstraints(maxWidth: ScreenUtil().setWidth(24)),
            child: const BackButton(
              color: Colors.white,
            ),
          ),
        ),
      ),
      body: Container(
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height,
        padding: EdgeInsets.only(
          top: ScreenUtil().setHeight(16),
          bottom: ScreenUtil().setHeight(8),
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
                  padding: EdgeInsets.only(
                    top: ScreenUtil().setHeight(8),
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
                        alignment: Alignment.center,
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Wrap(
                              children: _categories.map(
                                (e) {
                                  var index = _categories.indexOf(e);
                                  return GestureDetector(
                                      onTap: () {
                                        setState(() {
                                          _current = index;
                                        });
                                      },
                                      child: Container(
                                        decoration: BoxDecoration(
                                            color: _current == index
                                                ? ColorsHelpers.pink
                                                : ColorsHelpers.grey5,
                                            borderRadius: BorderRadius.circular(
                                                ScreenUtil().setSp(20))),
                                        alignment: Alignment.center,
                                        width: ((MediaQuery.of(context)
                                                    .size
                                                    .width /
                                                2) -
                                            ScreenUtil().setWidth(32)),
                                        margin: EdgeInsets.all(
                                            ScreenUtil().setWidth(8)),
                                        child: Padding(
                                          padding: EdgeInsets.only(
                                            top: ScreenUtil().setHeight(16),
                                            bottom: ScreenUtil().setHeight(16),
                                          ),
                                          child: Column(
                                            children: [
                                              ConstrainedBox(
                                                constraints: BoxConstraints(
                                                  maxWidth:
                                                      ScreenUtil().setWidth(48),
                                                  maxHeight:
                                                      ScreenUtil().setWidth(48),
                                                ),
                                                child: Container(
                                                  width: MediaQuery.of(context)
                                                      .size
                                                      .width,
                                                  height: MediaQuery.of(context)
                                                      .size
                                                      .height,
                                                  padding: EdgeInsets.all(
                                                      ScreenUtil().setWidth(9)),
                                                  decoration: BoxDecoration(
                                                      color: _current == index
                                                          ? ColorsHelpers
                                                              .whiteOpacity0_2
                                                          : Colors.white,
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              ScreenUtil()
                                                                  .setSp(16))),
                                                  child: SvgPicture.asset(
                                                    e['icon'].toString(),
                                                    color: _current == index
                                                        ? Colors.white
                                                        : ColorsHelpers
                                                            .primaryColor,
                                                  ),
                                                ),
                                              ),
                                              Padding(
                                                padding: EdgeInsets.only(
                                                    top: ScreenUtil()
                                                        .setHeight(8),
                                                    bottom: ScreenUtil()
                                                        .setHeight(2)),
                                                child: widgetText(
                                                  e['title'].toString(),
                                                  color: _current == index
                                                      ? Colors.white
                                                      : ColorsHelpers
                                                          .primaryColor,
                                                  fontSize:
                                                      ScreenUtil().setSp(16),
                                                  fontWeight: FontWeight.w500,
                                                ),
                                              ),
                                              widgetText(
                                                '${e['quiz_count']} Quizzies',
                                                color: _current == index
                                                    ? Colors.white
                                                    : ColorsHelpers
                                                        .primaryColor,
                                                fontSize:
                                                    ScreenUtil().setSp(12),
                                                fontWeight: FontWeight.w400,
                                              ),
                                            ],
                                          ),
                                        ),
                                      ));
                                },
                              ).toList(),
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
