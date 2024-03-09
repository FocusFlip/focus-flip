import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:focus_flip/utils/widget_assets.dart';

class TutorialItem extends StatelessWidget {
  final String title;
  final String imagePath;

  const TutorialItem({super.key, required this.title, required this.imagePath});

  @override
  Widget build(BuildContext context) {
    return Wrap(
      children: [
        Container(
          alignment: Alignment.topLeft,
          margin: EdgeInsets.only(top: ScreenUtil().setHeight(24)),
          child: widgetText(
            title,
            color: Colors.black,
            fontSize: ScreenUtil().setSp(17),
            fontWeight: FontWeight.w500,
          ),
        ),
        // TODO: add screenshot
        Container(
            margin: EdgeInsets.only(top: ScreenUtil().setHeight(16)),
            decoration: BoxDecoration(borderRadius: BorderRadius.circular(16)),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(16),
              child: Image.asset(
                imagePath,
              ),
            ))
      ],
    );
  }
}
