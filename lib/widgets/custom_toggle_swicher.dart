import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:towservice/utils/utils.dart';
import 'package:towservice/widgets/custom_text.dart';

class CustomToggleSwitch extends StatefulWidget {
  final bool isOnline;
  final ValueChanged<bool> onChanged;

  const CustomToggleSwitch({
    Key? key,
    required this.isOnline,
    required this.onChanged,
  }) : super(key: key);

  @override
  _CustomToggleSwitchState createState() => _CustomToggleSwitchState();
}

class _CustomToggleSwitchState extends State<CustomToggleSwitch> {
  late bool currentStatus;

  @override
  void initState() {
    super.initState();
    currentStatus = widget.isOnline;
  }

  void toggle() {
    setState(() {
      currentStatus = !currentStatus;
    });
    widget.onChanged(currentStatus);
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: toggle,
      child: Container(
        width: 90.w,
        height: 32.h,
        padding: EdgeInsets.symmetric(horizontal: 3.w),
        decoration: BoxDecoration(
          color: currentStatus ? Color(0xff5d9e9e) : Colors.grey.shade800,
          borderRadius: BorderRadius.circular(32.r),
        ),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            if (!currentStatus)
              Container(
                width: 28.w,
                height: 28.h,
                decoration: BoxDecoration(
                  color: Color(0xffCDE1E1),
                  shape: BoxShape.circle,
                ),
                child: Icon(
                  Icons.location_on,
                  color: Colors.black87,
                  size: 20,
                ),
              ),
            CustomText(
              text: currentStatus ? 'Online' : 'Offline',
              left: currentStatus ? 10.w : 0,
              right: currentStatus ? 0 : 10.w,
              fontSize: 12.h,
              color: Colors.white,
            ),


            if (currentStatus)
              Container(
                width: 28.w,
                height: 28.h,
                decoration: BoxDecoration(
                  color: Colors.green.shade100,
                  shape: BoxShape.circle,
                ),
                child: Icon(
                  Icons.location_on,
                  color: Color(0xff5d9e9e) ,
                  size: 20.h,
                ),
              ),
          ],
        ),
      ),
    );
  }
}
