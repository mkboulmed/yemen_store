import 'package:flex_color_scheme/src/flex_extensions.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:intro_slider/intro_slider.dart';

class IntroScreen1 extends StatefulWidget {
  final Function onFinish;
  IntroScreen1({Key? key, required this.onFinish}) : super(key: key);

  @override
  IntroScreen1State createState() => new IntroScreen1State();
}

class IntroScreen1State extends State<IntroScreen1> {
  //List<Slide> slides = [];

  @override
  void initState() {
    super.initState();
  }

  void onDonePress() {
    widget.onFinish();
  }

  ButtonStyle myButtonStyle() {
    return ButtonStyle(
      shape: MaterialStateProperty.all<OutlinedBorder>(const StadiumBorder()),
      backgroundColor:
      MaterialStateProperty.all<Color>(const Color(0x33ffcc5c)),
      overlayColor: MaterialStateProperty.all<Color>(const Color(0x33ffcc5c)),
    );
  }

  Widget renderNextBtn() {
    return const Icon(
      Icons.navigate_next,
      size: 25,
    );
  }

  Widget renderPrevBtn() {
    return const Icon(
      Icons.navigate_before,
      size: 25,
    );
  }

  Widget renderDoneBtn() {
    return const Icon(
      Icons.done,
      size: 25,
    );
  }

  Widget renderSkipBtn() {
    return const Icon(
      Icons.skip_next,
      size: 25,
    );
  }

  @override
  Widget build(BuildContext context) {

    List<ContentConfig> listContentConfig = [];
    Color activeColor = Theme.of(context).colorScheme.onPrimary;
    Color inactiveColor = Theme.of(context).colorScheme.onPrimary.withOpacity(0.5);
    double sizeIndicator = 20;

    return AnnotatedRegion<SystemUiOverlayStyle>(
      value: Theme.of(context).colorScheme.primary.isDark ? SystemUiOverlayStyle.light : SystemUiOverlayStyle.dark,
      child: new IntroSlider(
        //backgroundColorAllSlides: Theme.of(context).colorScheme.primary,
        //colorDot: Theme.of(context).colorScheme.onPrimary.withOpacity(0.5),
        //colorActiveDot: Theme.of(context).colorScheme.onPrimary,
        indicatorConfig: IndicatorConfig(
          sizeIndicator: sizeIndicator,
          indicatorWidget: Container(
            width: sizeIndicator,
            height: 10,
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(4), color: inactiveColor),
          ),
          activeIndicatorWidget: Container(
            width: sizeIndicator,
            height: 10,
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(4), color: activeColor),
          ),
          spaceBetweenIndicator: 10,
          typeIndicatorAnimation: TypeIndicatorAnimation.sliding,
        ),

        renderNextBtn: renderNextBtn(),
        renderPrevBtn: renderPrevBtn(),
        renderSkipBtn: renderSkipBtn(),
        //onNextPress: onNextPress,
        //nextButtonStyle: myButtonStyle(),

        doneButtonStyle: ButtonStyle(
          backgroundColor: MaterialStateProperty.all<Color>(Theme.of(context).colorScheme.primary),
          foregroundColor: MaterialStateProperty.all<Color>(Theme.of(context).colorScheme.onPrimary),
        ),
        nextButtonStyle: ButtonStyle(
          backgroundColor: MaterialStateProperty.all<Color>(Theme.of(context).colorScheme.primary),
          foregroundColor: MaterialStateProperty.all<Color>(Theme.of(context).colorScheme.onPrimary),
        ),
        skipButtonStyle: ButtonStyle(
          backgroundColor: MaterialStateProperty.all<Color>(Theme.of(context).colorScheme.primary),
          foregroundColor: MaterialStateProperty.all<Color>(Theme.of(context).colorScheme.onPrimary),
        ),
        prevButtonStyle: ButtonStyle(
          backgroundColor: MaterialStateProperty.all<Color>(Theme.of(context).colorScheme.primary),
          foregroundColor: MaterialStateProperty.all<Color>(Theme.of(context).colorScheme.onPrimary),
        ),
        listContentConfig: [
          ContentConfig(
            backgroundColor: Theme.of(context).colorScheme.primary,
            title: "Delicious Delivered",
            styleTitle: TextStyle(
              color: Theme.of(context).colorScheme.onPrimary,
              fontSize: 30.0,
              fontWeight: FontWeight.bold,
              fontFamily: 'RobotoMono',
            ),
            description: "Savor the flavors of your favorite restaurants from the comfort of your home. Get ready for a culinary journey like never before with our food delivery app.",
            styleDescription: TextStyle(
              color: Theme.of(context).colorScheme.onPrimary,
              fontSize: 20.0,
              //fontStyle: FontStyle.italic,
              fontFamily: 'Raleway',
            ),
            pathImage: "assets/images/intro/intro1.png",
            maxLineTextDescription: 8,
          ),
          ContentConfig(
            backgroundColor: Theme.of(context).colorScheme.primary,
            title: "Satisfying Cravings",
            styleTitle: TextStyle(
              color: Theme.of(context).colorScheme.onPrimary,
              fontSize: 30.0,
              fontWeight: FontWeight.bold,
              fontFamily: 'RobotoMono',
            ),
            description: "Hungry? With our food delivery app, you're just a few taps away from a feast. Explore a world of cuisine options and have your cravings satisfied in no time.",
            styleDescription: TextStyle(
              color: Theme.of(context).colorScheme.onPrimary,
              fontSize: 20.0,
              //fontStyle: FontStyle.italic,
              fontFamily: 'Raleway',
            ),
            pathImage: "assets/images/intro/intro2.png",
            maxLineTextDescription: 8,
          ),
          ContentConfig(
            backgroundColor: Theme.of(context).colorScheme.primary,
            title: "Effortless Feasting",
            styleTitle: TextStyle(
              color: Theme.of(context).colorScheme.onPrimary,
              fontSize: 30.0,
              fontWeight: FontWeight.bold,
              fontFamily: 'RobotoMono',
            ),
            description: "Experience the perfect blend of convenience and culinary excellence with our food delivery app. Enjoy restaurant-quality meals delivered straight to your doorstep.",
            styleDescription: TextStyle(
              color: Theme.of(context).colorScheme.onPrimary,
              fontSize: 20.0,
              //fontStyle: FontStyle.italic,
              fontFamily: 'Raleway',
            ),
            pathImage: "assets/images/intro/intro3.png",
            maxLineTextDescription: 8,
          ),
          ContentConfig(
            backgroundColor: Theme.of(context).colorScheme.primary,
            title: "Instant Satisfaction",
            styleTitle: TextStyle(
              color: Theme.of(context).colorScheme.onPrimary,
              fontSize: 30.0,
              fontWeight: FontWeight.bold,
              fontFamily: 'RobotoMono',
            ),
            description: "Elevate your dining experience with our food delivery app. Discover a diverse range of dishes, elevate your taste buds, and indulge in gastronomic delights, all from your phone.",
            styleDescription: TextStyle(
              color: Theme.of(context).colorScheme.onPrimary,
              fontSize: 20.0,
              //fontStyle: FontStyle.italic,
              fontFamily: 'Raleway',
            ),
            pathImage: "assets/images/intro/intro4.png",
            maxLineTextDescription: 8,
          ),
        ],
        onDonePress: this.onDonePress,
      ),
    );
  }
}