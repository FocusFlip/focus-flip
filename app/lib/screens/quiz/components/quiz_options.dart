import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:quezzy/screens/quiz/quiz_checkbox_screen/quiz_checkbox_screen.dart';
import 'package:quezzy/screens/quiz/quiz_multiple_choice_screen/quiz_multiple_choice_screen.dart';
import 'package:quezzy/screens/quiz/quiz_poll_screen/quiz_poll_screen.dart';
import 'package:quezzy/screens/quiz/quiz_puzzle_screen/quiz_puzzle_screen.dart';
import 'package:quezzy/screens/quiz/quiz_true_or_false_screen/quiz_true_or_false_screen.dart';
import 'package:quezzy/screens/quiz/quiz_type_answer_screen/quiz_type_answer_screen.dart';
import 'package:quezzy/screens/quiz/quiz_voice_note_screen/quiz_voice_note_screen.dart';
import 'package:quezzy/utils/constant.dart';
import 'package:quezzy/utils/images.dart';
import 'package:quezzy/utils/widget_assets.dart';

class QuizOptions extends StatelessWidget {
  final Function(String) changeSelectedTime;
  final List<String> clockList;
  final List<String> typeList;
  final String selectedTime;
  final String selectedType;
  final BuildContext context;

  const QuizOptions(this.changeSelectedTime, this.clockList, this.typeList,
      this.selectedTime, this.selectedType, this.context,
      {super.key});

  void changeSelectedType(String data) {
    var indexType = typeList.indexOf(data);
    if (indexType == 0) {
      Navigator.push(
          context,
          MaterialPageRoute(
            builder: ((context) => const QuizMultipleChoiceScreen()),
          ));
    } else if (indexType == 1) {
      Navigator.push(
          context,
          MaterialPageRoute(
            builder: ((context) => const QuizMultipleTrueOrFalseScreen()),
          ));
    } else if (indexType == 2) {
      Navigator.push(
          context,
          MaterialPageRoute(
            builder: ((context) => const QuizTypeAnswerScreen()),
          ));
    } else if (indexType == 3) {
      Navigator.push(
          context,
          MaterialPageRoute(
            builder: ((context) => const QuizVoiceNoteScreen()),
          ));
    } else if (indexType == 4) {
      Navigator.push(
          context,
          MaterialPageRoute(
            builder: ((context) => const QuizCheckboxScreen()),
          ));
    } else if (indexType == 5) {
      Navigator.push(
          context,
          MaterialPageRoute(
            builder: ((context) => const QuizPollScreen()),
          ));
    } else if (indexType == 6) {
      Navigator.push(
          context,
          MaterialPageRoute(
            builder: ((context) => const QuizPuzzleScreen()),
          ));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(
        left: ScreenUtil().setWidth(16),
        right: ScreenUtil().setWidth(16),
        bottom: ScreenUtil().setHeight(16),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          DropdownButtonHideUnderline(
            child: DropdownButton2(
              scrollbarAlwaysShow: true,
              dropdownMaxHeight: 100,
              icon: const Visibility(
                visible: false,
                child: Icon(Icons.arrow_back_ios_new),
              ),
              hint: Row(children: [
                SvgPicture.asset(
                  Images.clockIcon,
                  width: ScreenUtil().setWidth(16),
                  height: ScreenUtil().setHeight(16),
                ),
                Padding(
                  padding: EdgeInsets.only(
                    left: ScreenUtil().setWidth(4),
                  ),
                  child: widgetText(
                    '10 Sec',
                    fontSize: ScreenUtil().setSp(12),
                    fontWeight: FontWeight.w500,
                    color: Colors.black,
                  ),
                )
              ]),
              items: clockList
                  .map((e) => DropdownMenuItem(
                        value: e,
                        child: Row(children: [
                          SvgPicture.asset(
                            Images.clockIcon,
                            width: ScreenUtil().setWidth(16),
                            height: ScreenUtil().setHeight(16),
                          ),
                          Padding(
                            padding: EdgeInsets.only(
                              left: ScreenUtil().setWidth(4),
                            ),
                            child: widgetText(
                              e,
                              fontSize: ScreenUtil().setSp(12),
                              fontWeight: FontWeight.w500,
                              color: Colors.black,
                            ),
                          )
                        ]),
                      ))
                  .toList(),
              value: selectedTime,
              onChanged: (value) => changeSelectedTime(value.toString()),
              buttonDecoration: BoxDecoration(
                border: Border.all(color: ColorsHelpers.grey5),
                borderRadius: BorderRadius.circular(ScreenUtil().setSp(12)),
              ),
              buttonHeight: ScreenUtil().setHeight(34),
            ),
          ),
          DropdownButtonHideUnderline(
            child: DropdownButton2(
              dropdownMaxHeight: 100,
              scrollbarAlwaysShow: true,
              icon: Padding(
                padding: EdgeInsets.only(right: ScreenUtil().setWidth(12)),
                child: Visibility(
                  visible: true,
                  child: SvgPicture.asset(
                    Images.arrowBottom,
                    width: ScreenUtil().setSp(16),
                    height: ScreenUtil().setSp(16),
                  ),
                ),
              ),
              hint: widgetText('Multiple Answer',
                  fontSize: ScreenUtil().setSp(12),
                  fontWeight: FontWeight.w500,
                  color: Colors.black),
              items: typeList
                  .map(
                    (e) => DropdownMenuItem(
                      value: e,
                      child: widgetText(
                        e,
                        fontSize: ScreenUtil().setSp(12),
                        fontWeight: FontWeight.w500,
                        color: Colors.black,
                      ),
                    ),
                  )
                  .toList(),
              value: selectedType,
              onChanged: (value) => changeSelectedType(value.toString()),
              buttonDecoration: BoxDecoration(
                border: Border.all(color: ColorsHelpers.grey5),
                borderRadius: BorderRadius.circular(ScreenUtil().setSp(12)),
              ),
              buttonHeight: ScreenUtil().setHeight(34),
            ),
          )
        ],
      ),
    );
  }
}
