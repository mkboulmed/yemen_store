import 'package:app/src/models/app_state_model.dart';
import 'package:app/src/ui/intro/intro_slider1.dart';
import 'package:app/src/ui/intro/intro_slider3.dart';
import 'package:app/src/ui/intro/intro_slider4.dart';
import 'package:flutter/material.dart';
import 'intro_slider2.dart';

class IntroScreen extends StatefulWidget {
  final Function onFinish;
  final AppStateModel model;
  const IntroScreen({Key? key, required this.onFinish, required this.model}) : super(key: key);
  @override
  _IntroScreenState createState() => _IntroScreenState();
}

class _IntroScreenState extends State<IntroScreen> {
  @override
  Widget build(BuildContext context) {
    if (widget.model.blocks.settings.pageLayout.introScreen == 'layout1') {
      return IntroScreen1(onFinish: widget.onFinish);
    } else if (widget.model.blocks.settings.pageLayout.introScreen == 'layout2') {
      return IntroScreen2(onFinish: widget.onFinish);
    } else if (widget.model.blocks.settings.pageLayout.introScreen == 'layout3') {
      return IntroScreen3(onFinish: widget.onFinish);
    } else if (widget.model.blocks.settings.pageLayout.introScreen == 'layout4') {
      return IntroScreen4(onFinish: widget.onFinish);
    } else {
      return IntroScreen1(onFinish: widget.onFinish);
    }
  }
}
