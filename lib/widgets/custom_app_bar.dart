import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:towservice/utils/app_colors.dart';


class CustomAppBar extends StatelessWidget implements PreferredSizeWidget {
  const CustomAppBar({
    super.key,
    this.title,
    this.titleSize = 16,
    this.centerTitle = true,
    this.titleWidget,
    this.flexibleSpace,
    this.showLeading = true,
    this.showBorder = false,
    this.actions,
    this.backAction, this.leading, this.backgroundColor,
  });

  final String? title;
  final double titleSize;
  final bool centerTitle;
  final Widget? titleWidget;
  final Widget? flexibleSpace;
  final bool showLeading;
  final bool showBorder;
  final List<Widget>? actions;
  final VoidCallback? backAction;
  final Widget? leading;
  final Color? backgroundColor;

  @override
  Widget build(BuildContext context) {
    final ModalRoute<dynamic>? parentRoute = ModalRoute.of(context);

    return AppBar(
      //leadingWidth: 44.r,
      titleSpacing: 0,
      shape: showBorder
          ? Border(
        bottom: BorderSide(color: Colors.grey.withOpacity(0.4), width: 0.5),
      )
          : null,
      centerTitle: centerTitle,
      elevation: 0,
      automaticallyImplyLeading: false,
      backgroundColor: backgroundColor ?? Colors.transparent,
      foregroundColor: Colors.white,
      scrolledUnderElevation: 0,
      flexibleSpace: flexibleSpace,
      leading: leading ??
          ((showLeading && (parentRoute?.canPop ?? false))
              ? Padding(
                padding:  EdgeInsets.only(left: 16.w),
                child: GestureDetector(
                            onTap: backAction ?? () => Navigator.pop(context),
                            child: Container(
                alignment: Alignment.center,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: AppColors.whiteColor,
                  boxShadow: [
                    BoxShadow(
                      color: const Color(0xff00000040).withOpacity(0.2),
                      blurRadius: 2,
                    ),
                  ],
                ),
                child: Icon(
                  Icons.arrow_back_ios_new,
                  color: AppColors.darkColor,
                  size: 22.r,
                ),
                            ),
                          ),
              )
              : null),
      title: title != null && title!.isNotEmpty
          ? Text(
        title!,
        style: TextStyle(
          //fontFamily: FontFamily.inter,
          fontWeight: FontWeight.w500,
          fontSize: titleSize.sp,
          color: Colors.black,
        ),
      )
          : titleWidget,
      actions: actions,
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(60);
}
