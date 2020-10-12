import 'package:e_com/view/responsive_setup/device_size_info.dart';
import 'package:flutter/cupertino.dart';

class DeviceSizeConfig extends DeviceSizeInfo {
  static double deviceBlockWidth,
      deviceBlockHeight,
      widgetScaleFactor,
      textScaleFactor;
  static DeviceSizeInfo deviceSizeInfo;
  static DeviceSizeConfig _sizeConfig;

  DeviceSizeConfig._(BuildContext ctx) {
    final query = MediaQuery.of(ctx);
    deviceSizeInfo = this;
    deviceHeight = query.size.height;
    deviceWidth = query.size.width;
    this.orientation = query.orientation;
    deviceBlockHeight = deviceHeight / 100;
    deviceBlockWidth = deviceWidth / 100;
    widgetScaleFactor = this.orientation == Orientation.landscape
        ? deviceBlockHeight
        : deviceBlockWidth;
    textScaleFactor = widgetScaleFactor;
  }

  factory DeviceSizeConfig() => _sizeConfig;

  static initilize(BuildContext ctx) => _sizeConfig = DeviceSizeConfig._(ctx);
}

extension Responsiveness on BuildContext {
  DeviceSizeConfig get deviceSize => DeviceSizeConfig.initilize(this);
}
