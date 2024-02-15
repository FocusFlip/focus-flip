import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:focus_flip/utils/constant.dart';
import 'package:focus_flip/utils/widget_assets.dart';

class ListQuestionNumber extends StatelessWidget {
  final Function(int) changeCurrentQuestion;
  final int currentQuestion;
  final int index;
  final int numberQuestion;
  final int totalQuestion;

  const ListQuestionNumber(this.changeCurrentQuestion, this.currentQuestion,
      this.index, this.numberQuestion, this.totalQuestion,
      {super.key});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        changeCurrentQuestion(index);
      },
      child: Container(
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          border: (index == currentQuestion)
              ? Border.all(
                  color: ColorsHelpers.pink, width: ScreenUtil().setWidth(12))
              : null,
          color: (index == currentQuestion) ? ColorsHelpers.pink : null,
        ),
        margin: EdgeInsets.only(
          left: (index != 0)
              ? (index == currentQuestion)
                  ? ScreenUtil().setWidth(4)
                  : ScreenUtil().setWidth(16)
              : 4,
          right: (index != totalQuestion)
              ? (index == currentQuestion)
                  ? ScreenUtil().setWidth(4)
                  : ScreenUtil().setWidth(16)
              : 0,
        ),
        child: widgetText(
          numberQuestion.toString(),
          color:
              (index == currentQuestion) ? Colors.white : ColorsHelpers.grey2,
          fontSize: ScreenUtil().setSp(14),
          fontWeight:
              (index == currentQuestion) ? FontWeight.w500 : FontWeight.w400,
        ),
      ),
    );
  }
}
