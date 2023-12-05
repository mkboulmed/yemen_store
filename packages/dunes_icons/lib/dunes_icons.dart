import 'package:dunes_icons/icons.dart';
import 'package:flutter/material.dart';

class DunesIcon extends StatelessWidget {
  final String iconString;
  final Color? color;
  final double? size;
  const DunesIcon({Key? key, required this.iconString, this.color, this.size})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    if (iconString.isNotEmpty) {
      try {
        return Icon(
            baoIconList
                .firstWhere((element) => element.label == iconString)
                .icon,
            color: color, size: size);
      } catch (e) {
        return Container(width: 0);
      }
    } else {
      return Container(width: 0);
    }
  }
}
