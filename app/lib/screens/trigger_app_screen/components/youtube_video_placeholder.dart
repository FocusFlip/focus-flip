import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:focus_flip/utils/images.dart';
import 'package:focus_flip/utils/widget_assets.dart';

class YoutubeVideoPlaceholder extends StatelessWidget {
  const YoutubeVideoPlaceholder({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width,
      height:
          ScreenUtil().setHeight(MediaQuery.of(context).size.width / 2 - 35),
      margin: EdgeInsets.only(top: ScreenUtil().setHeight(16)),
      decoration: BoxDecoration(
        image: const DecorationImage(
          image: AssetImage(Images.background1),
          fit: BoxFit.cover,
        ),
        borderRadius: BorderRadius.circular(ScreenUtil().setSp(16)),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.end,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            alignment: Alignment.center,
            child: SvgPicture.asset(Images.playButton),
          ),
          Container(
            margin: EdgeInsets.only(
              left: ScreenUtil().setWidth(16),
              bottom: ScreenUtil().setHeight(16),
              top: ScreenUtil().setHeight(36),
            ),
            padding: EdgeInsets.all(ScreenUtil().setWidth(8)),
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(ScreenUtil().setSp(20)),
                color: const Color.fromRGBO(242, 247, 253, 0.7)),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                widgetText(
                  'Watch on',
                  color: Colors.black,
                  fontSize: ScreenUtil().setSp(12),
                  fontWeight: FontWeight.w400,
                ),
                Padding(
                  padding: EdgeInsets.symmetric(
                      horizontal: ScreenUtil().setWidth(4)),
                  child: SvgPicture.asset(Images.youtube),
                ),
                widgetText(
                  'YouTube',
                  color: Colors.black,
                  fontSize: ScreenUtil().setSp(10),
                  fontWeight: FontWeight.w500,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
