import 'package:e_com/util/constants/color_const.dart';
import 'package:flutter/material.dart';

class ErrorMessageContainer extends StatelessWidget {
  final String errMsg;

  ErrorMessageContainer({Key key, this.errMsg}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(left: 20, top: 5),
      child: Text(errMsg,
          style: TextStyle(color: kPrimaryColor, fontWeight: FontWeight.bold)),
    );
  }
}
