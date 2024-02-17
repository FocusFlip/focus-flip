import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:focus_flip/screens/quiz/quiz_review_screen/quiz_review_screen.dart';
import 'package:focus_flip/utils/widget_assets.dart';

class ToReviewButton extends StatelessWidget {
  const ToReviewButton({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(
        left: ScreenUtil().setWidth(16),
        right: ScreenUtil().setWidth(16),
      ),
      child: widgetButton(
          widgetText('Add Question',
              color: Colors.white,
              fontWeight: FontWeight.w500,
              fontSize: ScreenUtil().setSp(16)),
          height: 56.0,
          radius: 20.0,
          width: MediaQuery.of(context).size.width,
          () => Navigator.push(
              context,
              MaterialPageRoute(
                builder: ((context) => const QuizReviewScreen()),
              ))),
    );
  }
}
