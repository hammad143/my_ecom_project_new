import 'package:e_com/util/constants/color_const.dart';
import 'package:e_com/util/constants/main_const.dart';
import 'package:e_com/view/responsive_setup/device_size_config.dart';
import 'package:e_com/view/responsive_setup/device_size_info.dart';
import 'package:e_com/view/responsive_setup/local_widget_builder.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:dio/dio.dart' as http;

class ConnectionStateWidget extends StatefulWidget {
  final Widget child;

  ConnectionStateWidget({Key key, this.child}) : super(key: key);

  @override
  _ConnectionStateWidgetState createState() => _ConnectionStateWidgetState();
}

class _ConnectionStateWidgetState extends State<ConnectionStateWidget> {
  int count = 0;
  bool isConnectionMsgClosed = true, showBottomMsg = true;

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    print("Dispose");
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    postDialogCallBack();

    return Stack(
      fit: StackFit.expand,
      children: [
        widget.child,
        if (!isConnectionMsgClosed && showBottomMsg)
          Positioned(
            bottom: 0,
            left: 0,
            right: 0,
            child: Align(
              child: Container(
                  color: const Color(0xff404040),
                  padding: const EdgeInsets.symmetric(
                      horizontal: kDefaultPadding, vertical: 2),
                  child: Row(
                    children: [
                      CircularProgressIndicator(),
                      const SizedBox(width: 20),
                      Text(
                        "Please Check your connection",
                        style: TextStyle(
                          fontSize: kNormalFontSize,
                          color: Colors.white,
                        ),
                      ),
                      Expanded(
                        child: Align(
                          alignment: Alignment.centerRight,
                          child: Material(
                            type: MaterialType.transparency,
                            shape: CircleBorder(),
                            clipBehavior: Clip.antiAlias,
                            child: IconButton(
                              color: const Color(0xffed7272),
                              onPressed: () {
                                print("pressed");
                                setState(() {
                                  showBottomMsg = false;
                                });
                              },
                              icon: Icon(Icons.close),
                            ),
                          ),
                        ),
                      ),
                    ],
                  )),
            ),
          ),
      ],
    );
  }

  postDialogCallBack() {
    if (Navigator.canPop(context)) {
      Navigator.pop(context);
    }

    WidgetsBinding.instance.addPostFrameCallback((time) {
      if (isConnectionMsgClosed) showAlert();
    });
  }

  showAlert() async {
    final _style1 = TextStyle(
      color: Colors.white,
      fontWeight: FontWeight.w700,
      fontSize: kNormalFontSize,
    );
    //final timeLimit = Duration(seconds: 10);
    /* http.Response res =
        await http.Dio().get("http://www.google.com").timeout(timeLimit); */
    //if (res.statusCode != 200)
    showDialog(
        context: context,
        builder: (ctx) {
          return Dialog(
              backgroundColor: transparent,
              insetPadding: EdgeInsets.all(0),
              child: Container(
                height: DeviceSizeConfig.widgetScaleFactor * 80,
                child: LocalWidgetBuilder(builder: (ctx, constraints, factor) {
                  return Column(
                    children: [
                      ConnectionImageWithCloseBtnComp(
                          constraints: constraints, onClose: _onCloseBtn),
                      ConnectionFailedTextComp(
                          style1: _style1, constraints: constraints),
                    ],
                  );
                }),
              ));
        });
  }

  _onCloseBtn() {
    isConnectionMsgClosed = false;
    Navigator.pop(context);
  }
}

class ConnectionImageWithCloseBtnComp extends StatelessWidget {
  const ConnectionImageWithCloseBtnComp({
    Key key,
    this.constraints,
    this.onClose,
  }) : super(key: key);
  final BoxConstraints constraints;
  final VoidCallback onClose;
  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Container(
          width: constraints.maxWidth / 2,
          height: DeviceSizeConfig.widgetScaleFactor * 40,
          child: Image.asset(
            "assets/images/no_internet.gif",
            fit: BoxFit.cover,
          ),
        ),
        Positioned(
          top: 0,
          right: 0,
          child: IconButton(
            onPressed: onClose,
            icon: Icon(
              Icons.close,
              color: Colors.white,
            ),
          ),
        ),
      ],
    );
  }
}

class ConnectionFailedTextComp extends StatelessWidget {
  const ConnectionFailedTextComp({
    Key key,
    @required TextStyle style1,
    this.constraints,
  })  : _style1 = style1,
        super(key: key);

  final TextStyle _style1;
  final BoxConstraints constraints;
  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 20, vertical: 20),
        width: constraints.maxWidth / 2,
        color: kPrimaryColor,
        child: Column(
          children: [
            Text("Oops, No Internet", style: _style1),
            SizedBox(height: 10),
            Text("You are not connected to\n the internet",
                textAlign: TextAlign.center,
                style: TextStyle(
                    color: Colors.white70,
                    fontSize: DeviceSizeConfig.textScaleFactor * 3)),
            SizedBox(height: 10),
            Text("Please check your connection.",
                style: _style1.copyWith(
                    fontSize: DeviceSizeConfig.textScaleFactor * 2.8,
                    fontWeight: FontWeight.w600)),
            SizedBox(height: 10),
            Text(
              "Make sure your WiFi or Mobile data is turned on",
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ),
    );
  }
}
