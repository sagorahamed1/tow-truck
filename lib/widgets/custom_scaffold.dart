import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class CustomScaffold extends StatelessWidget {
  const CustomScaffold(
      {super.key,
      this.appBar,
      this.body,
      this.floatingActionButton,
      this.bottomNavigationBar,
      this.paddingSide, this.resizeToAvoidBottomInset, this.bottomSheet});

  final PreferredSizeWidget? appBar;
  final Widget? body;
  final Widget? floatingActionButton;
  final Widget? bottomNavigationBar;
  final Widget? bottomSheet;
  final double? paddingSide;
  final bool? resizeToAvoidBottomInset;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Color(0xffFFFFFF),
        appBar: appBar,
        body: Padding(
              padding: EdgeInsets.only(left: paddingSide ?? 16.w,right: paddingSide ?? 16.w),
              child: body,
            ),
       // floatingActionButton: floatingActionButton,
       bottomSheet: bottomSheet,
       // bottomNavigationBar: bottomNavigationBar,
       //  resizeToAvoidBottomInset: resizeToAvoidBottomInset
    );
  }
}
