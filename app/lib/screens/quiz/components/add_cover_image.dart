import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:focus_flip/utils/constant.dart';
import 'package:focus_flip/utils/images.dart';
import 'package:focus_flip/utils/widget_assets.dart';

class AddCoverImage extends StatelessWidget {
  const AddCoverImage({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width,
      height: ScreenUtil().setHeight(200),
      margin: EdgeInsets.only(
        left: ScreenUtil().setWidth(16),
        right: ScreenUtil().setWidth(16),
        bottom: ScreenUtil().setHeight(16),
      ),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(ScreenUtil().setSp(20)),
        color: ColorsHelpers.grey5,
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          SvgPicture.asset(Images.addCoverIcon),
          Container(
            margin: EdgeInsets.only(top: ScreenUtil().setHeight(8)),
            child: widgetText('Add Cover Image',
                fontSize: 16,
                fontWeight: FontWeight.w500,
                color: ColorsHelpers.primaryColor),
          )
        ],
      ),
    );
  }
}
