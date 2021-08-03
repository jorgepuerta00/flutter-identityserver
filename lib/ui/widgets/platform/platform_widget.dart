import 'dart:io';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

// Source:
//  https://www.youtube.com/watch?v=0q2beiiXD98&ab_channel=CodeWithAndrea
//  https://github.com/bizz84/platform_aware_widgets_flutter/blob/master/lib/common_widgets/platform_widget.dart
/// Base class to be extended by all platform aware widgets
abstract class PlatformWidget extends StatelessWidget {
  PlatformWidget({
    Key? key,
  }) : super(key: key);

  Widget buildCupertinoWidget(BuildContext context);
  Widget buildMaterialWidget(BuildContext context);

  @override
  Widget build(BuildContext context) {
    if (Platform.isIOS) {
      // Use Cupertino on iOS
      return buildCupertinoWidget(context);
    }
    // Use Material design on Android and other platforms
    return buildMaterialWidget(context);
  }
}
