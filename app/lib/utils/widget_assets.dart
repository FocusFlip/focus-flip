import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:quezzy/utils/constant.dart';

widgetText(String title,
    {Color? color,
    double? fontSize,
    FontWeight? fontWeight,
    TextOverflow? overflow,
    double? letterSpacing,
    TextAlign? align}) {
  return Text(
    title,
    style: TextStyle(
      fontFamily: "Rubik",
      color: color,
      fontSize: fontSize,
      letterSpacing: letterSpacing,
      fontWeight: fontWeight,
    ),
    overflow: overflow,
    textAlign: align,
  );
}

widgetButton(Text title, Function() onPressed,
    {color,
    height,
    width,
    margin,
    padding,
    paddingBtn,
    shape,
    radius,
    widthBorder,
    colorBorder,
    align}) {
  return Container(
    width: width,
    height: height,
    margin: margin,
    padding: padding,
    decoration: const BoxDecoration(
      borderRadius: BorderRadius.all(Radius.circular(20)),
    ),
    child: ElevatedButton(
      style: ElevatedButton.styleFrom(
          backgroundColor: color ?? ColorsHelpers.primaryColor,
          minimumSize:
              width == null || height == null ? null : Size(width, height),
          padding: paddingBtn,
          alignment: align,
          elevation: 0,
          shape: RoundedRectangleBorder(
            side: BorderSide(
              width: widthBorder ?? 0.0,
              color: colorBorder ?? Colors.transparent,
            ),
            borderRadius: BorderRadius.circular(radius),
          )),
      onPressed: onPressed,
      child: title,
    ),
  );
}

listItem(Widget leading, String title, String subTitle, Function()? onTap,
    Color? backgroundColor, Color? textColor, Color? textColorSub) {
  return Container(
    decoration: const BoxDecoration(
      boxShadow: [
        BoxShadow(
          color: Color.fromRGBO(25, 67, 109, 0.04),
          spreadRadius: 0,
          blurRadius: 16,
          offset: Offset(0, 4),
        )
      ],
    ),
    child: Card(
      elevation: 0,
      margin: EdgeInsets.zero,
      shape: RoundedRectangleBorder(
          side: BorderSide(
            color: ColorsHelpers.grey2,
          ),
          borderRadius: BorderRadius.circular(16)),
      color: backgroundColor,
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(16),
        child: Padding(
          padding: const EdgeInsets.all(8),
          child: Row(
            children: [
              SizedBox.square(dimension: 60, child: leading),
              const SizedBox(width: 16),
              Expanded(
                child: Container(
                  alignment: Alignment.centerLeft,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      widgetText(title,
                          fontWeight: FontWeight.w500,
                          fontSize: ScreenUtil().setSp(16),
                          color: textColor),
                      const SizedBox(
                        height: 6,
                      ),
                      widgetText(subTitle,
                          fontWeight: FontWeight.w400,
                          fontSize: ScreenUtil().setSp(12),
                          color: textColorSub),
                    ],
                  ),
                ),
              ),
              Icon(
                Icons.arrow_forward_ios,
                color: textColor ?? Colors.white,
                size: 24,
              ),
            ],
          ),
        ),
      ),
    ),
  );
}
