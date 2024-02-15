import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:focus_flip/screens/live_quiz_screen/review_quiz_screen.dart';
import 'package:focus_flip/utils/constant.dart';
import 'package:focus_flip/utils/widget_assets.dart';

import '../../models/utils_model.dart';
import '../../utils/images.dart';

class QuizCompleteScreen extends StatefulWidget {
  const QuizCompleteScreen({super.key});

  @override
  State<QuizCompleteScreen> createState() => _QuizCompleteScreenState();
}

class _QuizCompleteScreenState extends State<QuizCompleteScreen> {
  List<String> weeksName = ["1", "2", "3", "4", "5", "6", "7", "8", "9", "10"];

  List<QuestionNumber> question = [
    QuestionNumber(x: 0, y: 3),
    QuestionNumber(x: 1, y: 3),
    QuestionNumber(x: 2, y: 2),
    QuestionNumber(x: 3, y: 4),
    QuestionNumber(x: 4, y: 5),
    QuestionNumber(x: 5, y: 3),
    QuestionNumber(x: 6, y: 3),
    QuestionNumber(x: 7, y: 5),
    QuestionNumber(x: 8, y: 4),
    QuestionNumber(x: 9, y: 1),
  ];

  Widget lineChartWeeksWidget(List<QuestionNumber> points) {
    return LineChart(
      LineChartData(
        minX: 0,
        maxX: 9,
        minY: 0,
        maxY: 7.0,
        titlesData: FlTitlesData(
          bottomTitles: SideTitles(
              showTitles: true,
              reservedSize: 1,
              margin: 10,
              getTitles: (index) {
                return weeksName[index.toInt()];
              }),
          leftTitles: SideTitles(showTitles: false),
          rightTitles: SideTitles(showTitles: false),
          topTitles: SideTitles(showTitles: false),
        ),
        borderData: FlBorderData(show: false),
        lineBarsData: [
          LineChartBarData(
            dotData: FlDotData(show: false),
            spots: points.map((e) => FlSpot(e.x!, e.y!)).toList(),
            isCurved: false,
            barWidth: 3,
            colors: [
              ColorsHelpers.primaryColor,
            ],
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        child: Container(
          height: MediaQuery.of(context).size.height * 1.2,
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
                  child: widgetText('Good Job!',
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
              width: MediaQuery.of(context).size.width,
              height: ScreenUtil().setWidth(380),
              padding: EdgeInsets.only(top: ScreenUtil().setHeight(24)),
              margin: EdgeInsets.only(top: ScreenUtil().setHeight(16)),
              decoration: BoxDecoration(
                  color: ColorsHelpers.pink,
                  borderRadius: const BorderRadius.all(Radius.circular(20))),
              child: Column(
                children: [
                  Image.asset(
                    Images.illustrationTrophy,
                    height: ScreenUtil().setHeight(158),
                    width: ScreenUtil().setWidth(214),
                  ),
                  Container(
                      margin: const EdgeInsets.only(top: 14),
                      child: widgetText(
                        'You get +80 Quiz Points',
                        fontWeight: FontWeight.w500,
                        fontSize: ScreenUtil().setSp(16),
                        color: Colors.white,
                      )),
                  widgetButton(
                      widgetText('Check Correct Answer',
                          fontWeight: FontWeight.w500,
                          fontSize: ScreenUtil().setSp(16)),
                      height: ScreenUtil().setHeight(56),
                      width: ScreenUtil().setWidth(237),
                      radius: 20.0,
                      color: Colors.white.withOpacity(0.3),
                      margin: EdgeInsets.only(
                          top: ScreenUtil().setHeight(32),
                          bottom: ScreenUtil().setHeight(32)), () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => const ReviewQuizScren()));
                  })
                ],
              ),
            ),
            Container(
              margin: EdgeInsets.only(
                  top: ScreenUtil().setHeight(24),
                  bottom: ScreenUtil().setHeight(16)),
              child: widgetText('ACCURATION ANSWER',
                  fontWeight: FontWeight.w500,
                  fontSize: ScreenUtil().setSp(12),
                  letterSpacing: 1.2,
                  color: ColorsHelpers.grey2),
            ),
            SizedBox(
                height: 100,
                width: MediaQuery.of(context).size.width,
                child: lineChartWeeksWidget(question)),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                        margin:
                            EdgeInsets.only(top: ScreenUtil().setHeight(24)),
                        child: widgetText('CORRECT ANSWER',
                            fontWeight: FontWeight.w500,
                            fontSize: ScreenUtil().setSp(12),
                            color: ColorsHelpers.grey2,
                            letterSpacing: 1.2)),
                    SizedBox(
                      height: ScreenUtil().setHeight(16),
                    ),
                    widgetText('7 questions',
                        fontWeight: FontWeight.w500,
                        fontSize: ScreenUtil().setSp(20),
                        color: Colors.black),
                    Container(
                        margin:
                            EdgeInsets.only(top: ScreenUtil().setHeight(24)),
                        child: widgetText('SKIPPED',
                            fontWeight: FontWeight.w500,
                            fontSize: ScreenUtil().setSp(12),
                            color: ColorsHelpers.grey2,
                            letterSpacing: 1.2)),
                    SizedBox(
                      height: ScreenUtil().setHeight(16),
                    ),
                    widgetText('2',
                        fontWeight: FontWeight.w500,
                        fontSize: ScreenUtil().setSp(20),
                        color: Colors.black)
                  ],
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                        margin:
                            EdgeInsets.only(top: ScreenUtil().setHeight(24)),
                        child: widgetText('COMPLETION',
                            fontWeight: FontWeight.w500,
                            fontSize: ScreenUtil().setSp(12),
                            color: ColorsHelpers.grey2,
                            letterSpacing: 1.2)),
                    SizedBox(
                      height: ScreenUtil().setHeight(16),
                    ),
                    widgetText('80%',
                        fontWeight: FontWeight.w500,
                        fontSize: ScreenUtil().setSp(20),
                        color: Colors.black),
                    Container(
                        margin:
                            EdgeInsets.only(top: ScreenUtil().setHeight(24)),
                        child: widgetText('INCORRECT ANSWER',
                            fontWeight: FontWeight.w500,
                            fontSize: ScreenUtil().setSp(12),
                            color: ColorsHelpers.grey2,
                            letterSpacing: 1.2)),
                    SizedBox(
                      height: ScreenUtil().setHeight(16),
                    ),
                    widgetText('1',
                        fontWeight: FontWeight.w500,
                        fontSize: ScreenUtil().setSp(20),
                        color: Colors.black)
                  ],
                ),
              ],
            ),
            Container(
              margin: EdgeInsets.only(top: ScreenUtil().setHeight(24)),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  widgetButton(
                      widgetText('Done',
                          fontWeight: FontWeight.w500,
                          fontSize: ScreenUtil().setSp(16)),
                      width: ScreenUtil().setWidth(245),
                      height: ScreenUtil().setHeight(56),
                      radius: 20.0, () {
                    Navigator.pop(context);
                  }),
                  SizedBox(
                    height: ScreenUtil().setHeight(56),
                    width: ScreenUtil().setWidth(56),
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                          shadowColor: Colors.transparent,
                          backgroundColor: Colors.white,
                          shape: RoundedRectangleBorder(
                            side: BorderSide(
                              width: 2,
                              color:
                                  ColorsHelpers.primaryColor.withOpacity(0.2),
                            ),
                            borderRadius: BorderRadius.circular(20.0),
                          )),
                      onPressed: () {},
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: <Widget>[
                          Expanded(
                            flex: 1,
                            child: SvgPicture.asset(
                              Images.shareIcon,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            )
          ]),
        ),
      ),
    );
  }
}
